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
DEFINE_END_SEMANTIC(KaxSegment)

DEFINE_MKX_MASTER_ORPHAN(KaxSegment, 0x18538067, 4, "Segment")

DEFINE_START_SEMANTIC(KaxAttachments)
DEFINE_END_SEMANTIC(KaxAttachments)

DEFINE_MKX_MASTER(KaxAttachments, 0x1941A469, 4, KaxSegment, "Attachments")

DEFINE_START_SEMANTIC(KaxAttached)
DEFINE_END_SEMANTIC(KaxAttached)

DEFINE_MKX_MASTER(KaxAttached, 0x61A7, 2, KaxAttachments, "AttachedFile")

DEFINE_START_SEMANTIC(KaxChapters)
DEFINE_END_SEMANTIC(KaxChapters)

DEFINE_MKX_MASTER(KaxChapters, 0x1043A770, 4, KaxSegment, "Chapters")

DEFINE_START_SEMANTIC(KaxEditionEntry)
DEFINE_END_SEMANTIC(KaxEditionEntry)

DEFINE_MKX_MASTER(KaxEditionEntry, 0x45B9, 2, KaxChapters, "EditionEntry")

DEFINE_START_SEMANTIC(KaxChapterAtom)
DEFINE_END_SEMANTIC(KaxChapterAtom)

