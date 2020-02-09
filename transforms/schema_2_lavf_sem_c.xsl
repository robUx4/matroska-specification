<?xml version="1.0"?>
<!--
    File used to generate matroska_ids.h from ebml_matroska.xml or matroska_xsd.xml (the cleaned normative version)
    Usage: xsltproc -o matroskasem.c schema_2_lavf_sem_c.xsl ebml_matroska.xml
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" 
    xmlns:str="http://exslt.org/strings"
    exclude-result-prefixes="str xhtml ebml"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns="https://ietf.org/cellar/ebml" xmlns:ebml="https://ietf.org/cellar/ebml">
  <xsl:output encoding="UTF-8" method="text" version="1.0" indent="yes" />

  <xsl:template match="ebml:EBMLSchema">
<xsl:text>/*
 * Matroska file semantic definition
 * Copyright (c) 2003-2019 The FFmpeg Project
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

/**
 * @file
 * Matroska file semantic element definitions
 * @author Ronald Bultje &lt;rbultje@ronald.bitfreak.net&gt;
 * @author with a little help from Moritz Bunkus &lt;moritz@bunkus.org&gt;
 * @author totally reworked by Aurelien Jacobs &lt;aurel@gnuage.org&gt;
 * @author Split from decoder by Steve Lhomme &lt;slhomme@matroska.org&gt;
 * @see specs available on the Matroska project page: http://www.matroska.org/
 */

#include "config.h"

#include &lt;inttypes.h&gt;

#include "matroskasem.h"

#define CHILD_OF(parent) { .def = { .n = parent } }

static EbmlSyntax ebml_header[] = {
    { EBML_ID_EBMLREADVERSION,    EBML_UINT, 0, offsetof(Ebml, version),         { .u = EBML_VERSION } },
    { EBML_ID_EBMLMAXSIZELENGTH,  EBML_UINT, 0, offsetof(Ebml, max_size),        { .u = 8 } },
    { EBML_ID_EBMLMAXIDLENGTH,    EBML_UINT, 0, offsetof(Ebml, id_length),       { .u = 4 } },
    { EBML_ID_DOCTYPE,            EBML_STR,  0, offsetof(Ebml, doctype),         { .s = "(none)" } },
    { EBML_ID_DOCTYPEREADVERSION, EBML_UINT, 0, offsetof(Ebml, doctype_version), { .u = 1 } },
    { EBML_ID_EBMLVERSION,        EBML_NONE },
    { EBML_ID_DOCTYPEVERSION,     EBML_NONE },
    CHILD_OF(ebml_syntax)
};

