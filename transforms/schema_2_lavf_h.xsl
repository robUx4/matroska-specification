<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:str="http://exslt.org/strings" exclude-result-prefixes="str">
  <!-- File used to generate KaxSemantic.h -->
  <xsl:output encoding="UTF-8" method="text" version="1.0" indent="yes" />
  <xsl:template match="EBMLSchema">/**********************************************************************
/*
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
    <xsl:sort select="translate(substring-before(substring-after(@path,'('),')'), '(1*(', '')" />
</xsl:apply-templates>

#endif /* AVFORMAT_MATROSKA_IDS_H */
</xsl:template>
  <xsl:template match="element">
    <xsl:variable name="plainPath"><xsl:value-of select="translate(substring-before(substring-after(@path,'('),')'), '(1*(', '')" /></xsl:variable>
<!-- <xsl:text>plainPath = </xsl:text><xsl:value-of select="$plainPath" /><xsl:text>&#10;</xsl:text> -->
    <!-- Ignore EBML extra constraints -->
    <xsl:if test="not(starts-with($plainPath,'\EBML\'))">
    <!-- <xsl:copy> -->
        <xsl:choose>
            <xsl:when test="@name='Segment'"><xsl:text>/* toplevel segment */&#10;</xsl:text></xsl:when>
        </xsl:choose>
        <xsl:text>#define MATROSKA_ID_</xsl:text>
        <xsl:call-template name="outputName">
            <xsl:with-param name="baseName" select="@name"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:value-of select="@id" />
        <xsl:text>&#10;</xsl:text>
        <xsl:choose>
            <xsl:when test="@name='Attachments'"><xsl:text>&#10;/* IDs in the attachments master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='Chapters'"><xsl:text>&#10;/* IDs in the chapters master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='Cluster'"><xsl:text>&#10;/* IDs in the cluster master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='Cues'"><xsl:text>&#10;/* IDs in the cues master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='BlockGroup'"><xsl:text>&#10;/* IDs in the blockgroup master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='Seek'"><xsl:text>&#10;/* IDs in the seekpoint master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='SeekHead'"><xsl:text>&#10;/* IDs in the seekhead master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='Tags'"><xsl:text>&#10;/* IDs in the tags master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='Tracks'"><xsl:text>&#10;/* IDs in the tracks master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='TrackEntry'"><xsl:text>&#10;/* IDs in the trackentry master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='Audio'"><xsl:text>&#10;/* IDs in the trackaudio master */&#10;</xsl:text></xsl:when>
            <xsl:when test="@name='Video'"><xsl:text>&#10;/* IDs in the trackvideo master */&#10;</xsl:text></xsl:when>
        </xsl:choose>
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

  <xsl:template name="outputName">
    <xsl:param name="baseName"/>
    <xsl:choose>
        <xsl:when test="$baseName='FileDescription'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'FileDesc'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ChapLanguage'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'ChapLang'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ChapLanguage'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'ChapLang'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ReferenceBlock'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'BlockReference'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='Position'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'ClusterPosition'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='PrevSize'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'ClusterPrevSize'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='Timestamp'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'ClusterTimecode'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='CuePoint'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'PointEntry'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='TimestampScale'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'TimecodeScale'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='Seek'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'SeekEntry'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='TagLanguage'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'TagLang'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='Targets'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'TagTargets'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='TagAttachmentUID'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'TagTargets_AttachUID'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='TagChapterUID'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'TagTargets_ChapterUID'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='TagTrackUID'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'TagTargets_TrackUID'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='TargetType'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'TagTargets_Type'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='TargetTypeValue'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'TagTargets_TypeValue'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='Audio'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'TrackAudio'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='BitDepth'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'AudioBitDepth'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='Channels'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'AudioChannels'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='OutputSamplingFrequency'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'AudioOutSamplingFreq'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='SamplingFrequency'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'AudioSamplingFreq'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='Video'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'TrackVideo'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentEncodings'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'TrackContentEncodings'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentEncoding'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'TrackContentEncoding'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentCompression'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingCompression'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentCompAlgo'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingCompAlgo'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentCompSettings'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingCompSettings'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentEncodingOrder'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingOrder'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentEncodingScope'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingScope'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentEncodingType'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingType'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentEncryption'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingEncryption'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentEncAESSettings'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingEncAESSettings'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentEncAlgo'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingEncAlgo'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentEncKeyID'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingEncKeyId'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentSigAlgo'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingSigAlgo'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentSignature'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingSignature'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentSigKeyID'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingSigKeyId'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$baseName='ContentSigHashAlgo'">
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="'EncodingSigHashAlgo'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="outputRenamed">
                <xsl:with-param name="renamed" select="$baseName"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

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
