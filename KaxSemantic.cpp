/**********************************************************************
**  DO NOT EDIT, GENERATED WITH schema_2_kaxsemantic_cpp.xsl
**  https://github.com/Matroska-Org/foundation-source/tree/master/spectool
**
**  libmatroska : parse Matroska files, see http://www.matroska.org/
**
**  Copyright (c) 2002-2019, Matroska (non-profit organisation)
**  All rights reserved.
**
** This file is part of libmatroska.
**
** This library is free software; you can redistribute it and/or
** modify it under the terms of the GNU Lesser General Public
** License as published by the Free Software Foundation; either
** version 2.1 of the License, or (at your option) any later version.
**
** This library is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
** Lesser General Public License for more details.
**
** You should have received a copy of the GNU Lesser General Public
** License along with this library; if not, write to the Free Software
** Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
**
** See http://www.gnu.org/licenses/lgpl-2.1.html for LGPL licensing information.**
** Contact license@matroska.org if any conditions of this licensing are
** not clear to you.
**
**********************************************************************/

#include "matroska/KaxContexts.h"
#include "matroska/KaxSemantic.h"
#include "matroska/KaxSegment.h"
#include "matroska/KaxSeekHead.h"
#include "matroska/KaxCluster.h"
#include "matroska/KaxTracks.h"
#include "matroska/KaxCues.h"
#include "matroska/KaxInfoData.h"
#include "matroska/KaxBlockData.h"
#include "matroska/KaxCuesData.h"

START_LIBMATROSKA_NAMESPACE

DEFINE_START_SEMANTIC(KaxSegment)
DEFINE_SEMANTIC_ITEM(false, false, KaxSeekHead)
DEFINE_SEMANTIC_ITEM(true, false, KaxInfo)
DEFINE_SEMANTIC_ITEM(false, false, KaxCluster)
DEFINE_SEMANTIC_ITEM(false, false, KaxTracks)
DEFINE_SEMANTIC_ITEM(false, true, KaxCues)
DEFINE_SEMANTIC_ITEM(false, true, KaxAttachments)
DEFINE_SEMANTIC_ITEM(false, true, KaxChapters)
DEFINE_SEMANTIC_ITEM(false, false, KaxTags)
DEFINE_END_SEMANTIC(KaxSegment)

DEFINE_MKX_MASTER_ORPHAN(KaxSegment, 0x18538067, 4, "Segment")

DEFINE_START_SEMANTIC(KaxAttachments)
DEFINE_SEMANTIC_ITEM(true, false, KaxAttached)
DEFINE_END_SEMANTIC(KaxAttachments)

DEFINE_MKX_MASTER_CONS(KaxAttachments, 0x1941A469, 4, KaxSegment, "Attachments")

DEFINE_START_SEMANTIC(KaxAttached)
DEFINE_SEMANTIC_ITEM(false, true, KaxFileDescription)
DEFINE_SEMANTIC_ITEM(true, true, KaxFileName)
DEFINE_SEMANTIC_ITEM(true, true, KaxMimeType)
DEFINE_SEMANTIC_ITEM(true, true, KaxFileData)
DEFINE_SEMANTIC_ITEM(true, true, KaxFileUID)
DEFINE_SEMANTIC_ITEM(false, true, KaxFileReferral)
DEFINE_SEMANTIC_ITEM(false, true, KaxFileUsedStartTime)
DEFINE_SEMANTIC_ITEM(false, true, KaxFileUsedEndTime)
DEFINE_END_SEMANTIC(KaxAttached)

DEFINE_MKX_MASTER_CONS(KaxAttached, 0x61A7, 2, KaxAttachments, "AttachedFile")

DEFINE_START_SEMANTIC(KaxChapters)
DEFINE_SEMANTIC_ITEM(true, false, KaxEditionEntry)
DEFINE_END_SEMANTIC(KaxChapters)

