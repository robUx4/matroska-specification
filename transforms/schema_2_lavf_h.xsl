<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" 
    xmlns:str="http://exslt.org/strings"
    exclude-result-prefixes="str xhtml ebml"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns="https://ietf.org/cellar/ebml" xmlns:ebml="https://ietf.org/cellar/ebml">
  <!-- File used to generate matroska_ids.h -->
  <xsl:output encoding="UTF-8" method="text" version="1.0" indent="yes" />

  <xsl:template match="ebml:EBMLSchema">
<xsl:text>/*
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
</xsl:text>

    <xsl:apply-templates select="ebml:element[@name='Segment']"/>
    <!-- TODO even closer ordering with a "sort score"  https://stackoverflow.com/questions/1287651/xslt-custom-sort -->

    <xsl:for-each select="ebml:element">
        <!-- <Parent path>/<id> -->
        <xsl:sort select="concat(
            substring( translate(substring-before(substring-after(@path,'('),')'), '(1*(', ''),
                    1, 
                    string-length(translate(substring-before(substring-after(@path,'('),')'), '(1*(', ''))-string-length(@name)
                    ),
            @id
        )" />

        <!-- Output the enums after the IDs -->
        <xsl:call-template name="outputAllEnums"/>

    </xsl:for-each>

<xsl:text>
#endif /* AVFORMAT_MATROSKA_IDS_H */
</xsl:text>

  </xsl:template>

    <xsl:template match="ebml:element">
<!-- <xsl:text>
In match element, name:</xsl:text>
<xsl:value-of select="@name"/><xsl:text>&#10;</xsl:text> -->
        <xsl:call-template name="parsePath">
            <xsl:with-param name="node" select="."/>
        </xsl:call-template>

        <xsl:variable name="plainPath">
            <xsl:value-of select="translate(substring-before(substring-after(@path,'('),')'), '(1*(', '')" />
        </xsl:variable>
        <xsl:variable name="myPath" select="@path"/>
<!-- <xsl:text>variable plainPath:</xsl:text>
<xsl:value-of select="$plainPath"/><xsl:text>&#10;</xsl:text>
<xsl:text>variable myPath:</xsl:text>
<xsl:value-of select="$myPath"/><xsl:text>&#10;</xsl:text> -->

        <!-- <xsl:value-of select="@name"/><xsl:text> - </xsl:text>
        <xsl:for-each select="../element[translate(substring-before(substring-after(@path,'('),')'), '(1*(', '') = concat(concat($plainPath, '\'), @name)]">
            <xsl:value-of select="@name"/><xsl:text> | </xsl:text>
            <xsl:apply-templates select="element[@name = 'SeekHead']"/>
        </xsl:for-each> -->
    </xsl:template>

    <xsl:template name="parsePath">
        <xsl:param name="node"/>
<!-- <xsl:text>
In parsePath, path:</xsl:text>
<xsl:value-of select="$node/@path"/><xsl:text>&#10;</xsl:text>
<xsl:text>variable type:</xsl:text>
<xsl:value-of select="@type"/><xsl:text>&#10;</xsl:text>
<xsl:text>variable name:</xsl:text>
<xsl:value-of select="@name"/><xsl:text>&#10;</xsl:text> -->
        <xsl:variable name="plainPath">
            <xsl:value-of select="translate(substring-before(substring-after($node/@path,'('),')'), '(1*(', '')" />
        </xsl:variable>
        <xsl:if test="@type='master'">
            <xsl:choose>
                <xsl:when test="@name='Segment'">
                    <xsl:text>
/* toplevel segment */
#define MATROSKA_ID_SEGMENT    0x18538067

/* Matroska top-level master IDs */
</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>/* IDs in the </xsl:text>
                    <xsl:variable name="masterName">
                        <xsl:choose>
                            <xsl:when test="$node/@name='CuePoint'"><xsl:text>PointEntry</xsl:text></xsl:when>
                            <xsl:when test="$node/@name='Audio'"><xsl:text>TrackAudio</xsl:text></xsl:when>
                            <xsl:when test="$node/@name='Video'"><xsl:text>TrackVideo</xsl:text></xsl:when>
                            <xsl:when test="$node/@name='Seek'"><xsl:text>SeekPoint</xsl:text></xsl:when>
                            <xsl:otherwise><xsl:value-of select="$node/@name"/></xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:value-of select="translate($masterName, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
                    <xsl:text> master */&#10;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>

<!-- <xsl:text>variable plainPath:</xsl:text>
<xsl:value-of select="$plainPath"/><xsl:text>&#10;</xsl:text>
<xsl:text>variable substring1:</xsl:text>
<xsl:value-of select="translate(substring-before(substring-after(@path,'('),')'), '(1*(', '')"/><xsl:text>&#10;</xsl:text>
<xsl:text>variable substring2:</xsl:text>
<xsl:value-of select="concat(concat($plainPath, '\'), @name)"/><xsl:text>&#10;</xsl:text> -->
        <xsl:for-each select="/ebml:EBMLSchema/ebml:element[translate(substring-before(substring-after(@path,'('),')'), '(1*(', '') = concat(concat($plainPath, '\'), @name)]">
            <xsl:sort select="not(@name='Info')" />
            <xsl:sort select="not(@name='Tracks')" />
            <xsl:sort select="not(@name='Cues')" />
            <xsl:sort select="not(@name='Tags')" />
            <xsl:sort select="@name='Chapters'" />
            <xsl:sort select="@name='Audio'" />
            <xsl:sort select="string-length(@id)" />
            <!-- <xsl:sort select="@name" /> -->
            <xsl:sort select="@id" />
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
            <xsl:text>#define MATROSKA_ID_</xsl:text>
            <xsl:value-of select="translate($lavfName, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
            <xsl:text>  </xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>&#10;</xsl:text>
            <xsl:if test="@name='TagDefault'"><xsl:text>#define MATROSKA_ID_TAGDEFAULT_BUG  0x44B4&#10;</xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:text>&#10;</xsl:text>

        <xsl:for-each select="../ebml:element[translate(substring-before(substring-after(@path,'('),')'), '(1*(', '') = concat(concat($plainPath, '\'), @name)]">
            <xsl:sort select="not(@name='Info')" />
            <xsl:sort select="not(@name='Tracks')" />
            <xsl:sort select="not(@name='Cues')" />
            <xsl:sort select="not(@name='Tags')" />
            <xsl:sort select="@name='Chapters'" />
            <xsl:sort select="@name='Audio'" />
            <xsl:sort select="@name" />
            <xsl:if test="@type='master'">
                <xsl:call-template name="parsePath">
                    <xsl:with-param name="node" select="."/>
                </xsl:call-template>
            </xsl:if>
        </xsl:for-each>

    </xsl:template>

    <xsl:template name="outputAllEnums">
        <xsl:if test="ebml:restriction/ebml:enum and @type!='string'">
<!-- <xsl:text>
In outputAllEnums element, type:</xsl:text>
<xsl:value-of select="@type"/><xsl:text>&#10;</xsl:text> -->
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

            <xsl:for-each select="ebml:restriction/ebml:enum">
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
  
</xsl:stylesheet>
