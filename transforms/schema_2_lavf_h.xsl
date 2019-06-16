<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:str="http://exslt.org/strings" exclude-result-prefixes="str">
  <!-- File used to generate matroska_ids.h -->
  <xsl:output encoding="UTF-8" method="text" version="1.0" indent="yes" />
  <xsl:template match="EBMLSchema">/*
 * Matroska Semantic constants
 *  DO NOT EDIT, GENERATED WITH schema_2_lavf_h.xsl
 *
 * Copyright (c) 2003-2004 The FFmpeg project
 *
 * This file is part of FFmpeg.
 *
 * FFmpeg is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * FFmpeg is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with FFmpeg; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

#ifndef AVFORMAT_MATROSKA_IDS_H
#define AVFORMAT_MATROSKA_IDS_H

/*
 * Matroska element IDs, max. 32 bits
 */

<xsl:apply-templates select="element">
    <!-- <xsl:sort select="translate(substring-before(substring-after(@path,'('),')'), '(1*(', '')" /> -->
    
    <!-- <Parent path>/<id> -->
    <xsl:sort select="concat(
        substring( translate(substring-before(substring-after(@path,'('),')'), '(1*(', ''),
                   1, 
                   string-length(translate(substring-before(substring-after(@path,'('),')'), '(1*(', ''))-string-length(@name)
                 ),
        @id
    )" />
</xsl:apply-templates>

<xsl:for-each select="element">
    <!-- <Parent path>/<id> -->
    <xsl:sort select="concat(
        substring( translate(substring-before(substring-after(@path,'('),')'), '(1*(', ''),
                   1, 
                   string-length(translate(substring-before(substring-after(@path,'('),')'), '(1*(', ''))-string-length(@name)
                 ),
        @id
    )" />

    <!-- Output the enums after the IDs -->
    <xsl:if test="restriction/enum and @type!='string'">
        <xsl:variable name="prefix">
            <xsl:choose>
                <xsl:when test="@name='ContentCompAlgo'">TRACK_ENCODING_COMP</xsl:when>
                <xsl:when test="@name='TrackType'">TRACK_TYPE</xsl:when>
                <xsl:when test="@name='ProjectionType'">VIDEO_PROJECTION_TYPE</xsl:when>
                <xsl:when test="@name='FlagInterlaced'">VIDEO_INTERLACE_FLAG</xsl:when>
                <xsl:when test="@name='StereoMode'">VIDEO_STEREOMODE_TYPE</xsl:when>
                <xsl:when test="contains(@path,'\TrackEntry\Video\Colour\')"><xsl:text>COLOUR_</xsl:text><xsl:value-of select="@name"/></xsl:when>
                <xsl:when test="contains(@path,'\TrackEntry\Video\')"><xsl:text>VIDEO_</xsl:text><xsl:value-of select="@name"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:text>&#10;typedef enum {&#10;</xsl:text>

        <!-- Internal value not found in the specs -->
        <xsl:if test="@name='TrackType'"><xsl:text>  MATROSKA_TRACK_TYPE_NONE = 0,&#10;</xsl:text></xsl:if>

        <xsl:for-each select="restriction/enum">
            <xsl:sort select="value"/>
            <xsl:text>  MATROSKA_</xsl:text>
            <xsl:value-of select="translate($prefix, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
            <xsl:text>_</xsl:text>
            <xsl:call-template name="outputEnumLabel">
                <xsl:with-param name="label" select="@label"/>
            </xsl:call-template>

            <xsl:text> = </xsl:text>
            <xsl:value-of select="@value"/>
            <xsl:text>,&#10;</xsl:text>
        </xsl:for-each>

        <!-- Extra enum count -->
        <xsl:choose>
            <xsl:when test="@name='ChromaSitingHorz'"><xsl:text>  MATROSKA_COLOUR_CHROMASITINGHORZ_NB&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='ChromaSitingVert'"><xsl:text>  MATROSKA_COLOUR_CHROMASITINGVERT_NB&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='StereoMode'"><xsl:text>  MATROSKA_VIDEO_STEREOMODE_TYPE_NB,&#10;</xsl:text></xsl:when>
        </xsl:choose>

        <xsl:text>} Matroska</xsl:text>
        <xsl:choose>
            <xsl:when test="@name='ContentCompAlgo'"><xsl:text>TrackEncodingCompAlgo</xsl:text></xsl:when>
            <xsl:when test="@name='ChromaSitingHorz'"><xsl:text>ColourChromaSitingHorz</xsl:text></xsl:when>
            <xsl:when test="@name='ChromaSitingVert'"><xsl:text>ColourChromaSitingVert</xsl:text></xsl:when>
            <xsl:when test="@name='FlagInterlaced'"><xsl:text>VideoInterlaceFlag</xsl:text></xsl:when>
            <xsl:when test="@name='StereoMode'"><xsl:text>VideoStereoModeType</xsl:text></xsl:when>
            <xsl:when test="contains(@path,'\TrackEntry\Video\')"><xsl:text>Video</xsl:text><xsl:value-of select="@name"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
        </xsl:choose>
        <xsl:text>;&#10;&#10;</xsl:text>
    </xsl:if>