DEFINE_MKX_MASTER(KaxChapters, 0x1043A770, 4, KaxSegment, "Chapters")

DEFINE_START_SEMANTIC(KaxEditionEntry)
DEFINE_SEMANTIC_ITEM(false, true, KaxEditionUID)
DEFINE_SEMANTIC_ITEM(true, true, KaxEditionFlagHidden)
DEFINE_SEMANTIC_ITEM(true, true, KaxEditionFlagDefault)
DEFINE_SEMANTIC_ITEM(false, true, KaxEditionFlagOrdered)
DEFINE_SEMANTIC_ITEM(true, false, KaxChapterAtom)
DEFINE_END_SEMANTIC(KaxEditionEntry)

DEFINE_MKX_MASTER(KaxEditionEntry, 0x45B9, 2, KaxChapters, "EditionEntry")

DEFINE_START_SEMANTIC(KaxChapterAtom)
DEFINE_SEMANTIC_ITEM(false, false, KaxChapterAtom) // recursive
DEFINE_SEMANTIC_ITEM(true, true, KaxChapterUID)
DEFINE_SEMANTIC_ITEM(false, true, KaxChapterStringUID)
DEFINE_SEMANTIC_ITEM(true, true, KaxChapterTimeStart)
DEFINE_SEMANTIC_ITEM(false, true, KaxChapterTimeEnd)
DEFINE_SEMANTIC_ITEM(true, true, KaxChapterFlagHidden)
DEFINE_SEMANTIC_ITEM(true, true, KaxChapterFlagEnabled)
DEFINE_SEMANTIC_ITEM(false, true, KaxChapterSegmentUID)
DEFINE_SEMANTIC_ITEM(false, true, KaxChapterSegmentEditionUID)
DEFINE_SEMANTIC_ITEM(false, true, KaxChapterPhysicalEquiv)
DEFINE_SEMANTIC_ITEM(false, true, KaxChapterTrack)
DEFINE_SEMANTIC_ITEM(false, false, KaxChapterDisplay)
DEFINE_SEMANTIC_ITEM(false, false, KaxChapterProcess)
DEFINE_END_SEMANTIC(KaxChapterAtom)

DEFINE_MKX_MASTER(KaxChapterAtom, 0xB6, 1, KaxEditionEntry, "ChapterAtom")

DEFINE_START_SEMANTIC(KaxChapterProcess)
DEFINE_SEMANTIC_ITEM(true, true, KaxChapterProcessCodecID)
DEFINE_SEMANTIC_ITEM(false, true, KaxChapterProcessPrivate)
DEFINE_SEMANTIC_ITEM(false, false, KaxChapterProcessCommand)
DEFINE_END_SEMANTIC(KaxChapterProcess)

DEFINE_MKX_MASTER(KaxChapterProcess, 0x6944, 2, KaxChapterAtom, "ChapProcess")

DEFINE_START_SEMANTIC(KaxChapterProcessCommand)
DEFINE_SEMANTIC_ITEM(true, true, KaxChapterProcessTime)
DEFINE_SEMANTIC_ITEM(true, true, KaxChapterProcessData)
DEFINE_END_SEMANTIC(KaxChapterProcessCommand)

DEFINE_MKX_MASTER(KaxChapterProcessCommand, 0x6911, 2, KaxChapProcess, "ChapProcessCommand")

DEFINE_START_SEMANTIC(KaxChapterDisplay)
DEFINE_SEMANTIC_ITEM(true, true, KaxChapterString)
DEFINE_SEMANTIC_ITEM(true, false, KaxChapterLanguage)
DEFINE_SEMANTIC_ITEM(false, false, KaxChapLanguageIETF)
DEFINE_SEMANTIC_ITEM(false, false, KaxChapterCountry)
DEFINE_END_SEMANTIC(KaxChapterDisplay)

DEFINE_MKX_MASTER(KaxChapterDisplay, 0x80, 1, KaxChapterAtom, "ChapterDisplay")