static EbmlSyntax ebml_syntax[] = {
    { EBML_ID_HEADER,      EBML_NEST, 0, 0, { .n = ebml_header } },
    { MATROSKA_ID_SEGMENT, EBML_STOP },
    { 0 }
};
</xsl:text>

    <xsl:apply-templates select="ebml:element[@name='Segment']"/>
    <!-- TODO even closer ordering with a "sort score"  https://stackoverflow.com/questions/1287651/xslt-custom-sort -->

    <xsl:for-each select="ebml:element">
        <!-- <Parent path>/<id> -->
        <xsl:sort select="concat(
            substring( translate(@path, '\+', '\'),
                    1, 
                    string-length(translate(@path, '\+', '\'))-string-length(@name)
                    ),
            @id
        )" />

    </xsl:for-each>

<xsl:text>
#endif /* AVFORMAT_MATROSKASEM_H */
</xsl:text>

  </xsl:template>

    <xsl:template match="ebml:element">
        <xsl:call-template name="parsePath">
            <xsl:with-param name="node" select="."/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="parsePath">
        <xsl:param name="node"/>
        <xsl:variable name="plainPath">
            <xsl:value-of select="translate($node/@path, '\+', '\')" />
        </xsl:variable>
        <xsl:variable name="masterName">
            <xsl:choose>
                <xsl:when test="$node/@name='CuePoint'"><xsl:text>PointEntry</xsl:text></xsl:when>
                <xsl:when test="$node/@name='Audio'"><xsl:text>TrackAudio</xsl:text></xsl:when>
                <xsl:when test="$node/@name='Video'"><xsl:text>TrackVideo</xsl:text></xsl:when>
                <xsl:when test="$node/@name='Seek'"><xsl:text>SeekPoint</xsl:text></xsl:when>
                <xsl:when test="$node/@name='ContentEncoding'"><xsl:text>Content Encoding</xsl:text></xsl:when>
                <xsl:otherwise><xsl:value-of select="$node/@name"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Master element comment header -->
        <xsl:if test="@type='master'">
            <xsl:text>&#10;static EbmlSyntax </xsl:text>
            <xsl:text>matroska_</xsl:text>
            <xsl:value-of select="translate($masterName, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
            <xsl:text>[] = {&#10;</xsl:text>

            <xsl:for-each select="/ebml:EBMLSchema/ebml:element[translate(@path, '\+', '\') = concat(concat($plainPath, '\'), @name)]">
                <xsl:sort select="not(@name='Info')" />
                <xsl:sort select="not(@name='Tracks')" />
                <xsl:sort select="not(@name='Cues')" />
                <xsl:sort select="not(@name='Tags')" />
                <xsl:sort select="@name='Chapters'" />
                <xsl:sort select="@name='Audio'" />
                <xsl:sort select="string-length(@id)" />
                <xsl:sort select="@id" />
                <xsl:variable name="lavfName">
                    <!-- Transform the ebml_matroska.xml name into the libavformat name -->
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
                <xsl:variable name="lavfNameUpper">
                    <xsl:value-of select="translate($lavfName, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
                </xsl:variable>
                <xsl:text>    { MATROSKA_ID_</xsl:text>
                <xsl:choose>
                    <xsl:when test="string-length($lavfNameUpper) &lt; 18">
                        <xsl:value-of select="substring(concat($lavfNameUpper, ',                          '),0,17)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$lavfNameUpper"/><xsl:text>,</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text> </xsl:text>
                <xsl:choose>
                    <xsl:when test="@type='master'">
                        <xsl:text>EBML_LEVEL1, </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='uinteger'">
                        <xsl:text>EBML_UINT,   </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='utf-8'">
                        <xsl:text>EBML_UTF8,   </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='binary'">
                        <xsl:text>EBML_BIN,    </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='date'">
                        <xsl:text>EBML_BIN,    </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='float'">
                        <xsl:text>EBML_FLOAT,    </xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:text>0 </xsl:text>
                <xsl:text>&#10;</xsl:text>
                <xsl:if test="@name='TagDefault'"><xsl:text>#define MATROSKA_ID_TAGDEFAULT_BUG            0x44B4&#10;</xsl:text></xsl:if>
            </xsl:for-each>
            <xsl:choose>
                <xsl:when test="@name='Segment'">
                    <xsl:text>    { 0 }   /* We don't want to go back to level 0, so don't add the parent. */&#10;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>    CHILD_OF(matroska_</xsl:text>
                    <xsl:call-template name="parentName">
                        <xsl:with-param name="pText" select="substring($plainPath, 0, string-length($plainPath)-string-length(@name))"/>
                    </xsl:call-template>
                    <xsl:text>)&#10;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>};&#10;</xsl:text>

            <xsl:for-each select="../ebml:element[translate(@path, '\+', '\') = concat(concat($plainPath, '\'), @name)]">
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

        </xsl:if>

    </xsl:template>

    <xsl:template name="parentName">
        <xsl:param name="pText"/>
        <xsl:choose>
            <xsl:when test="contains($pText, '\')">
                <xsl:call-template name="parentName">
                    <xsl:with-param name="pText" select="substring-after($pText, '\')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="translate($pText, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="ConvertDecToHex">
        <xsl:param name="index" />
        <xsl:if test="$index > 0">
        <xsl:call-template name="ConvertDecToHex">
            <xsl:with-param name="index" select="floor($index div 16)" />
        </xsl:call-template>
        <xsl:choose>
            <xsl:when test="$index mod 16 &lt; 10">
                <xsl:value-of select="$index mod 16" />
            </xsl:when>
            <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="$index mod 16 = 10">A</xsl:when>
                <xsl:when test="$index mod 16 = 11">B</xsl:when>
                <xsl:when test="$index mod 16 = 12">C</xsl:when>
                <xsl:when test="$index mod 16 = 13">D</xsl:when>
                <xsl:when test="$index mod 16 = 14">E</xsl:when>
                <xsl:when test="$index mod 16 = 15">F</xsl:when>
                <xsl:otherwise>A</xsl:otherwise>
            </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template name="ConvertToHex">
        <xsl:param name="index" />
        <xsl:text>0x</xsl:text>
        <xsl:call-template name="ConvertDecToHex">
            <xsl:with-param name="index" select="$index" />
        </xsl:call-template>
    </xsl:template>

</xsl:stylesheet>
