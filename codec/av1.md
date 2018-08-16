# AOM AV1 codec mapping in Matroska/WebM

This document specifies the storage format for [AV1](#av1-specifications) bitstreams in [Matroska](#matroska-specifications) tracks. Everytime [Matroska](#referenced-documents) is mentioned it applies equally to [WebM](#webm-container).

Elements in this document inside square brackets __[]__ refer to elements as defined in the [AV1 Specifiations](#av1-specifications).


# Terms

## Block
A Matroska element to store a Frame. Can also be a `SimpleBlock` when not inside a `BlockGroup`. Using `Block` in this document will mean both forms of Block.

## CodecID
The name used to describe a codec in Matroska.

## CVS
A Coded Video Sequence is a sequence of `Temporal Units` where the contents of __[sequence_header_obu]__ must be bit-identical for all the `Sequence Header OBUs` found in the bitstream before Matroska encapsulation except for the contents of __[operating_parameters_info]__. A `Sequence Header OBU` made of all the identical bits in the CVS is referred to a the `CVS Sequence Header OBU`.

## CodecPrivate
Extra data passed to the decoder before decoding starts. It can also be used to store the profiles and other data to better identify the codec.

## OBU
Open Bitstream Unit is the basic unit of data in AV1. It contains a header and a payload.

## Segment
The top Matroska element that contains interleaved audio, video, subtitles as well as track descriptions, chapters, tags, etc. Usually a Matroska file is made of one Segment.

## Temporal Unit
All the OBUs that are associated with a time instant. It consists of a `Temporal Delimiter OBU`, and all the OBUs that follow, up to but not including the next `Temporal Delimiter OBU`.


# TrackEntry elements

## CodecID 
EBML Path: `\Segment\Tracks\TrackEntry\CodecID` | Mandatory: Yes

The `CodecID` MUST be the ASCII string `V_AV1`.

## CodecPrivate
EBML Path: `\Segment\Tracks\TrackEntry\CodecPrivate` | Mandatory: Yes

The `CodecPrivate` consists of 4 octets similar to the first 4 octets of the [ISOBMFF](#isobmff-av1-mapping) `AV1CodecConfigurationBox`. Most of the values in this bitfield come from the `CVS Sequence Header OBU`. The bits are spread as follows, with the most significant bit first:

```
unsigned int marker (1) always 1
unsigned int version (7) currently 1

unsigned int seq_profile (3)
unsigned int seq_level_idx_0 (5)

unsigned int seq_tier_0 (1)
unsigned int high_bitdepth (1)
unsigned int twelve_bit (1)
unsigned int monochrome (1)
unsigned int chroma_subsampling_x (1)
unsigned int chroma_subsampling_y (1)
unsigned int chroma_sample_position (1)
unsigned int reserved (1) currently 0

unsigned int initial_presentation_delay_present (1)
unsigned int initial_presentation_delay_minus_one (4)
unsigned int padding (3)
```

* `seq_profile` corresponds to the __[seq_profile]__ in the `CVS Sequence Header OBU`.
* `seq_level_idx_0` corresponds to the __[seq_level_idx[0]]__ in the `CVS Sequence Header OBU`.
* `seq_tier_0` corresponds to the __[seq_tier[0]]__ in the `CVS Sequence Header OBU`.
* `twelve_bit` corresponds to the __[twelve_bit]__ in the `CVS Sequence Header OBU`.
* `monochrome` corresponds to the __[mono_chrome]__ in the `CVS Sequence Header OBU`.
* `chroma_subsampling_x` corresponds to the __[subsampling_x]__ in the `CVS Sequence Header OBU`.
* `chroma_subsampling_y` corresponds to the __[subsampling_y]__ in the `CVS Sequence Header OBU`.
* `chroma_sample_position` corresponds to the __[chroma_sample_position]__ in the `CVS Sequence Header OBU`.

The `initial_presentation_delay_minus_one` field indicates the number of samples (minus one) that need to be decoded prior to starting the presentation of the first sample associated with this sample entry in order to guarantee that each sample will be decoded prior to its presentation time under the constraints of the first level value indicated by `seq_level_idx` in the `CVS Sequence Header OBU`. More precisely, the following procedure SHALL not return any error:
- construct a hypothetical bitstream consisting of the OBUs carried in the sample entry followed by the OBUs carried in all the samples referring to that sample entry,
- set the first __[initial_display_delay_minus_1]__ field of each `Sequence Header OBU` to the number of frames minus one contained in the first `initial_presentation_delay_minus_one` + 1 samples,
- set the __[frame_presentation_time]__ field of the frame header of each presentable frame such that it matches the presentation time difference between the sample carrying this frame and the previous sample (if it exists, 0 otherwise),
- apply the decoder model specified in [AV1](#av1-specifications) to this hypothetical bitstream using the first operating point. If __[buffer_removal_time]__ information is present in bitstream for this operating point, the decoding schedule mode SHALL be applied, otherwise the resource availability mode SHALL be applied.

If an muxer cannot verify the above procedure, `initial_presentation_delay_present` MUST be set to 0.

If `initial_presentation_delay_present` is 0 then all bits of `initial_presentation_delay_minus_one` SHOULD be 0 and MUST be discarded.

## PixelWidth
EBML Path: `\Segment\Tracks\TrackEntry\Video\PixelWidth` | Mandatory: Yes

The `PixelWidth` MUST be __[max_frame_width_minus_1]__+1.

## PixelHeight
EBML Path: `\Segment\Tracks\TrackEntry\Video\PixelHeight` | Mandatory: Yes

The `PixelHeight` MUST be __[max_frame_height_minus_1]__+1.

## DisplayWidth
EBML Path: `\Segment\Tracks\TrackEntry\Video\DisplayWidth` | Mandatory: No

If custom aspect ratio, crop values are not needed and the `DisplayUnit` is in pixels, the `DisplayWidth` SHOULD be __[render_width_minus_1]__+1 if __[render_and_frame_size_different]__ is 1 and __[max_frame_width_minus_1]__+1 otherwise.

*Note: in Matroska the `DisplayWidth` doesn't have to be written if it's the same value as the `PixelWidth`*

## DisplayHeight
EBML Path: `\Segment\Tracks\TrackEntry\Video\DisplayHeight` | Mandatory: No

If custom aspect ratio, crop values are not needed and the `DisplayUnit` is in pixels, the `DisplayHeight` SHOULD be __[render_height_minus_1]__+1 if __[render_and_frame_size_different]__ is 1 and __[max_frame_height_minus_1]__+1 otherwise.

*Note: in Matroska the `DisplayHeight` doesn't have to be written if it's the same value as the `PixelHeight`*


# Block Data
Each `Block` contains one `Temporal Unit` containing one or more OBUs. Each OBU stored in the Block MUST contain its header and its payload. 

The OBUs in the `Block` follow the __[Low Overhead Bitstream Format syntax]__. They SHOULD have the __[obu_has_size_field]__ set to 1 except for the last OBU in the sample, for which __[obu_has_size_field]__ MAY be set to 0, in which case it is assumed to fill the remaining of the sample.

The order of OBUs should follow the order defined in the section 7.5 of the [AV1 Specifiations](#av1-specifications).

There MUST be at least one `Frame Header OBU` per `Block`.

The `Temporal Delimiter OBU` MUST be omitted.

The `Padding OBUs` SHOULD be omitted if encryption is not used.

The `Redundant Frame Header OBUs` SHOULD not be used.

OBU trailing bits SHOULD be limited to byte alignment and SHOULD not be used for padding.

`Sequence Header OBUs` SHOULD be omitted when they are bit-identical to the one found in `CodecPrivate` and __[decoder_model_info_present_flag]__ is 0 and the previous `Sequence Header OBUs` in the bistream, if any, was also bit-identical to the one found in `CodecPrivate`. They can be kept when encryption constraints require it.

A `SimpleBlock` MUST NOT be marked as a Keyframe if it doesn't contain a `Frame OBU`. A `SimpleBlock` MUST NOT be marked as a Keyframe if the first `Frame OBU` doesn't have a __[frame_type]__ of `KEY_FRAME`. A `SimpleBlock` MUST NOT be marked as a Keyframe if it doesn't contains a `Sequence Header OBU` unless the `Sequence Header OBU` is correctly omitted (see above).

A `Block` inside a `BlockGroup` MUST use `ReferenceBlock` elements if the first `Frame OBU` in the `Block` has a __[frame_type]__ other than `KEY_FRAME` or the `Block` doesn't contain a `Sequence Header OBU` when it should not be omitted.

A `Block` with __[frame_header_obu]__ where the __[frame_type]__  is `INTRA_ONLY_FRAME` MUST use a `ReferenceBlock` with a value of 0 to reference itself. This way it cannot be mistaken for a random access point.

`ReferenceBlocks` inside a `BlockGroup` MUST reference frames according to the __[ref_frame_idx]__ values of frame that is neither a `KEYFRAME` nor an `INTRA_ONLY_FRAME`.

*Note: `SimpleBlock` and `BlockGroup` can be used for each type of frame. `SimpleBlock` is usually preferred if features of the `BlockGroup` (`BlockDuration`, `BlockAdditions`, etc) are not needed.*

The __[temporal_point_info]__ contained in  `Frame OBUs` or `Frame Header OBUs` SHOULD be discarded.

The `Block` timestamp is translated from the __[PresentationTime]__ without the __[InitialPresentationDelay]__.


# Segment Restrictions

Matroska restricts the allowed changes within a codec for the whole `Segment`. Each output frames of a `Segment` MUST have the same pixel dimensions (`PixelWidth` and `PixelHeight`).

The first `Sequence Header OBU` of a `CVS` is stored in the `CodecPrivate` of a `Track`. This AV1 `Track` has the same requirements as the `CVS`: the contents of __[sequence_header_obu]__ must be bit-identical for all the `Sequence Header OBUs` found in the bitstream before Matroska encapsulation except for the contents of __[operating_parameters_info]__ which can vary.

If the __[decoder_model_info_present_flag]__ of this `Sequence Header OBU` is set to 1 then each keyframe `Block` MUST contain a `Sequence Header OBU` before the `Frame Header OBUs`.

Given a `Sequence Header OBU` can be omitted from a `Block` if __[decoder_model_info_present_flag]__ is 0 and it is bit identical to the one found in `CodecPrivate`, when seeking to a keyframe, that omitted `Sequence Header OBU` MUST be added back to the bitstream for compliance with the Random Access Decoding section of the [AV1 Specifiations](#av1-specifications).


# Cue Considerations

Matroska uses `CuePoints` for seeking. Each `Block` can be referenced in the `Cues` but in practice it's better to only seek to proper random access points of the codec. It means only `SimpleBlock` marked as Keyframe and `BlockGroup` with no `ReferenceBlock` SHOULD be referenced in the `Cues`.


# Encryption

[Common Encryption] should be used to encrypt AV1 tracks. `cenc` and `cbcs` scheme types are permitted.

The OBUs found in the `CodecPrivate` SHOULD not be encrypted.

The OBUs found in the `Block` SHOULD only encrypt the OBU payload. The payload of `Sequence Header OBUs` and `Metadata OBUs` SHOULD not be encrypted.

Tile Group OBUs, Frame OBUs and Tile List OBUs SHOULD be encrypted using Subsample Encryption.


# More TrackEntry mappings

The elements described in the main `TrackEntry` section are vital for correct playback. Here we present a list of elements found in a `TrackEntry` that SHOULD also be mapped from the data found in the `CVS Sequence Header OBU` and the `Metadata OBUs`, all found in the `CodecPrivate`.

## DefaultDuration
EBML Path: `\Segment\Tracks\TrackEntry\DefaultDuration` | Mandatory: No

The `DefaultDuration` MAY be used if __[timing_info_present_flag]__ and __[equal_picture_interval]__ are set to 1.

## Colour Range
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\Range` | Mandatory: No

The `Range` corresponds to the __[color_range]__.
* 0 (Studio) in AV1 corresponds to 1 in Matroska
* 1 (Full) in AV1 corresponds to 2 in Matroska

## BitsPerChannel
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\BitsPerChannel` | Mandatory: No

The `BitsPerChannel` corresponds to the __[BitDepth]__ of the Sequence Header OBU found in the `CodecPrivate`.

## MatrixCoefficients
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MatrixCoefficients` | Mandatory: No

The `MatrixCoefficients` corresponds to the __[matrix_coefficients]__ of the Sequence Header OBU found in the `CodecPrivate`. Some values MAY not map correctly to values found in Matroska.

## ChromaSitingHorz
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\ChromaSitingHorz` | Mandatory: No

`ChromaSitingHorz` is deduced from __[chroma_sample_position]__:
* 0 in AV1 corresponds to 0 in Matroska
* 1 in AV1 corresponds to 1 in Matroska
* 2 in AV1 corresponds to 1 in Matroska
* 3 in AV1 corresponds to 0 in Matroska

## ChromaSitingVert
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\ChromaSitingVert` | Mandatory: No

`ChromaSitingVert` is deduced from __[chroma_sample_position]__:
* 0 in AV1 corresponds to 0 in Matroska
* 1 in AV1 corresponds to 2 in Matroska
* 2 in AV1 corresponds to 1 in Matroska
* 3 in AV1 corresponds to 0 in Matroska

## TransferCharacteristics
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\TransferCharacteristics` | Mandatory: No

The `TransferCharacteristics` corresponds to the __[transfer_characteristics]__ of the Sequence Header OBU found in the `CodecPrivate`.

## Primaries
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\Primaries` | Mandatory: No

The `Primaries` corresponds to the __[color_primaries]__ of the Sequence Header OBU found in the `CodecPrivate`. Some values MAY not map correctly to values found in Matroska.

## MaxCLL
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MaxCLL` | Mandatory: No

The `MaxCLL` corresponds to __[max_cll]__ of the Metadata OBU of type METADATA_TYPE_HDR_CLL that MAY be found in the `CodecPrivate`.

## MaxFALL
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MaxFALL` | Mandatory: No

The `MaxFALL` corresponds to __[max_fall]__ of the Metadata OBU of type METADATA_TYPE_HDR_CLL that MAY be found in the `CodecPrivate`.

## PrimaryRChromaticityX
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MasteringMetadata\PrimaryRChromaticityX` | Mandatory: No

The `PrimaryRChromaticityX` corresponds to __[primary_chromaticity_x[0]]__ of the Metadata OBU of type METADATA_TYPE_HDR_MDCV that MAY be found in the `CodecPrivate`.

## PrimaryRChromaticityY
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MasteringMetadata\PrimaryRChromaticityY` | Mandatory: No

The `PrimaryRChromaticityX` corresponds to __[primary_chromaticity_y[0]]__ of the Metadata OBU of type METADATA_TYPE_HDR_MDCV that MAY be found in the `CodecPrivate`.

## PrimaryGChromaticityX
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MasteringMetadata\PrimaryGChromaticityX` | Mandatory: No

The `PrimaryRChromaticityX` corresponds to __[primary_chromaticity_x[1]]__ of the Metadata OBU of type METADATA_TYPE_HDR_MDCV that MAY be found in the `CodecPrivate`.

## PrimaryGChromaticityY
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MasteringMetadata\PrimaryGChromaticityY` | Mandatory: No

The `PrimaryRChromaticityX` corresponds to __[primary_chromaticity_y[1]]__ of the Metadata OBU of type METADATA_TYPE_HDR_MDCV that MAY be found in the `CodecPrivate`.

## PrimaryBChromaticityX
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MasteringMetadata\PrimaryBChromaticityX` | Mandatory: No

The `PrimaryRChromaticityX` corresponds to __[primary_chromaticity_x[2]]__ of the Metadata OBU of type METADATA_TYPE_HDR_MDCV that MAY be found in the `CodecPrivate`.

## PrimaryBChromaticityY
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MasteringMetadata\PrimaryBChromaticityY` | Mandatory: No

The `PrimaryRChromaticityX` corresponds to __[primary_chromaticity_y[2]]__ of the Metadata OBU of type METADATA_TYPE_HDR_MDCV that MAY be found in the `CodecPrivate`.

## WhitePointChromaticityX
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MasteringMetadata\WhitePointChromaticityX` | Mandatory: No

The `WhitePointChromaticityX` corresponds to __[white_point_chromaticity_x]__ of the Metadata OBU of type METADATA_TYPE_HDR_MDCV that MAY be found in the `CodecPrivate`.

## WhitePointChromaticityY
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MasteringMetadata\WhitePointChromaticityY` | Mandatory: No

The `WhitePointChromaticityY` corresponds to __[white_point_chromaticity_y]__ of the Metadata OBU of type METADATA_TYPE_HDR_MDCV that MAY be found in the `CodecPrivate`.

## LuminanceMin
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MasteringMetadata\LuminanceMin` | Mandatory: No

The `LuminanceMin` corresponds to __[luminance_min]__ of the Metadata OBU of type METADATA_TYPE_HDR_MDCV that MAY be found in the `CodecPrivate`.

## LuminanceMax
EBML Path: `\Segment\Tracks\TrackEntry\Video\Colour\MasteringMetadata\LuminanceMax` | Mandatory: No

The `LuminanceMin` corresponds to __[luminance_max]__ of the Metadata OBU of type METADATA_TYPE_HDR_MDCV that MAY be found in the `CodecPrivate`.

## ContentCompSettings
EBML Path: `\Segment\Tracks\TrackEntry\ContentEncodings\ContentEncoding\ContentCompression\ContentCompSettings` | Mandatory: No

It MAY be convenient to put the first OBUs that starts each `Temporal Unit`, excluding the `Temporal Delimiter OBU`, in the `ContentCompSettings` to save space. These will be added before each `Block` data when feeding the decoder and thus MUST have the same binary value for each `Block`.


# Referenced documents

## AV1 Specifications
Official PDF: https://aomediacodec.github.io/av1-spec/av1-spec.pdf


## Matroska Specifications
IETF draft: https://datatracker.ietf.org/doc/draft-lhomme-cellar-matroska/

Original Specifications: https://matroska.org/technical/specs/index.html


## ISOBMFF AV1 mapping
AV1 Codec ISO Media File Format Binding: https://aomediacodec.github.io/av1-isobmff/


## WebM Container
Official Specification based on the Matroska specifications: https://www.webmproject.org/docs/container/


# Document version

This is version 1 of this document.