DEFINE_START_SEMANTIC(KaxChapterTrack)
DEFINE_SEMANTIC_ITEM(true, false, KaxChapterTrackNumber)
DEFINE_END_SEMANTIC(KaxChapterTrack)

DEFINE_MKX_MASTER(KaxChapterTrack, 0x8F, 1, KaxChapterAtom, "ChapterTrack")

DEFINE_START_SEMANTIC(KaxCluster)
DEFINE_SEMANTIC_ITEM(true, true, KaxClusterTimecode)
DEFINE_SEMANTIC_ITEM(false, true, KaxClusterSilentTracks)
DEFINE_SEMANTIC_ITEM(false, true, KaxClusterPosition)
DEFINE_SEMANTIC_ITEM(false, true, KaxClusterPrevSize)
DEFINE_SEMANTIC_ITEM(false, false, KaxSimpleBlock)
DEFINE_SEMANTIC_ITEM(false, false, KaxBlockGroup)
DEFINE_SEMANTIC_ITEM(false, false, KaxEncryptedBlock)
DEFINE_END_SEMANTIC(KaxCluster)

DEFINE_MKX_MASTER(KaxCluster, 0x1F43B675, 4, KaxSegment, "Cluster")

DEFINE_START_SEMANTIC(KaxBlockGroup)
DEFINE_SEMANTIC_ITEM(true, true, KaxBlock)
DEFINE_SEMANTIC_ITEM(false, true, KaxBlockVirtual)
DEFINE_SEMANTIC_ITEM(false, true, KaxBlockAdditions)
DEFINE_SEMANTIC_ITEM(false, true, KaxBlockDuration)
DEFINE_SEMANTIC_ITEM(true, true, KaxReferencePriority)
DEFINE_SEMANTIC_ITEM(false, false, KaxReferenceBlock)
DEFINE_SEMANTIC_ITEM(false, true, KaxReferenceVirtual)
DEFINE_SEMANTIC_ITEM(false, true, KaxCodecState)
DEFINE_SEMANTIC_ITEM(false, true, KaxDiscardPadding)
DEFINE_SEMANTIC_ITEM(false, true, KaxSlices)
DEFINE_SEMANTIC_ITEM(false, true, KaxReferenceFrame)
DEFINE_END_SEMANTIC(KaxBlockGroup)

DEFINE_MKX_MASTER(KaxBlockGroup, 0xA0, 1, KaxCluster, "BlockGroup")

DEFINE_START_SEMANTIC(KaxBlockAdditions)
DEFINE_SEMANTIC_ITEM(true, false, KaxBlockMore)
DEFINE_END_SEMANTIC(KaxBlockAdditions)

DEFINE_MKX_MASTER(KaxBlockAdditions, 0x75A1, 2, KaxBlockGroup, "BlockAdditions")

DEFINE_START_SEMANTIC(KaxBlockMore)
DEFINE_SEMANTIC_ITEM(true, true, KaxBlockAddID)
DEFINE_SEMANTIC_ITEM(true, true, KaxBlockAdditional)
DEFINE_END_SEMANTIC(KaxBlockMore)

DEFINE_MKX_MASTER(KaxBlockMore, 0xA6, 1, KaxBlockAdditions, "BlockMore")

DEFINE_START_SEMANTIC(KaxReferenceFrame)
DEFINE_SEMANTIC_ITEM(true, true, KaxReferenceOffset)
DEFINE_SEMANTIC_ITEM(true, true, KaxReferenceTimeCode)
DEFINE_END_SEMANTIC(KaxReferenceFrame)

DEFINE_MKX_MASTER(KaxReferenceFrame, 0xC8, 1, KaxBlockGroup, "ReferenceFrame")

DEFINE_START_SEMANTIC(KaxSlices)
DEFINE_SEMANTIC_ITEM(false, false, KaxTimeSlice)
DEFINE_END_SEMANTIC(KaxSlices)

