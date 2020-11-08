#include <stdio.h>
#include <stdint.h>
#include <math.h>

#define SHOW_ALL_TICKS 0
#define WITH_AUDIO_PACKING   0

static inline uint64_t GCD ( uint64_t a, uint64_t b )
{
    while( b )
    {
        uint64_t c = a % b;
        a = b;
        b = c;
    }
    return a;
}

// integer division, the result is rounded to the closest integer
static inline uint64_t RoundedDivision( uint64_t num, uint64_t div )
{
    return ( num + (div / 2) ) / div;
}


const uint64_t MATROSKA_SCALE = 1000000000;

static const struct {
    uint64_t num, den;
} video_frequency_nums[] = {
    {1001, 30000}, 
    {1,16}, {1001,24000}, 
    {1,24},
    {1000,24000},
    {2000,48000},
    {1,30}, {1001,60000}, {1,48}, {1,60}, {1,90}, {1,100}, {1001,120000}, {1,120},
};

static const struct {
    uint64_t num, den;
} audio_frequency_nums[] = {
    {1, 8000}, 
    {1,11025},
#if WITH_AUDIO_PACKING
    {128,11025},
#endif // WITH_AUDIO_PACKING
    {1,22050}, {1,37800}, {1,44056}, 
    {1,44100}, 
#if WITH_AUDIO_PACKING
    {40,44100}, 
#endif // WITH_AUDIO_PACKING
    {1,48000}, 
#if WITH_AUDIO_PACKING
    {40,48000}, 
#endif // WITH_AUDIO_PACKING
    {1,50400}, {1,88200}, {1,96000}, {1,176400}, {1,192000}, 
    {1,352800},
#if WITH_AUDIO_PACKING
    {40,352800},
    {128,352800},
    {1152,352800},
#endif // WITH_AUDIO_PACKING
};

#define ARRAY_SIZE(a)  (sizeof(a)/sizeof(a[0]))


static int CheckError(int64_t tick, uint64_t TimestampScale, float TrackTimestampScale,
                       uint64_t SamplingFreqNumerator, uint64_t SamplingFreqDenominator,
                       float *error, int display)
{
    float real_timestamp = (float) (tick * SamplingFreqNumerator * MATROSKA_SCALE) / (float) SamplingFreqDenominator;
    uint64_t block_value = round((float)real_timestamp / (TrackTimestampScale * TimestampScale));
    float reconstructed = block_value * TrackTimestampScale * TimestampScale;
    *error = real_timestamp - reconstructed;

    if (block_value >= 0x10000)
    {
        // this value cannot be stored in the 16 bits of a Block
        // printf( "> ENDED prematurly at tick %lli \r\n", tick, block_value );
        return 0;
    }

    if (display)
        printf("%10lli  | %19.1f | %11llu | %14.0f | %8.1f\r\n", tick, real_timestamp, block_value, reconstructed, *error);
    
    return 1;
}