</xsl:for-each>

#endif /* AVFORMAT_MATROSKA_IDS_H */
</xsl:template>

  <xsl:template match="element">
    <!-- main output with IDs -->
    <xsl:variable name="plainPath"><xsl:value-of select="translate(substring-before(substring-after(@path,'('),')'), '(1*(', '')" /></xsl:variable>
<!-- <xsl:variable name="plainPath"><xsl:value-of select="translate(translate(substring-before(substring-after(@path,'('),')'), '(1*(', ''),  concat('\',@name) , concat('\',concat(@id,@name))  )" /></xsl:variable> -->
<!-- <xsl:variable name="plainPath">
    <xsl:value-of select="concat(
        substring( translate(substring-before(substring-after(@path,'('),')'), '(1*(', ''),
                   1, 
                   string-length(translate(substring-before(substring-after(@path,'('),')'), '(1*(', ''))-string-length(@name)
                 ),
        @id
    )" /></xsl:variable> -->
<!-- <xsl:text>plainPath = </xsl:text><xsl:value-of select="$plainPath" /><xsl:text>&#10;</xsl:text> -->
    <!-- Ignore EBML extra constraints -->
    <xsl:if test="not(starts-with($plainPath,'\EBML\'))">
    <!-- <xsl:copy> -->
        <xsl:variable name="lavfName">
            <xsl:choose>
                <xsl:when test="@name='FileDescription'"><xsl:text>FileDesc</xsl:text></xsl:when>
                <xsl:when test="@name='ChapLanguage'"><xsl:text>ChapLang</xsl:text></xsl:when>
                <xsl:when test="@name='ReferenceBlock'"><xsl:text>BlockReference</xsl:text></xsl:when>
                <xsl:when test="@name='Position'"><xsl:text>ClusterPosition</xsl:text></xsl:when>
                <xsl:when test="@name='PrevSize'"><xsl:text>ClusterPrevSize</xsl:text></xsl:when>
                <xsl:when test="@name='Timestamp'"><xsl:text>ClusterTimecode</xsl:text></xsl:when>
                <xsl:when test="@name='CuePoint'"><xsl:text>PointEntry</xsl:text></xsl:when>
                <xsl:when test="@name='CueTrackPositions'"><xsl:text>CueTrackPosition</xsl:text></xsl:when>
                <xsl:when test="@name='TimestampScale'"><xsl:text>TimecodeScale</xsl:text></xsl:when>
                <xsl:when test="@name='Seek'"><xsl:text>SeekEntry</xsl:text></xsl:when>
                <xsl:when test="@name='TagLanguage'"><xsl:text>TagLang</xsl:text></xsl:when>
                <xsl:when test="@name='Targets'"><xsl:text>TagTargets</xsl:text></xsl:when>
                <xsl:when test="@name='TagAttachmentUID'"><xsl:text>TagTargets_AttachUID</xsl:text></xsl:when>
                <xsl:when test="@name='TagChapterUID'"><xsl:text>TagTargets_ChapterUID</xsl:text></xsl:when>
                <xsl:when test="@name='TagTrackUID'"><xsl:text>TagTargets_TrackUID</xsl:text></xsl:when>
                <xsl:when test="@name='TargetType'"><xsl:text>TagTargets_Type</xsl:text></xsl:when>
                <xsl:when test="@name='TargetTypeValue'"><xsl:text>TagTargets_TypeValue</xsl:text></xsl:when>
                <xsl:when test="@name='ChapterPhysicalEquiv'"><xsl:text>ChapterPhysEquiv</xsl:text></xsl:when>
                <xsl:when test="@name='OutputSamplingFrequency'"><xsl:text>AudioOutSamplingFreq</xsl:text></xsl:when>
                <xsl:when test="@name='SamplingFrequency'"><xsl:text>AudioSamplingFreq</xsl:text></xsl:when>
                <xsl:when test="@name='ContentEncodings'"><xsl:text>TrackContentEncodings</xsl:text></xsl:when>
                <xsl:when test="@name='ContentEncoding'"><xsl:text>TrackContentEncoding</xsl:text></xsl:when>
                <xsl:when test="@name='ContentCompression'"><xsl:text>EncodingCompression</xsl:text></xsl:when>
                <xsl:when test="@name='ContentCompAlgo'"><xsl:text>EncodingCompAlgo</xsl:text></xsl:when>
                <xsl:when test="@name='ContentCompSettings'"><xsl:text>EncodingCompSettings</xsl:text></xsl:when>
                <xsl:when test="@name='ContentEncodingOrder'"><xsl:text>EncodingOrder</xsl:text></xsl:when>
                <xsl:when test="@name='ContentEncodingScope'"><xsl:text>EncodingScope</xsl:text></xsl:when>
                <xsl:when test="@name='ContentEncodingType'"><xsl:text>EncodingType</xsl:text></xsl:when>
                <xsl:when test="@name='ContentEncryption'"><xsl:text>EncodingEncryption</xsl:text></xsl:when>
                <xsl:when test="@name='ContentEncAESSettings'"><xsl:text>EncodingEncAESSettings</xsl:text></xsl:when>
                <xsl:when test="@name='ContentEncAlgo'"><xsl:text>EncodingEncAlgo</xsl:text></xsl:when>
                <xsl:when test="@name='ContentEncKeyID'"><xsl:text>EncodingEncKeyId</xsl:text></xsl:when>
                <xsl:when test="@name='ContentSigAlgo'"><xsl:text>EncodingSigAlgo</xsl:text></xsl:when>
                <xsl:when test="@name='ContentSignature'"><xsl:text>EncodingSignature</xsl:text></xsl:when>
                <xsl:when test="@name='ContentSigKeyID'"><xsl:text>EncodingSigKeyId</xsl:text></xsl:when>
                <xsl:when test="@name='ContentSigHashAlgo'"><xsl:text>EncodingSigHashAlgo</xsl:text></xsl:when>
                <xsl:when test="@name='MaxBlockAdditionID'"><xsl:text>TrackMaxBlkAddID</xsl:text></xsl:when>
                <xsl:when test="@name='SeekPreRoll'"><xsl:text>SeekPreRoll</xsl:text></xsl:when>
                <xsl:when test="@name='TrackTimestampScale'"><xsl:text>TrackTimecodeScale</xsl:text></xsl:when>
                <xsl:when test="@name='AspectRatioType'"><xsl:text>VideoAspectRatio</xsl:text></xsl:when>
                <xsl:when test="@name='Colour'"><xsl:text>VideoColor</xsl:text></xsl:when>
                <xsl:when test="@name='ColourSpace'"><xsl:text>VideoColorSpace</xsl:text></xsl:when>
                <xsl:when test="@name='ChromaSubsamplingHorz'"><xsl:text>VideoColorChromaSubHorz</xsl:text></xsl:when>
                <xsl:when test="@name='ChromaSubsamplingVert'"><xsl:text>VideoColorChromaSubVert</xsl:text></xsl:when>
                <xsl:when test="@name='CbSubsamplingHorz'"><xsl:text>VideoColorCbSubHorz</xsl:text></xsl:when>
                <xsl:when test="@name='CbSubsamplingVert'"><xsl:text>VideoColorCbSubVert</xsl:text></xsl:when>
                <xsl:when test="@name='MasteringMetadata'"><xsl:text>VideoColorMasteringMeta</xsl:text></xsl:when>
                <xsl:when test="@name='MatrixCoefficients'"><xsl:text>VideoColorMatrixCoeff</xsl:text></xsl:when>
                <xsl:when test="contains(@path,'\TrackEntry\Audio\')"><xsl:text>Audio</xsl:text><xsl:value-of select="@name"/></xsl:when>
                <xsl:when test="contains(@path,'\TrackEntry\Video\PixelCrop')"><xsl:text>VideoPixelCrop</xsl:text><xsl:value-of select="substring(@name, 10, 1)"/></xsl:when>
                <xsl:when test="contains(@path,'\TrackEntry\Video\Colour\MasteringMetadata\Primary')"><xsl:text>VideoColor_</xsl:text><xsl:value-of select="substring(@name, 8, 1)"/><xsl:value-of select="substring(@name, string-length(@name))"/></xsl:when>
                <xsl:when test="contains(@path,'\TrackEntry\Video\Colour\MasteringMetadata\WhitePointChromaticity')"><xsl:text>VideoColor_WHITE</xsl:text><xsl:value-of select="substring(@name, string-length(@name))"/></xsl:when>
                <xsl:when test="contains(@path,'\TrackEntry\Video\Colour\MasteringMetadata\Luminance')"><xsl:text>VideoColor_</xsl:text><xsl:value-of select="@name"/></xsl:when>
                <xsl:when test="contains(@path,'\TrackEntry\Video\Colour\')"><xsl:text>VideoColor</xsl:text><xsl:value-of select="@name"/></xsl:when>
                <xsl:when test="contains(@path,'\TrackEntry\Video\')"><xsl:text>Video</xsl:text><xsl:value-of select="@name"/></xsl:when>
                <xsl:when test="contains(@path,'\TrackEntry\') and not(contains(@name,'Track')) and not(contains(@name,'Codec'))"><xsl:text>Track</xsl:text><xsl:value-of select="@name"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@name='Segment'"><xsl:text>/* toplevel segment */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='AttachedFile'"><xsl:text>&#10;/* IDs in the attachments master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='EditionEntry'"><xsl:text>&#10;/* IDs in the chapters master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='BlockGroup'"><xsl:text>&#10;/* IDs in the cluster master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='TimestampScale'"><xsl:text>&#10;/* IDs in the info master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='CueTime'"><xsl:text>&#10;/* IDs in the pointentry master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='CuePoint'"><xsl:text>&#10;/* IDs in the cues master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='Seek'"><xsl:text>&#10;/* IDs in the seekhead master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='DiscardPadding'"><xsl:text>&#10;/* IDs in the blockgroup master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='BitDepth'"><xsl:text>&#10;/* IDs in the trackaudio master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='FrameRate'"><xsl:text>&#10;/* IDs in the trackvideo master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='CueBlockNumber'"><xsl:text>&#10;/* IDs in the cuetrackposition master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='Tag'"><xsl:text>&#10;/* IDs in the tags master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='TrackEntry'"><xsl:text>&#10;/* IDs in the tracks master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='CodecName'"><xsl:text>&#10;/* IDs in the trackentry master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='ContentEncodingOrder'"><xsl:text>&#10;/* IDs in the content encoding master */&#10;</xsl:text></xsl:when>
        </xsl:choose>
        <xsl:text>#define MATROSKA_ID_</xsl:text>