DEFINE_MKX_MASTER(KaxSlices, 0x8E, 1, KaxBlockGroup, "Slices")

DEFINE_START_SEMANTIC(KaxTimeSlice)
DEFINE_SEMANTIC_ITEM(false, true, KaxSliceLaceNumber)
DEFINE_SEMANTIC_ITEM(false, true, KaxSliceFrameNumber)
DEFINE_SEMANTIC_ITEM(false, true, KaxSliceBlockAddID)
DEFINE_SEMANTIC_ITEM(false, true, KaxSliceDelay)
DEFINE_SEMANTIC_ITEM(false, true, KaxSliceDuration)
DEFINE_END_SEMANTIC(KaxTimeSlice)

DEFINE_MKX_MASTER(KaxTimeSlice, 0xE8, 1, KaxSlices, "TimeSlice")

DEFINE_START_SEMANTIC(KaxClusterSilentTracks)
DEFINE_SEMANTIC_ITEM(false, false, KaxClusterSilentTrackNumber)
DEFINE_END_SEMANTIC(KaxClusterSilentTracks)

DEFINE_MKX_MASTER(KaxClusterSilentTracks, 0x5854, 2, KaxCluster, "SilentTracks")

DEFINE_START_SEMANTIC(KaxCues)
DEFINE_SEMANTIC_ITEM(true, false, KaxCuePoint)
DEFINE_END_SEMANTIC(KaxCues)

DEFINE_MKX_MASTER(KaxCues, 0x1C53BB6B, 4, KaxSegment, "Cues")

DEFINE_START_SEMANTIC(KaxCuePoint)
DEFINE_SEMANTIC_ITEM(true, true, KaxCueTime)
DEFINE_SEMANTIC_ITEM(true, false, KaxCueTrackPositions)
DEFINE_END_SEMANTIC(KaxCuePoint)

DEFINE_MKX_MASTER(KaxCuePoint, 0xBB, 1, KaxCues, "CuePoint")

DEFINE_START_SEMANTIC(KaxCueTrackPositions)
DEFINE_SEMANTIC_ITEM(true, true, KaxCueTrack)
DEFINE_SEMANTIC_ITEM(true, true, KaxCueClusterPosition)
DEFINE_SEMANTIC_ITEM(false, true, KaxCueRelativePosition)
DEFINE_SEMANTIC_ITEM(false, true, KaxCueDuration)
DEFINE_SEMANTIC_ITEM(false, true, KaxCueBlockNumber)
DEFINE_SEMANTIC_ITEM(false, true, KaxCueCodecState)
DEFINE_SEMANTIC_ITEM(false, false, KaxCueReference)
DEFINE_END_SEMANTIC(KaxCueTrackPositions)

DEFINE_MKX_MASTER(KaxCueTrackPositions, 0xB7, 1, KaxCuePoint, "CueTrackPositions")

DEFINE_START_SEMANTIC(KaxCueReference)
DEFINE_SEMANTIC_ITEM(true, true, KaxCueRefTime)
DEFINE_SEMANTIC_ITEM(true, true, KaxCueRefCluster)
DEFINE_SEMANTIC_ITEM(false, true, KaxCueRefNumber)
DEFINE_SEMANTIC_ITEM(false, true, KaxCueRefCodecState)
DEFINE_END_SEMANTIC(KaxCueReference)

DEFINE_MKX_MASTER(KaxCueReference, 0xDB, 1, KaxCueTrackPositions, "CueReference")

