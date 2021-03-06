---
---

# Matroska Codec - WavPack

<a href="http://www.wavpack.com/">WavPack</a> stores each data in variable length frames. That means each frame can have a different number of samples.

For multi-track files (more than 2 tracks, like for 5.1). A frame consists of many blocks. The first one having the flag `WV_INITIAL_BLOCK` and the last one `WV_FINAL_BLOCK`. For a mono or stereo files, both flags are set in each block.

Each block starts with a header saved in little-endian with the following format :

<pre>
typedef struct PACKED_STRUCTURE {
  char ck_id [4];         // "wvpk"
  uint32_t ck_size;       // size of entire frame (minus 8, of course)
  uint16_t version;       // major &amp; minor version; only supported major version is 4; minor varies with the features used
  uint8_t track_no;       // track number (0 if not used, like now)
  uint8_t index_no;       // remember these? (0 if not used, like now)
  uint32_t total_samples; // for entire file (-1 if unknown)
  uint32_t block_index;   // index of first sample in block (to file begin)
  uint32_t block_samples; // # samples in this block
  uint32_t flags;         // various flags for id and decoding
  uint32_t crc;           // crc for actual decoded data
} wavpack_header_t;
</pre>


WavPack has an hybrid mode. That means the data are encoded in 2 files. The first one has a lossy part and the second file has the correction file that olds the missing data to reconstruct the original file losslessly. Each block in the correction file corresponds to a block in the lossy file with the same number of samples, that's also true for a multi-track file. That means if a frame is made of 4 blocks, the correction file will have 4 blocks in the corresponding frame. The header of the correction block is exactly the same as in the lossy block, except for the crc. In Matroska we store the correction part as an additional data available to the Block (see <a href="../index.html#BlockAdditions">BlockAdditions</a>)


To save space and avoid redundant information in Matroska we remove data from the header when saved in Matroska. All the data are kept in little-endian.

### Lossless &amp; lossy mono/stereo file

<ul><li> CodecPrivate
<pre>
{
  uint16_t version;       // major &amp; minor version; only supported major version is 4; minor varies with the features used
}
</pre></li>
<li> Block
<pre>
{
  uint32_t block_samples; // # samples in this block
  uint32_t flags;         // various flags for id and decoding
  uint32_t crc;           // crc for actual decoded data
}
[ block data ]
</pre></li>
</ul><h3>Hybrid mono/stereo files</h3>
<ul><li> CodecPrivate
<pre>
{
  uint16_t version;       // major &amp; minor version; only supported major version is 4; minor varies with the features used
}
</pre></li>
<li> Block
<pre>
{
  uint32_t block_samples; // # samples in this block
  uint32_t flags;         // various flags for id and decoding
  uint32_t crc;           // crc for actual decoded data
}
[ block data ]
</pre></li>
<li> BlockAdditional (level 1)
<pre>
{
  uint32_t crc;           // crc for actual decoded data
}
[ correction block data ]
</pre></li>
</ul><h3>Lossless &amp; lossy multi-track file</h3>
<ul><li> CodecPrivate
<pre>
{
  uint16_t version;       // major &amp; minor version; only supported major version is 4; minor varies with the features used
}
</pre></li>
<li> Block
<pre>
{
  uint32_t block_samples; // # samples in this block
  uint32_t flags;         // various flags for id and decoding
  uint32_t crc;           // crc for actual decoded data
  uint32_t blocksize;     // size of the data to follow
}
[ block data # 1 ]
{
  uint32_t flags;         // various flags for id and decoding
  uint32_t crc;           // crc for actual decoded data
  uint32_t blocksize;     // size of the data to follow
}
[ block data # 2 ]
{
  uint32_t flags;         // various flags for id and decoding
  uint32_t crc;           // crc for actual decoded data
  uint32_t blocksize;     // size of the data to follow
}
[ block data # 3 ]
...
</pre></li>
</ul>

### Hybrid multi-track files
<ul><li> CodecPrivate
<pre>
{
  uint16_t version;       // major &amp; minor version; only supported major version is 4; minor varies with the features used
}
</pre></li>
<li> Block
<pre>
{
  uint32_t block_samples; // # samples in this block
  uint32_t flags;         // various flags for id and decoding
  uint32_t crc;           // crc for actual decoded data
  uint32_t blocksize;     // size of the data to follow
}
[ block data # 1 ]
{
  uint32_t flags;         // various flags for id and decoding
  uint32_t crc;           // crc for actual decoded data
  uint32_t blocksize;     // size of the data to follow
}
[ block data # 2 ]
{
  uint32_t flags;         // various flags for id and decoding
  uint32_t crc;           // crc for actual decoded data
  uint32_t blocksize;     // size of the data to follow
}
[ block data # 3 ]
...
</pre></li>
<li> BlockAdditional (level 1)
<pre>
{
  uint32_t crc;           // crc for actual decoded data
  uint32_t blocksize;     // size of the data to follow
}
[ correction block data # 1 ]
{
  uint32_t crc;           // crc for actual decoded data
  uint32_t blocksize;     // size of the data to follow
}
[ correction block data # 2 ]
{
  uint32_t crc;           // crc for actual decoded data
  uint32_t blocksize;     // size of the data to follow
}
[ correction block data # 3 ]
...
</pre></li>
</ul>