<!-- <xsl:value-of select="$lavfName"/><xsl:text>&#10;</xsl:text> -->
        <xsl:call-template name="outputRenamed">
            <xsl:with-param name="renamed" select="$lavfName"/>
        </xsl:call-template>
        <!-- <xsl:call-template name="outputRenameddd">
            <xsl:with-param name="whodis" select="."/>
            <xsl:with-param name="lavfName" select="$lavfName"/>
        </xsl:call-template> -->

        <xsl:text> </xsl:text>
        <xsl:value-of select="@id" />
        <xsl:text>&#10;</xsl:text>

        <xsl:choose>
            <xsl:when test="@name='Segment'"><xsl:text>&#10;/* Matroska top-level master IDs */&#10;</xsl:text></xsl:when>
            <!-- <xsl:when test="@name='Cluster'"><xsl:text>&#10;/* IDs in the cluster master */&#10;</xsl:text></xsl:when> -->
            <!-- <xsl:when test="@name='Cues'"><xsl:text>&#10;/* IDs in the cues master */&#10;</xsl:text></xsl:when> -->
            <xsl:when test="@name='Seek'"><xsl:text>&#10;/* IDs in the seekpoint master */&#10;</xsl:text></xsl:when>
            <!-- <xsl:when test="@name='SeekHead'"><xsl:text>&#10;/* IDs in the seekhead master */&#10;</xsl:text></xsl:when> -->

            Extra element that may be found in some files
        </xsl:choose>
        <xsl:if test="@name='TagDefault'"><xsl:text>#define MATROSKA_ID_TAGDEFAULT_BUG             0x44B4&#10;</xsl:text></xsl:if>
    <!-- </xsl:copy> -->
    </xsl:if>
  </xsl:template>
  <xsl:template match="documentation">
    <documentation>
        <xsl:attribute name="lang"><xsl:value-of select="@lang" /></xsl:attribute>
        <xsl:if test="@type">
            <xsl:attribute name="type"><xsl:value-of select="@type" /></xsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
    </documentation>
  </xsl:template>

  <xsl:template name="outputEnumLabel">
    <xsl:param name="label"/>