DEFINE_START_SEMANTIC(KaxInfo)
DEFINE_SEMANTIC_ITEM(false, true, KaxSegmentUID)
DEFINE_SEMANTIC_ITEM(false, true, KaxSegmentFilename)
DEFINE_SEMANTIC_ITEM(false, true, KaxPrevUID)
DEFINE_SEMANTIC_ITEM(false, true, KaxPrevFilename)
DEFINE_SEMANTIC_ITEM(false, true, KaxNextUID)
DEFINE_SEMANTIC_ITEM(false, true, KaxNextFilename)
DEFINE_SEMANTIC_ITEM(false, false, KaxSegmentFamily)
DEFINE_SEMANTIC_ITEM(false, false, KaxChapterTranslate)
DEFINE_SEMANTIC_ITEM(true, true, KaxTimecodeScale)
DEFINE_SEMANTIC_ITEM(false, true, KaxDuration)
DEFINE_SEMANTIC_ITEM(false, true, KaxDateUTC)
DEFINE_SEMANTIC_ITEM(false, true, KaxTitle)
DEFINE_SEMANTIC_ITEM(true, true, KaxMuxingApp)
DEFINE_SEMANTIC_ITEM(true, true, KaxWritingApp)
DEFINE_END_SEMANTIC(KaxInfo)

DEFINE_MKX_MASTER(KaxInfo, 0x1549A966, 4, KaxSegment, "Info")

DEFINE_START_SEMANTIC(KaxChapterTranslate)
DEFINE_SEMANTIC_ITEM(false, false, KaxChapterTranslateEditionUID)
DEFINE_SEMANTIC_ITEM(true, true, KaxChapterTranslateCodec)
DEFINE_SEMANTIC_ITEM(true, true, KaxChapterTranslateID)
DEFINE_END_SEMANTIC(KaxChapterTranslate)

DEFINE_MKX_MASTER(KaxChapterTranslate, 0x6924, 2, KaxInfo, "ChapterTranslate")

DEFINE_START_SEMANTIC(KaxSeekHead)
DEFINE_SEMANTIC_ITEM(true, false, KaxSeek)
DEFINE_END_SEMANTIC(KaxSeekHead)

DEFINE_MKX_MASTER(KaxSeekHead, 0x114D9B74, 4, KaxSegment, "SeekHead")

DEFINE_START_SEMANTIC(KaxSeek)
DEFINE_SEMANTIC_ITEM(true, true, KaxSeekID)
DEFINE_SEMANTIC_ITEM(true, true, KaxSeekPosition)
DEFINE_END_SEMANTIC(KaxSeek)

DEFINE_MKX_MASTER(KaxSeek, 0x4DBB, 2, KaxSegment, "Seek")

DEFINE_START_SEMANTIC(KaxTags)
DEFINE_SEMANTIC_ITEM(true, false, KaxTag)
DEFINE_END_SEMANTIC(KaxTags)

DEFINE_MKX_MASTER(KaxTags, 0x1254C367, 4, KaxSegment, "Tags")

DEFINE_START_SEMANTIC(KaxTag)
DEFINE_SEMANTIC_ITEM(true, true, KaxTagTargets)
DEFINE_SEMANTIC_ITEM(true, false, KaxTagSimple)
DEFINE_END_SEMANTIC(KaxTag)

DEFINE_MKX_MASTER(KaxTag, 0x7373, 2, KaxSegment, "Tag")

DEFINE_START_SEMANTIC(KaxTagSimple)
DEFINE_SEMANTIC_ITEM(false, false, KaxTagSimple) // recursive
DEFINE_SEMANTIC_ITEM(true, true, KaxTagName)
DEFINE_SEMANTIC_ITEM(true, true, KaxTagLangue)
DEFINE_SEMANTIC_ITEM(false, true, KaxTagLanguageIETF)
DEFINE_SEMANTIC_ITEM(true, true, KaxTagDefault)
DEFINE_SEMANTIC_ITEM(false, true, KaxTagString)
DEFINE_SEMANTIC_ITEM(false, true, KaxTagBinary)
DEFINE_END_SEMANTIC(KaxTagSimple)

DEFINE_MKX_MASTER(KaxTagSimple, 0x67C8, 2, KaxTag, "SimpleTag")