DEFINE_MKX_MASTER(KaxChapterAtom, 0xB6, 1, KaxEditionEntry(1*(, "ChapterAtom")

DEFINE_START_SEMANTIC(KaxChapterProcess)
DEFINE_END_SEMANTIC(KaxChapterProcess)

DEFINE_MKX_MASTER(KaxChapterProcess, 0x6944, 2, KaxChapterAtom, "ChapProcess")

DEFINE_START_SEMANTIC(KaxChapterProcessCommand)
DEFINE_END_SEMANTIC(KaxChapterProcessCommand)

DEFINE_MKX_MASTER(KaxChapterProcessCommand, 0x6911, 2, KaxChapProcess, "ChapProcessCommand")

DEFINE_START_SEMANTIC(KaxChapterDisplay)
DEFINE_END_SEMANTIC(KaxChapterDisplay)

DEFINE_MKX_MASTER(KaxChapterDisplay, 0x80, 1, KaxChapterAtom, "ChapterDisplay")

DEFINE_START_SEMANTIC(KaxChapterTrack)
DEFINE_END_SEMANTIC(KaxChapterTrack)

DEFINE_MKX_MASTER(KaxChapterTrack, 0x8F, 1, KaxChapterAtom, "ChapterTrack")

DEFINE_START_SEMANTIC(KaxCluster)
DEFINE_END_SEMANTIC(KaxCluster)

DEFINE_MKX_MASTER(KaxCluster, 0x1F43B675, 4, KaxSegment, "Cluster")

DEFINE_START_SEMANTIC(KaxBlockGroup)
DEFINE_END_SEMANTIC(KaxBlockGroup)

DEFINE_MKX_MASTER(KaxBlockGroup, 0xA0, 1, KaxCluster, "BlockGroup")

DEFINE_START_SEMANTIC(KaxBlockAdditions)
DEFINE_END_SEMANTIC(KaxBlockAdditions)

DEFINE_MKX_MASTER(KaxBlockAdditions, 0x75A1, 2, KaxBlockGroup, "BlockAdditions")

DEFINE_START_SEMANTIC(KaxBlockMore)
DEFINE_END_SEMANTIC(KaxBlockMore)

DEFINE_MKX_MASTER(KaxBlockMore, 0xA6, 1, KaxBlockAdditions, "BlockMore")

DEFINE_START_SEMANTIC(KaxReferenceFrame)
DEFINE_END_SEMANTIC(KaxReferenceFrame)

DEFINE_MKX_MASTER(KaxReferenceFrame, 0xC8, 1, KaxBlockGroup, "ReferenceFrame")

DEFINE_START_SEMANTIC(KaxSlices)
DEFINE_END_SEMANTIC(KaxSlices)

DEFINE_MKX_MASTER(KaxSlices, 0x8E, 1, KaxBlockGroup, "Slices")

DEFINE_START_SEMANTIC(KaxTimeSlice)
DEFINE_END_SEMANTIC(KaxTimeSlice)

DEFINE_MKX_MASTER(KaxTimeSlice, 0xE8, 1, KaxSlices, "TimeSlice")

DEFINE_START_SEMANTIC(KaxClusterSilentTracks)
DEFINE_END_SEMANTIC(KaxClusterSilentTracks)

DEFINE_MKX_MASTER(KaxClusterSilentTracks, 0x5854, 2, KaxCluster, "SilentTracks")

DEFINE_START_SEMANTIC(KaxCues)
DEFINE_END_SEMANTIC(KaxCues)

DEFINE_MKX_MASTER(KaxCues, 0x1C53BB6B, 4, KaxSegment, "Cues")

DEFINE_START_SEMANTIC(KaxCuePoint)
DEFINE_END_SEMANTIC(KaxCuePoint)

DEFINE_MKX_MASTER(KaxCuePoint, 0xBB, 1, KaxCues, "CuePoint")

DEFINE_START_SEMANTIC(KaxCueTrackPositions)
DEFINE_END_SEMANTIC(KaxCueTrackPositions)

DEFINE_MKX_MASTER(KaxCueTrackPositions, 0xB7, 1, KaxCuePoint, "CueTrackPositions")

DEFINE_START_SEMANTIC(KaxCueReference)
DEFINE_END_SEMANTIC(KaxCueReference)

DEFINE_MKX_MASTER(KaxCueReference, 0xDB, 1, KaxCueTrackPositions, "CueReference")

DEFINE_START_SEMANTIC(KaxInfo)
DEFINE_END_SEMANTIC(KaxInfo)

DEFINE_MKX_MASTER(KaxInfo, 0x1549A966, 4, KaxSegment, "Info")

DEFINE_START_SEMANTIC(KaxChapterTranslate)
DEFINE_END_SEMANTIC(KaxChapterTranslate)

DEFINE_MKX_MASTER(KaxChapterTranslate, 0x6924, 2, KaxInfo, "ChapterTranslate")

DEFINE_START_SEMANTIC(KaxSeekHead)
DEFINE_END_SEMANTIC(KaxSeekHead)

DEFINE_MKX_MASTER(KaxSeekHead, 0x114D9B74, 4, KaxSegment, "SeekHead")

DEFINE_START_SEMANTIC(KaxSeek)
DEFINE_END_SEMANTIC(KaxSeek)

DEFINE_MKX_MASTER(KaxSeek, 0x4DBB, 2, KaxSegment, "Seek")

DEFINE_START_SEMANTIC(KaxTags)
DEFINE_END_SEMANTIC(KaxTags)

DEFINE_MKX_MASTER(KaxTags, 0x1254C367, 4, KaxSegment, "Tags")

DEFINE_START_SEMANTIC(KaxTag)
DEFINE_END_SEMANTIC(KaxTag)

DEFINE_MKX_MASTER(KaxTag, 0x7373, 2, KaxSegment, "Tag")

DEFINE_START_SEMANTIC(KaxTagSimple)
DEFINE_END_SEMANTIC(KaxTagSimple)

DEFINE_MKX_MASTER(KaxTagSimple, 0x67C8, 2, KaxTag(1*(, "SimpleTag")

DEFINE_START_SEMANTIC(KaxTagTargets)
DEFINE_END_SEMANTIC(KaxTagTargets)

DEFINE_MKX_MASTER(KaxTagTargets, 0x63C0, 2, KaxTag, "Targets")

DEFINE_START_SEMANTIC(KaxTracks)
DEFINE_END_SEMANTIC(KaxTracks)

DEFINE_MKX_MASTER(KaxTracks, 0x1654AE6B, 4, KaxSegment, "Tracks")

DEFINE_START_SEMANTIC(KaxTrackEntry)
DEFINE_END_SEMANTIC(KaxTrackEntry)

DEFINE_MKX_MASTER(KaxTrackEntry, 0xAE, 1, KaxTracks, "TrackEntry")

DEFINE_START_SEMANTIC(KaxTrackAudio)
DEFINE_END_SEMANTIC(KaxTrackAudio)

DEFINE_MKX_MASTER(KaxTrackAudio, 0xE1, 1, KaxTrackEntry, "Audio")

DEFINE_START_SEMANTIC(KaxContentEncodings)
DEFINE_END_SEMANTIC(KaxContentEncodings)

DEFINE_MKX_MASTER(KaxContentEncodings, 0x6D80, 2, KaxTrackEntry, "ContentEncodings")

DEFINE_START_SEMANTIC(KaxContentEncoding)
DEFINE_END_SEMANTIC(KaxContentEncoding)

DEFINE_MKX_MASTER(KaxContentEncoding, 0x6240, 2, KaxTrackEntry, "ContentEncoding")

DEFINE_START_SEMANTIC(KaxContentCompression)
DEFINE_END_SEMANTIC(KaxContentCompression)

DEFINE_MKX_MASTER(KaxContentCompression, 0x5034, 2, KaxContentEncoding, "ContentCompression")

DEFINE_START_SEMANTIC(KaxContentEncryption)
DEFINE_END_SEMANTIC(KaxContentEncryption)

DEFINE_MKX_MASTER(KaxContentEncryption, 0x5035, 2, KaxContentEncoding, "ContentEncryption")

DEFINE_START_SEMANTIC(KaxContentEncAESSettings)
DEFINE_END_SEMANTIC(KaxContentEncAESSettings)

DEFINE_MKX_MASTER(KaxContentEncAESSettings, 0x47E7, 2, KaxContentEncryption, "ContentEncAESSettings")

DEFINE_START_SEMANTIC(KaxTrackOperation)
DEFINE_END_SEMANTIC(KaxTrackOperation)

DEFINE_MKX_MASTER(KaxTrackOperation, 0xE2, 1, KaxTrackEntry, "TrackOperation")

DEFINE_START_SEMANTIC(KaxTrackCombinePlanes)
DEFINE_END_SEMANTIC(KaxTrackCombinePlanes)

DEFINE_MKX_MASTER(KaxTrackCombinePlanes, 0xE3, 1, KaxTrackOperation, "TrackCombinePlanes")

DEFINE_START_SEMANTIC(KaxTrackPlane)
DEFINE_END_SEMANTIC(KaxTrackPlane)

DEFINE_MKX_MASTER(KaxTrackPlane, 0xE4, 1, KaxTrackCombinePlanes, "TrackPlane")

DEFINE_START_SEMANTIC(KaxTrackJoinBlocks)
DEFINE_END_SEMANTIC(KaxTrackJoinBlocks)

DEFINE_MKX_MASTER(KaxTrackJoinBlocks, 0xE9, 1, KaxTrackOperation, "TrackJoinBlocks")

DEFINE_START_SEMANTIC(KaxTrackTranslate)
DEFINE_END_SEMANTIC(KaxTrackTranslate)

DEFINE_MKX_MASTER(KaxTrackTranslate, 0x6624, 2, KaxTrackEntry, "TrackTranslate")

DEFINE_START_SEMANTIC(KaxTrackVideo)
DEFINE_END_SEMANTIC(KaxTrackVideo)

DEFINE_MKX_MASTER(KaxTrackVideo, 0xE0, 1, KaxTrackEntry, "Video")

DEFINE_START_SEMANTIC(KaxVideoColour)
DEFINE_END_SEMANTIC(KaxVideoColour)

DEFINE_MKX_MASTER(KaxVideoColour, 0x55B0, 2, KaxVideo, "Colour")

DEFINE_START_SEMANTIC(KaxVideoColourMasterMeta)
DEFINE_END_SEMANTIC(KaxVideoColourMasterMeta)

DEFINE_MKX_MASTER(KaxVideoColourMasterMeta, 0x55D0, 2, KaxColour, "MasteringMetadata")

DEFINE_START_SEMANTIC(KaxVideoProjection)
DEFINE_END_SEMANTIC(KaxVideoProjection)

DEFINE_MKX_MASTER(KaxVideoProjection, 0x7670, 2, KaxVideo, "Projection")

END_LIBMATROSKA_NAMESPACE