<!-- <xsl:text>&#10;</xsl:text><xsl:value-of select="$label"/> -->
    <xsl:choose>
        <xsl:when test="$label='lzo1x'">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'LZO'"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="$label='Header Stripping'">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'HeaderStrip'"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="$label='unspecified'">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'undetermined'"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="$label='display aspect ratio'">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'dar'"/></xsl:call-template>
        </xsl:when>
        <!-- Field Order -->
        <xsl:when test="$label='tff'">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'tt'"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="$label='bff'">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'bb'"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="$label='tff(swapped)'">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'bt'"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="$label='bff(swapped)'">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'tb'"/></xsl:call-template>
        </xsl:when>

        <!-- Stereo Mode -->
        <xsl:when test="contains($label,'top - bottom (left eye is first)')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'top bottom'"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,'top - bottom (right eye is first)')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'bottom top'"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,'anaglyph (cyan/red)')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'anaglyph cyan red'"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,'anaglyph (green/magenta)')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'anaglyph green mag'"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,'side by side (')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="substring-after($label, 'side by side (')"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,'(right eye is first)')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="concat(substring-before($label,'(right eye is first)'), 'rl')"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,'(left eye is first)')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="concat(substring-before($label,'(left eye is first)'), 'lr')"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,'left eye first')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'left right'"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,'right eye first')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'right left'"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,'column ')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="concat(concat(substring-before($label, 'column '), 'col '), substring-after($label, 'column '))"/></xsl:call-template>
            <!-- <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'col'"/></xsl:call-template> -->
        </xsl:when>
        <xsl:when test="contains($label,'checkboard ')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="concat(concat(substring-before($label, 'checkboard '), 'checkerboard '), substring-after($label, 'checkboard '))"/></xsl:call-template>
            <!-- <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'checkerboard'"/></xsl:call-template> -->
        </xsl:when>
        <xsl:when test="contains($label,'laced in one ')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="concat(substring-before($label, 'laced in one '), substring-after($label, 'laced in one '))"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,'The ')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="concat(substring-before($label, 'The '), substring-after($label, 'The '))"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,' private data')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="'private data'"/></xsl:call-template>
        </xsl:when>

        <xsl:when test="contains($label,',')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="substring-before($label, ',')"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,')')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="substring-before($label, ')')"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,' collocated')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="substring-before($label, ' collocated')"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,' (')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="substring-before($label, ' (')"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,' /')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="substring-before($label, ' /')"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,'__')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="concat(substring-before($label, '__'), substring-after($label, '__'))"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,' - ')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="concat(concat(substring-before($label, ' - '), '_'), substring-after($label, ' - '))"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,' -')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="concat(concat(substring-before($label, ' -'), '_'), substring-after($label, ' -'))"/></xsl:call-template>
        </xsl:when>
        <!-- <xsl:when test="contains($label, &apos;)">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="concat(substring-before($label, &apos;), substring-after($label, '&apos;'))"/></xsl:call-template>
        </xsl:when> -->
        <xsl:when test="contains($label,'-')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="translate($label, '-', '_')"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,' ')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="translate($label, ' ', '_')"/></xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($label,'.')">
            <xsl:call-template name="outputEnumLabel"><xsl:with-param name="label" select="translate($label, '.', '_')"/></xsl:call-template>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="translate($label, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!-- <xsl:template name="outputRenameddd">
    <xsl:param name="whodis"/>
    <xsl:param name="lavfName"/> -->