DEFINE_START_SEMANTIC(KaxTagTargets)
DEFINE_SEMANTIC_ITEM(false, true, KaxTagTargetTypeValue)
DEFINE_SEMANTIC_ITEM(false, true, KaxTagTargetType)
DEFINE_SEMANTIC_ITEM(false, false, KaxTagTrackUID)
DEFINE_SEMANTIC_ITEM(false, false, KaxTagEditionUID)
DEFINE_SEMANTIC_ITEM(false, false, KaxTagChapterUID)
DEFINE_SEMANTIC_ITEM(false, false, KaxTagAttachmentUID)
DEFINE_END_SEMANTIC(KaxTagTargets)

DEFINE_MKX_MASTER(KaxTagTargets, 0x63C0, 2, KaxTag, "Targets")

DEFINE_START_SEMANTIC(KaxTracks)
DEFINE_SEMANTIC_ITEM(true, false, KaxTrackEntry)
DEFINE_END_SEMANTIC(KaxTracks)

DEFINE_MKX_MASTER(KaxTracks, 0x1654AE6B, 4, KaxSegment, "Tracks")

DEFINE_START_SEMANTIC(KaxTrackEntry)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackNumber)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackUID)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackType)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackFlagEnabled)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackFlagDefault)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackFlagForced)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackFlagLacing)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackMinCache)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrackMaxCache)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrackDefaultDuration)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrackDefaultDecodedFieldDuration)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackTimecodeScale)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrackOffset)
DEFINE_SEMANTIC_ITEM(true, true, KaxMaxBlockAdditionID)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrackName)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrackLanguage)
DEFINE_SEMANTIC_ITEM(false, true, KaxLanguageIETF)
DEFINE_SEMANTIC_ITEM(true, true, KaxCodecID)
DEFINE_SEMANTIC_ITEM(false, true, KaxCodecPrivate)
DEFINE_SEMANTIC_ITEM(false, true, KaxCodecName)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrackAttachmentLink)
DEFINE_SEMANTIC_ITEM(false, true, KaxCodecSettings)
DEFINE_SEMANTIC_ITEM(false, false, KaxCodecInfoURL)
DEFINE_SEMANTIC_ITEM(false, false, KaxCodecDownloadURL)
DEFINE_SEMANTIC_ITEM(true, true, KaxCodecDecodeAll)
DEFINE_SEMANTIC_ITEM(false, false, KaxTrackOverlay)
DEFINE_SEMANTIC_ITEM(false, true, KaxCodecDelay)
DEFINE_SEMANTIC_ITEM(true, true, KaxSeekPreRoll)
DEFINE_SEMANTIC_ITEM(false, false, KaxTrackTranslate)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrackVideo)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrackAudio)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrackOperation)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrickTrackUID)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrickTrackSegmentUID)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrickTrackFlag)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrickMasterTrackUID)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrickMasterTrackSegmentUID)
DEFINE_SEMANTIC_ITEM(false, true, KaxContentEncodings)
DEFINE_END_SEMANTIC(KaxTrackEntry)

DEFINE_MKX_MASTER(KaxTrackEntry, 0xAE, 1, KaxTracks, "TrackEntry")

DEFINE_START_SEMANTIC(KaxTrackAudio)
DEFINE_SEMANTIC_ITEM(true, true, KaxAudioSamplingFreq)
DEFINE_SEMANTIC_ITEM(false, true, KaxAudioOutputSamplingFreq)
DEFINE_SEMANTIC_ITEM(true, true, KaxAudioChannels)
DEFINE_SEMANTIC_ITEM(false, true, KaxAudioPosition)
DEFINE_SEMANTIC_ITEM(false, true, KaxAudioBitDepth)
DEFINE_END_SEMANTIC(KaxTrackAudio)

DEFINE_MKX_MASTER(KaxTrackAudio, 0xE1, 1, KaxTrackEntry, "Audio")