int main(void)
{
    printf("     Audio / Video     | TimestampScale |  GCD  | Audio Scale | Video Scale | Max Audio | Max Video | Audio Errors | Video Errors | 1st Audio Err (tick) |    1st Video Err   \r\n");
    printf("-----------------------|----------------|-------|-------------|-------------|-----------|-----------|--------------|--------------|----------------------|--------------------\r\n");

    for (size_t video_freq_idx = 0; video_freq_idx < ARRAY_SIZE(video_frequency_nums); video_freq_idx ++)
    {
        const uint64_t video_frequency_num = video_frequency_nums[video_freq_idx].num;
        const uint64_t video_frequency_den = video_frequency_nums[video_freq_idx].den;
        
        for (size_t audio_freq_idx = 0; audio_freq_idx < ARRAY_SIZE(audio_frequency_nums); audio_freq_idx ++)
        {
            const uint64_t audio_frequency_num = audio_frequency_nums[audio_freq_idx].num;
            const uint64_t audio_frequency_den = audio_frequency_nums[audio_freq_idx].den;

            // GCD of audio and video denominators
            const uint64_t av_den_gcd = GCD( audio_frequency_den, video_frequency_den );

            // global denominator to use for the TimestampScale
            const uint64_t av_global_den = audio_frequency_den * video_frequency_den / av_den_gcd;
            // TimestampScale to set in the file
            const uint64_t rounded_timestamp_scale = RoundedDivision( MATROSKA_SCALE, av_global_den );
            // TrackTimestampScale to set on the audio track (rounded integer value stored in a float)
            float audio_track_scale = (float) (MATROSKA_SCALE * audio_frequency_num) /  (float)(audio_frequency_den * rounded_timestamp_scale);

            const int display_all = SHOW_ALL_TICKS;

#if WITH_AUDIO_PACKING
            if (audio_frequency_num > 1)
                printf("%6.0f Hz (%llu packed) / Video %3.2f fps\r\n", (float) audio_frequency_den, audio_frequency_num, (float) video_frequency_den / video_frequency_num);
            else
#endif
                printf("%6.0f Hz / %6.2f fps |", (float) audio_frequency_den, (float) video_frequency_den / video_frequency_num);
            printf("%12llu ns |", rounded_timestamp_scale);
            printf(" %5llu |", av_den_gcd);
            printf("%12.3f |", audio_track_scale);

            const float audio_ticks = (float)MATROSKA_SCALE * audio_frequency_num / audio_frequency_den;
            float audio_max_error = 0.0f;

#if SHOW_ALL_TICKS
            printf(" Audio Tick | Real timestamp (ns) | Block Value | Timestamp (ns) | Difference\r\n");
            printf("------------|---------------------|-------------|----------------|-----------\r\n");
#endif
            int64_t audio_max_error_tick = 0;
            size_t audio_errors = 0;
            size_t first_audio_error = 0;
            int64_t audio_tick;
            for (audio_tick=0; audio_tick<0x10000; audio_tick++)
            {
                float difference;
                if (!CheckError(audio_tick, rounded_timestamp_scale, audio_track_scale, audio_frequency_num, audio_frequency_den, &difference, display_all))
                    break;

                if (fabs(difference) > audio_ticks / 2.f)
                {
                    // the rounding of the read timestamp to clock ticks will hit the wrong one
                    audio_errors++;
                    if (first_audio_error == 0)
                        first_audio_error = audio_tick;
                }

                if (audio_max_error < fabs(difference))
                {
                    audio_max_error = fabs(difference);
                    audio_max_error_tick = audio_tick;
                }
            }
            // TrackTimestampScale to set on the video track (rounded integer value stored in a float)
            const float video_track_scale = (float) (MATROSKA_SCALE * video_frequency_num) / (float) (video_frequency_den * rounded_timestamp_scale);

            printf("%12.3f |", video_track_scale);

            const float video_ticks = (float)MATROSKA_SCALE * video_frequency_num / video_frequency_den;
            float video_max_error = 0.0f;

#if SHOW_ALL_TICKS
            printf(" Video Tick | Real timestamp (ns) | Block Value | Timestamp (ns) | Difference\r\n");
            printf("------------|---------------------|-------------|----------------|-----------\r\n");
#endif
            int64_t video_error_tick = 0;
            size_t video_errors = 0;
            size_t first_video_error = 0;
            int64_t video_tick;
            for (video_tick=0; video_tick<0x10000; video_tick++)
            {
                float difference;
                if (!CheckError(video_tick, rounded_timestamp_scale, video_track_scale, video_frequency_num, video_frequency_den, &difference, display_all))
                    break;

                if (fabs(difference) > video_ticks / 2.f)
                {
                    // the rounding of the read timestamp to clock ticks will hit the wrong one
                    video_errors++;
                    if (first_video_error == 0)
                        first_video_error = video_tick;
                }

                if (video_max_error < fabs(difference))
                {
                    video_max_error = fabs(difference);
                    video_error_tick = video_tick;
                }
            }

            printf( "%9.2f s|", (float)audio_tick * audio_frequency_num / audio_frequency_den );
            printf( "%9.2f s|", (float)video_tick * video_frequency_num / video_frequency_den );

            CheckError(audio_max_error_tick, rounded_timestamp_scale, audio_track_scale, audio_frequency_num, audio_frequency_den, &audio_max_error, display_all);
            // printf( "max audio error: %8.0f ns (tick %.0f ns)\r\n", audio_max_error, audio_ticks );
            if (audio_errors == 0)
                printf( "              |");
            else
            {
                printf( "%13zu |", audio_errors );
                float difference;
                CheckError(first_audio_error, rounded_timestamp_scale, audio_track_scale, audio_frequency_num, audio_frequency_den, &difference, display_all);
                // printf( "first audio error: at %zu ticks or %f seconds\r\n", first_audio_error, (float)first_audio_error * audio_frequency_num / audio_frequency_den );
            }

            CheckError(video_error_tick, rounded_timestamp_scale, video_track_scale, video_frequency_num, video_frequency_den, &video_max_error, display_all);
            // printf( "max video error: %8.0f ns (tick %.0f ns)\r\n", video_max_error, video_ticks );
            if (video_errors == 0)
                printf( "              |");
            else
            {
                printf( "%13zu |", video_errors );
                float difference;
                CheckError(first_video_error, rounded_timestamp_scale, video_track_scale, video_frequency_num, video_frequency_den, &difference, display_all);
                // printf( "first video error: at %zu ticks or %f seconds\r\n", first_video_error, (float)first_video_error * video_frequency_num / video_frequency_den );
            }

            if (audio_errors == 0)
                printf( "                      |");
            else
            {
                float difference;
                CheckError(first_audio_error, rounded_timestamp_scale, audio_track_scale, audio_frequency_num, audio_frequency_den, &difference, display_all);
                printf( "%11zu (%5.3f s) |", first_audio_error, (float)first_audio_error * audio_frequency_num / audio_frequency_den );
            }
            if (video_errors == 0)
                printf( "                    ");
            else
            {
                float difference;
                CheckError(first_video_error, rounded_timestamp_scale, video_track_scale, video_frequency_num, video_frequency_den, &difference, display_all);
                printf( "%7zu (%5.3f s)", first_video_error, (float)first_video_error * video_frequency_num / video_frequency_den );
            }

            printf( "\r\n" );
        }
    }
}