<!-- <xsl:text>whodis/name=</xsl:text><xsl:value-of select="$whodis/@name" /><xsl:text>&#10;</xsl:text> -->
<!-- <xsl:text>whodis/lavfName=</xsl:text><xsl:value-of select="$lavfName" /><xsl:text>&#10;</xsl:text> -->
    <!-- <xsl:call-template name="outputRenamed">
        <xsl:with-param name="renamed" select="$lavfName"/>
    </xsl:call-template>
</xsl:template> -->

  <xsl:template name="outputRenamed">
    <xsl:param name="renamed"/>
    <xsl:call-template name="outputUpperName">
        <xsl:with-param name="upperName" select="translate($renamed, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="outputUpperName">
    <xsl:param name="upperName"/>
    <xsl:value-of select="$upperName" />
    <xsl:call-template name="alignName">
        <xsl:with-param name="prmStr" select="$upperName"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="alignName">
    <xsl:param name="prmStr" select="''"/>
    <xsl:if test="string-length($prmStr) &lt; 26">
        <xsl:text> </xsl:text>
        <xsl:call-template name="alignName">
            <xsl:with-param name="prmStr" select="concat($prmStr, ' ')"/>
        </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- HTML tags found in documentation -->
  <xsl:template match="a">
    <a href="{@href}"><xsl:apply-templates/></a>
  </xsl:template>
  <xsl:template match="strong">
    <strong><xsl:apply-templates/></strong>
  </xsl:template>
  <xsl:template match="br">
    <br/><xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="comment()">
    <xsl:comment>
      <xsl:value-of select="."/>
    </xsl:comment>
  </xsl:template>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