DEFINE_START_SEMANTIC(KaxContentEncodings)
DEFINE_SEMANTIC_ITEM(true, false, KaxContentEncoding)
DEFINE_END_SEMANTIC(KaxContentEncodings)

DEFINE_MKX_MASTER(KaxContentEncodings, 0x6D80, 2, KaxTrackEntry, "ContentEncodings")

DEFINE_START_SEMANTIC(KaxContentEncoding)
DEFINE_SEMANTIC_ITEM(true, true, KaxContentEncodingOrder)
DEFINE_SEMANTIC_ITEM(true, true, KaxContentEncodingScope)
DEFINE_SEMANTIC_ITEM(true, true, KaxContentEncodingType)
DEFINE_SEMANTIC_ITEM(false, true, KaxContentCompression)
DEFINE_SEMANTIC_ITEM(false, true, KaxContentEncryption)
DEFINE_END_SEMANTIC(KaxContentEncoding)

DEFINE_MKX_MASTER(KaxContentEncoding, 0x6240, 2, KaxTrackEntry, "ContentEncoding")

DEFINE_START_SEMANTIC(KaxContentCompression)
DEFINE_SEMANTIC_ITEM(true, true, KaxContentCompAlgo)
DEFINE_SEMANTIC_ITEM(false, true, KaxContentCompSettings)
DEFINE_END_SEMANTIC(KaxContentCompression)

DEFINE_MKX_MASTER(KaxContentCompression, 0x5034, 2, KaxContentEncoding, "ContentCompression")

DEFINE_START_SEMANTIC(KaxContentEncryption)
DEFINE_SEMANTIC_ITEM(true, true, KaxContentEncAlgo)
DEFINE_SEMANTIC_ITEM(false, true, KaxContentEncKeyID)
DEFINE_SEMANTIC_ITEM(false, true, KaxContentEncAESSettings)
DEFINE_SEMANTIC_ITEM(false, true, KaxContentSignature)
DEFINE_SEMANTIC_ITEM(false, true, KaxContentSigKeyID)
DEFINE_SEMANTIC_ITEM(false, true, KaxContentSigAlgo)
DEFINE_SEMANTIC_ITEM(false, true, KaxContentSigHashAlgo)
DEFINE_END_SEMANTIC(KaxContentEncryption)

DEFINE_MKX_MASTER(KaxContentEncryption, 0x5035, 2, KaxContentEncoding, "ContentEncryption")

DEFINE_START_SEMANTIC(KaxContentEncAESSettings)
DEFINE_SEMANTIC_ITEM(true, true, KaxAESSettingsCipherMode)
DEFINE_END_SEMANTIC(KaxContentEncAESSettings)

DEFINE_MKX_MASTER(KaxContentEncAESSettings, 0x47E7, 2, KaxContentEncryption, "ContentEncAESSettings")

DEFINE_START_SEMANTIC(KaxTrackOperation)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrackCombinePlanes)
DEFINE_SEMANTIC_ITEM(false, true, KaxTrackJoinBlocks)
DEFINE_END_SEMANTIC(KaxTrackOperation)

DEFINE_MKX_MASTER(KaxTrackOperation, 0xE2, 1, KaxTrackEntry, "TrackOperation")

DEFINE_START_SEMANTIC(KaxTrackCombinePlanes)
DEFINE_SEMANTIC_ITEM(true, false, KaxTrackPlane)
DEFINE_END_SEMANTIC(KaxTrackCombinePlanes)

DEFINE_MKX_MASTER(KaxTrackCombinePlanes, 0xE3, 1, KaxTrackOperation, "TrackCombinePlanes")

DEFINE_START_SEMANTIC(KaxTrackPlane)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackPlaneUID)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackPlaneType)
DEFINE_END_SEMANTIC(KaxTrackPlane)

DEFINE_MKX_MASTER(KaxTrackPlane, 0xE4, 1, KaxTrackCombinePlanes, "TrackPlane")

