<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:str="http://exslt.org/strings" exclude-result-prefixes="str">
    <!-- TODO: get the parent from the Path: last of(Path, before(/name), /) -->
    <!-- TODO: get the number before the parent -->
  <xsl:output encoding="UTF-8" method="text" version="1.0" indent="yes" />
  <xsl:template match="EBMLSchema">/**********************************************************************
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
<xsl:apply-templates select="element">
  <xsl:sort select="@sortPath" />
</xsl:apply-templates>
END_LIBMATROSKA_NAMESPACE
</xsl:template>
  <xsl:template match="element">
    <xsl:copy>
        <xsl:choose>
            <xsl:when test="@type='master'">
                <xsl:text>DEFINE_START_SEMANTIC(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>)&#10;</xsl:text>
                <xsl:text>DEFINE_END_SEMANTIC(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>)&#10;</xsl:text>
                <xsl:text>DEFINE_MKX_MASTER(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, 2, KaxParent, "</xsl:text>
                <xsl:value-of select="@name" /><xsl:text>")&#10;</xsl:text>
            </xsl:when>
            <xsl:when test="@type='binary'">
                <xsl:text>DEFINE_MKX_BINARY(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, 2, KaxParent, "</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="@name" /><xsl:text>")&#10;</xsl:text>
            </xsl:when>
            <xsl:when test="@type='uinteger'">
                <xsl:text>DEFINE_MKX_UINTEGER</xsl:text>
                <xsl:if test="@default"><xsl:text>_DEF</xsl:text></xsl:if>
                <xsl:text>(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, 2, KaxParent, "</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>"</xsl:text>
                <xsl:if test="@default"><xsl:text>, </xsl:text><xsl:value-of select="@default" /></xsl:if>
                <xsl:text>)&#10;</xsl:text>
            </xsl:when>
            <xsl:when test="@type='integer'">
                <xsl:text>DEFINE_MKX_SINTEGER</xsl:text>
                <xsl:if test="@default"><xsl:text>_DEF</xsl:text></xsl:if>
                <xsl:text>(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, 2, KaxParent, "</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>"</xsl:text>
                <xsl:if test="@default"><xsl:text>, </xsl:text><xsl:value-of select="@default" /></xsl:if>
                <xsl:text>)&#10;</xsl:text>
            </xsl:when>
            <xsl:when test="@type='utf-8'">
                <xsl:text>DEFINE_MKX_UNISTRING</xsl:text>
                <xsl:if test="@default"><xsl:text>_DEF</xsl:text></xsl:if>
                <xsl:text>(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, 2, KaxParent, "</xsl:text>
                <xsl:value-of select="@name" /><xsl:text>"</xsl:text>
                <xsl:if test="@default"><xsl:text>, </xsl:text><xsl:value-of select="@default" /></xsl:if>
                <xsl:text>)&#10;</xsl:text>
            </xsl:when>
            <xsl:when test="@type='string'">
                <xsl:text>DEFINE_MKX_STRING</xsl:text>
                <xsl:if test="@default"><xsl:text>_DEF</xsl:text></xsl:if>
                <xsl:text>(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, 2, KaxParent, "</xsl:text>
                <xsl:value-of select="@name" /><xsl:text>"</xsl:text>
                <xsl:if test="@default"><xsl:text>, </xsl:text><xsl:value-of select="@default" /></xsl:if>
                <xsl:text>)&#10;</xsl:text>
            </xsl:when>
            <xsl:when test="@type='float'">
                <xsl:text>DEFINE_MKX_FLOAT</xsl:text>
                <xsl:if test="@default"><xsl:text>_DEF</xsl:text></xsl:if>
                <xsl:text>(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, 2, KaxParent, "</xsl:text>
                <xsl:value-of select="@name" /><xsl:text>"</xsl:text>
                <xsl:if test="@default"><xsl:text>, </xsl:text><xsl:value-of select="@default" /></xsl:if>
                <xsl:text>)&#10;</xsl:text>
            </xsl:when>
            <xsl:when test="@type='date'">
                <xsl:text>DEFINE_MKX_DATE</xsl:text>
                <xsl:if test="@default"><xsl:text>_DEF</xsl:text></xsl:if>
                <xsl:text>(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, 2, KaxParent, "</xsl:text>
                <xsl:value-of select="@name" /><xsl:text>"</xsl:text>
                <xsl:if test="@default"><xsl:text>, </xsl:text><xsl:value-of select="@default" /></xsl:if>
                <xsl:text>)&#10;</xsl:text>
            </xsl:when>
        </xsl:choose>
        <!-- <xsl:attribute name="name">placeholder before parsePath is called</xsl:attribute>
        <xsl:attribute name="path"><xsl:value-of select="@path" /></xsl:attribute>
        <xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
        <xsl:attribute name="type"><xsl:value-of select="@type" /></xsl:attribute>
        <xsl:if test="@minver and minver!='1'">
            <xsl:attribute name="minver"><xsl:value-of select="@minver" /></xsl:attribute>
        </xsl:if>
        <xsl:if test="@maxver">
            <xsl:attribute name="maxver"><xsl:value-of select="@maxver" /></xsl:attribute>
        </xsl:if>
        <xsl:if test="@range">
            <xsl:attribute name="range"><xsl:value-of select="@range" /></xsl:attribute>
        </xsl:if>
        <xsl:if test="@length">
            <xsl:attribute name="length"><xsl:value-of select="@length" /></xsl:attribute>
        </xsl:if>
        <xsl:if test="@default">
            <xsl:attribute name="default"><xsl:value-of select="@default" /></xsl:attribute>
        </xsl:if>
        <xsl:call-template name="parsePath">
            <xsl:with-param name="Path"><xsl:value-of select="@path" /></xsl:with-param>
        </xsl:call-template>
        <xsl:if test="@recurring">
            <xsl:attribute name="recurring"><xsl:value-of select="@recurring" /></xsl:attribute>
        </xsl:if>
        <xsl:if test="@unknownsizeallowed">
            <xsl:attribute name="unknownsizeallowed"><xsl:value-of select="@unknownsizeallowed" /></xsl:attribute>
        </xsl:if>
        <xsl:apply-templates select="documentation"/>
        <xsl:if test="restriction">
            <restriction>
                <xsl:for-each select="restriction/enum">
                    <xsl:sort select="value"/>
                    <enum value="{@value}">
                        <xsl:if test="@label">
                            <xsl:attribute name="label"><xsl:value-of select="@label" /></xsl:attribute>
                        </xsl:if>
                        <xsl:apply-templates select="documentation"/>
                    </enum>
                </xsl:for-each>
            </restriction>
        </xsl:if> -->
    </xsl:copy>
  </xsl:template>
  <xsl:template match="documentation">
    <documentation>
        <xsl:attribute name="lang"><xsl:value-of select="@lang" /></xsl:attribute>
        <xsl:if test="@type">
            <xsl:attribute name="type"><xsl:value-of select="@type" /></xsl:attribute>
        </xsl:if>
        <!-- <xsl:attribute name="type">
            <xsl:choose>
                <xsl:when test="@type">
                    <xsl:value-of select="@type"/>
                </xsl:when>
                <xsl:otherwise>documentation</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute> -->
        <!-- make sure the links are kept -->
        <xsl:apply-templates/>
    </documentation>
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

  <xsl:template name="parsePath">
    <xsl:param name="Path"/>
    <xsl:variable name="EBMLElementOccurrence" select="substring-before($Path,'(')"/>
    <xsl:variable name="EBMLMinOccurrence"     select="substring-before($EBMLElementOccurrence,'*')"/>
    <xsl:variable name="EBMLMaxOccurrence"     select="substring-after($EBMLElementOccurrence,'*')"/>
    <xsl:variable name="EBMLMasterPath"   select="substring-before(substring-after($Path,'('),')')"/>
    <xsl:call-template name="get-element-name">
        <xsl:with-param name="value"><xsl:value-of select="$EBMLMasterPath" /></xsl:with-param>
    </xsl:call-template>
    <xsl:if test="$EBMLMinOccurrence and $EBMLMinOccurrence!='0'">
      <xsl:attribute name="minOccurs"><xsl:value-of select="$EBMLMinOccurrence" /></xsl:attribute>
    </xsl:if>
    <xsl:if test="$EBMLMaxOccurrence">
      <xsl:attribute name="maxOccurs"><xsl:value-of select="$EBMLMaxOccurrence" /></xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="get-element-name">
    <xsl:param name="value"/>
    <xsl:param name="separator"/>
    <xsl:choose>
        <xsl:when test="contains($value, '\')">
            <xsl:call-template name="get-element-name">
                <xsl:with-param name="value"><xsl:value-of select="substring-after($value, '\')" /></xsl:with-param>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:attribute name="name"><xsl:value-of select="$value" /></xsl:attribute>
        </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