DEFINE_START_SEMANTIC(KaxTrackJoinBlocks)
DEFINE_SEMANTIC_ITEM(true, false, KaxTrackJoinUID)
DEFINE_END_SEMANTIC(KaxTrackJoinBlocks)

DEFINE_MKX_MASTER(KaxTrackJoinBlocks, 0xE9, 1, KaxTrackOperation, "TrackJoinBlocks")

DEFINE_START_SEMANTIC(KaxTrackTranslate)
DEFINE_SEMANTIC_ITEM(false, false, KaxTrackTranslateEditionUID)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackTranslateCodec)
DEFINE_SEMANTIC_ITEM(true, true, KaxTrackTranslateTrackID)
DEFINE_END_SEMANTIC(KaxTrackTranslate)

DEFINE_MKX_MASTER(KaxTrackTranslate, 0x6624, 2, KaxTrackEntry, "TrackTranslate")

DEFINE_START_SEMANTIC(KaxTrackVideo)
DEFINE_SEMANTIC_ITEM(true, true, KaxVideoFlagInterlaced)
DEFINE_SEMANTIC_ITEM(true, true, KaxVideoFieldOrder)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoStereoMode)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoAlphaMode)
DEFINE_SEMANTIC_ITEM(false, true, KaxOldStereoMode)
DEFINE_SEMANTIC_ITEM(true, true, KaxVideoPixelWidth)
DEFINE_SEMANTIC_ITEM(true, true, KaxVideoPixelHeight)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoPixelCropBottom)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoPixelCropTop)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoPixelCropLeft)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoPixelCropRight)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoDisplayWidth)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoDisplayHeight)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoDisplayUnit)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoAspectRatio)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoColourSpace)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoGamma)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoFrameRate)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoColour)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoProjection)
DEFINE_END_SEMANTIC(KaxTrackVideo)

DEFINE_MKX_MASTER(KaxTrackVideo, 0xE0, 1, KaxTrackEntry, "Video")

DEFINE_START_SEMANTIC(KaxVideoColour)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoColourMatrix)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoBitsPerChannel)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoChromaSubsampHorz)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoChromaSubsampVert)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoCbSubsampHorz)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoCbSubsampVert)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoChromaSitHorz)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoChromaSitVert)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoColourRange)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoColourTransferCharacter)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoColourPrimaries)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoColourMaxCLL)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoColourMaxFALL)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoColourMasterMeta)
DEFINE_END_SEMANTIC(KaxVideoColour)

DEFINE_MKX_MASTER(KaxVideoColour, 0x55B0, 2, KaxVideo, "Colour")

DEFINE_START_SEMANTIC(KaxVideoColourMasterMeta)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoRChromaX)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoRChromaY)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoGChromaX)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoGChromaY)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoBChromaX)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoBChromaY)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoWhitePointChromaX)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoWhitePointChromaY)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoLuminanceMax)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoLuminanceMin)
DEFINE_END_SEMANTIC(KaxVideoColourMasterMeta)

DEFINE_MKX_MASTER(KaxVideoColourMasterMeta, 0x55D0, 2, KaxColour, "MasteringMetadata")

DEFINE_START_SEMANTIC(KaxVideoProjection)
DEFINE_SEMANTIC_ITEM(true, true, KaxVideoProjectionType)
DEFINE_SEMANTIC_ITEM(false, true, KaxVideoProjectionPrivate)
DEFINE_SEMANTIC_ITEM(true, true, KaxVideoProjectionPoseYaw)
DEFINE_SEMANTIC_ITEM(true, true, KaxVideoProjectionPosePitch)
DEFINE_SEMANTIC_ITEM(true, true, KaxVideoProjectionPoseRoll)
DEFINE_END_SEMANTIC(KaxVideoProjection)

DEFINE_MKX_MASTER(KaxVideoProjection, 0x7670, 2, KaxVideo, "Projection")

END_LIBMATROSKA_NAMESPACE

