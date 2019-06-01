<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:str="http://exslt.org/strings" exclude-result-prefixes="str">
  <!-- File used to generate KaxSemantic.cpp -->
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
    <xsl:sort select="translate(substring-before(substring-after(@path,'('),')'), '(1*(', '')" />
</xsl:apply-templates>
END_LIBMATROSKA_NAMESPACE

</xsl:template>
  <xsl:template match="element">
    <xsl:variable name="plainPath"><xsl:value-of select="translate(substring-before(substring-after(@path,'('),')'), '(1*(', '')" /></xsl:variable>
<!-- <xsl:text>plainPath = </xsl:text><xsl:value-of select="$plainPath" /><xsl:text>&#10;</xsl:text> -->
    <!-- Ignore EBML extra constraints -->
    <xsl:if test="not(starts-with($plainPath,'\EBML\'))">
    <xsl:copy>
        <xsl:if test="@minver and @minver!='1'">#if MATROSKA_VERSION >= 2&#10;</xsl:if>
        <xsl:choose>
            <xsl:when test="@type='master'">
                <xsl:text>&#10;</xsl:text>
                
                <xsl:text>DEFINE_START_SEMANTIC(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>)&#10;</xsl:text>
                <xsl:call-template name="list-master-children">
                    <xsl:with-param name="findPath"><xsl:value-of select="$plainPath" /></xsl:with-param>
                </xsl:call-template>
                <xsl:text>DEFINE_END_SEMANTIC(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>)&#10;&#10;</xsl:text>

                <xsl:text>DEFINE_MKX_MASTER</xsl:text>
                <xsl:if test="not(contains(substring($plainPath,2),'\'))"><xsl:text>_ORPHAN</xsl:text></xsl:if>
                <!-- Needs a special constructor -->
                <xsl:if test="@name='Attachments' or @name='AttachedFile' or @name='Cluster' or @name='BlockGroup' or @name='TrackEntry'"><xsl:text>_CONS</xsl:text></xsl:if>
                <xsl:text>(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, </xsl:text>
                <xsl:value-of select="((string-length(@id) - 2) * 0.5)" /> 
                <xsl:choose>
                    <xsl:when test="not(contains(substring($plainPath,2),'\'))">
                        <xsl:text>, "</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>, Kax</xsl:text>
                        <xsl:call-template name="output-master-parent">
                            <xsl:with-param name="findPath"><xsl:value-of select="$plainPath" /></xsl:with-param>
                            <xsl:with-param name="name"><xsl:value-of select="@name" /></xsl:with-param>
                        </xsl:call-template>
                        <xsl:text>, "</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>")&#10;</xsl:text>
                
            </xsl:when>
            <xsl:when test="@type='binary'">
                
                <xsl:text>DEFINE_MKX_BINARY</xsl:text>
                <xsl:choose>
                    <!-- Needs a special constructor -->
                    <xsl:when test="@name='Block' or @name='SimpleBlock' or @name='BlockVirtual' or @name='NextUID' or @name='PrevUID'"><xsl:text>_CONS</xsl:text></xsl:when>
                    <xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
                </xsl:choose>
                <xsl:text>(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, </xsl:text>
                <xsl:value-of select="((string-length(@id) - 2) * 0.5)" /> 
                <xsl:text>, Kax</xsl:text>
                    <xsl:call-template name="output-master-parent">
                        <xsl:with-param name="findPath"><xsl:value-of select="$plainPath" /></xsl:with-param>
                        <xsl:with-param name="name"><xsl:value-of select="@name" /></xsl:with-param>
                    </xsl:call-template>
                <xsl:text>, "</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>")&#10;</xsl:text>
                
            </xsl:when>
            <xsl:when test="@type='uinteger'">
                
                <xsl:text>DEFINE_MKX_UINTEGER</xsl:text>
                <xsl:if test="@default and (number(@default)=number(@default))"><xsl:text>_DEF</xsl:text></xsl:if>
                <xsl:text>(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, </xsl:text>
                <xsl:value-of select="((string-length(@id) - 2) * 0.5)" /> 
                <xsl:text>, Kax</xsl:text>
                    <xsl:call-template name="output-master-parent">
                        <xsl:with-param name="findPath"><xsl:value-of select="$plainPath" /></xsl:with-param>
                        <xsl:with-param name="name"><xsl:value-of select="@name" /></xsl:with-param>
                    </xsl:call-template>
                <xsl:text>, "</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>"</xsl:text>
                <xsl:if test="@default and (number(@default)=number(@default))"><xsl:text>, </xsl:text><xsl:value-of select="@default" /></xsl:if>
                <xsl:text>)&#10;</xsl:text>
                
            </xsl:when>
            <xsl:when test="@type='integer'">
                
                <xsl:text>DEFINE_MKX_SINTEGER</xsl:text>
                <xsl:if test="@default and (number(@default)=number(@default))"><xsl:text>_DEF</xsl:text></xsl:if>
                <!-- Needs a special constructor -->
                <xsl:if test="@name='ReferenceBlock'"><xsl:text>_CONS</xsl:text></xsl:if>
                <xsl:text>(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, </xsl:text>
                <xsl:value-of select="((string-length(@id) - 2) * 0.5)" /> 
                <xsl:text>, Kax</xsl:text>
                    <xsl:call-template name="output-master-parent">
                        <xsl:with-param name="findPath"><xsl:value-of select="$plainPath" /></xsl:with-param>
                        <xsl:with-param name="name"><xsl:value-of select="@name" /></xsl:with-param>
                    </xsl:call-template>
                <xsl:text>, "</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>"</xsl:text>
                <xsl:if test="@default and (number(@default)=number(@default))"><xsl:text>, </xsl:text><xsl:value-of select="@default" /></xsl:if>
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
                <xsl:value-of select="@id" /><xsl:text>, </xsl:text>
                <xsl:value-of select="((string-length(@id) - 2) * 0.5)" /> 
                <xsl:text>, Kax</xsl:text>
                    <xsl:call-template name="output-master-parent">
                        <xsl:with-param name="findPath"><xsl:value-of select="$plainPath" /></xsl:with-param>
                        <xsl:with-param name="name"><xsl:value-of select="@name" /></xsl:with-param>
                    </xsl:call-template>
                <xsl:text>, "</xsl:text>
                <xsl:value-of select="@name" /><xsl:text>"</xsl:text>
                <xsl:if test="@default"><xsl:text>, "</xsl:text><xsl:value-of select="@default" />"</xsl:if>
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
                <xsl:value-of select="@id" /><xsl:text>, </xsl:text>
                <xsl:value-of select="((string-length(@id) - 2) * 0.5)" /> 
                <xsl:text>, Kax</xsl:text>
                    <xsl:call-template name="output-master-parent">
                        <xsl:with-param name="findPath"><xsl:value-of select="$plainPath" /></xsl:with-param>
                        <xsl:with-param name="name"><xsl:value-of select="@name" /></xsl:with-param>
                    </xsl:call-template>
                <xsl:text>, "</xsl:text>
                <xsl:value-of select="@name" /><xsl:text>"</xsl:text>
                <xsl:if test="@default"><xsl:text>, "</xsl:text><xsl:value-of select="@default" /><xsl:text>"</xsl:text></xsl:if>
                <xsl:text>)&#10;</xsl:text>
                
            </xsl:when>
            <xsl:when test="@type='float'">
                
                <xsl:text>DEFINE_MKX_FLOAT</xsl:text>
                <xsl:if test="@default and starts-with(@default,'0x')"><xsl:text>_DEF</xsl:text></xsl:if>
                <xsl:text>(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, </xsl:text>
                <xsl:value-of select="((string-length(@id) - 2) * 0.5)" /> 
                <xsl:text>, Kax</xsl:text>
                    <xsl:call-template name="output-master-parent">
                        <xsl:with-param name="findPath"><xsl:value-of select="$plainPath" /></xsl:with-param>
                        <xsl:with-param name="name"><xsl:value-of select="@name" /></xsl:with-param>
                    </xsl:call-template>
                <xsl:text>, "</xsl:text>
                <xsl:value-of select="@name" /><xsl:text>"</xsl:text>
                <xsl:if test="@default and starts-with(@default,'0x')">
                    <xsl:choose>
                        <xsl:when test="@default='0x1p+0'">, 1</xsl:when>
                        <xsl:when test="@default='0x0p+0'">, 0</xsl:when>
                        <xsl:when test="@default='0x1.f4p+12'">, 8000</xsl:when>
                        <xsl:otherwise><xsl:text>, </xsl:text><xsl:value-of select="@default" /></xsl:otherwise>>
                    </xsl:choose>
                </xsl:if>
                <xsl:text>)&#10;</xsl:text>
                
            </xsl:when>
            <xsl:when test="@type='date'">
                <xsl:text>DEFINE_MKX_DATE</xsl:text>
                <xsl:choose>
                    <xsl:when test="@default and (number(@default)=number(@default))"><xsl:text>_DEF</xsl:text></xsl:when>
                    <xsl:otherwise><xsl:text>    </xsl:text></xsl:otherwise>
                </xsl:choose>
                <xsl:text>(Kax</xsl:text>
                <xsl:choose>
                    <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                    <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@id" /><xsl:text>, </xsl:text>
                <xsl:value-of select="((string-length(@id) - 2) * 0.5)" /> 
                <xsl:text>, Kax</xsl:text>
                    <xsl:call-template name="output-master-parent">
                        <xsl:with-param name="findPath"><xsl:value-of select="$plainPath" /></xsl:with-param>
                        <xsl:with-param name="name"><xsl:value-of select="@name" /></xsl:with-param>
                    </xsl:call-template>
                <xsl:text>, "</xsl:text>
                <xsl:value-of select="@name" /><xsl:text>"</xsl:text>
                <xsl:if test="@default and (number(@default)=number(@default))"><xsl:text>, </xsl:text><xsl:value-of select="@default" /></xsl:if>
                <xsl:text>)&#10;</xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="@maxver">
            <xsl:text>&#10;filepos_t Kax</xsl:text>
            <xsl:choose>
                <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
            </xsl:choose>
            <xsl:text>::RenderData(IOCallback &amp; /* output */, bool /* bForceRender */, bool /* bSaveDefault */) {&#10;</xsl:text>
            <xsl:text>  assert(false); // no you are not allowed to use this element !&#10;</xsl:text>
            <xsl:text>  return 0;&#10;</xsl:text>
            <xsl:text>}&#10;</xsl:text>
        </xsl:if>
        <xsl:if test="@minver and @minver!='1'">#endif&#10;</xsl:if>
    </xsl:copy>
    </xsl:if>
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

  <xsl:template name="list-master-children">
    <xsl:param name="findPath"/>
    <xsl:for-each select="../element">
        <xsl:variable name="plainPath"><xsl:value-of select="translate(substring-before(substring-after(@path,'('),')'), '(1*(', '')" /></xsl:variable>
        <xsl:if test="$plainPath=concat(concat($findPath,'\'),@name) or ($plainPath=$findPath and contains(@path,'(1*(\'))">
            <xsl:variable name="EBMLElementOccurrence" select="substring-before(@path,'(')"/>
            <xsl:variable name="EBMLMinOccurrence"     select="substring-before($EBMLElementOccurrence,'*')"/>
            <xsl:variable name="EBMLMaxOccurrence"     select="substring-after($EBMLElementOccurrence,'*')"/>
            <xsl:if test="@minver and @minver!='1'">#if MATROSKA_VERSION >= 2&#10;</xsl:if>
            <xsl:text>DEFINE_SEMANTIC_ITEM(</xsl:text>
            <xsl:choose>
                <xsl:when test="$plainPath=$findPath and contains(@path,'(1*(\')"><xsl:text>false</xsl:text></xsl:when>
                <xsl:when test="$EBMLMinOccurrence!='' and $EBMLMinOccurrence!='0'"><xsl:text>true</xsl:text></xsl:when>
                <xsl:otherwise><xsl:text>false</xsl:text></xsl:otherwise>
            </xsl:choose>
            <xsl:text>, </xsl:text>
            <xsl:choose>
                <xsl:when test="$EBMLMaxOccurrence='1'"><xsl:text>true</xsl:text></xsl:when>
                <xsl:otherwise><xsl:text>false</xsl:text></xsl:otherwise>
            </xsl:choose>
            <xsl:text>, Kax</xsl:text>
            <xsl:choose>
                <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
            </xsl:choose>
            <xsl:text>)</xsl:text>
            <xsl:if test="$plainPath=$findPath and contains(@path,'(1*(\')"><xsl:text> // recursive</xsl:text></xsl:if>
            <xsl:if test="@maxver='0'">
                <xsl:choose>
                    <xsl:when test="@divx='1'"><xsl:text> // DivX specific</xsl:text></xsl:when>
                    <xsl:otherwise><xsl:text> // not supported</xsl:text></xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:text>&#10;</xsl:text>
            <xsl:if test="@minver and @minver!='1'">#endif // MATROSKA_VERSION&#10;</xsl:if>
        </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="output-master-parent">
    <xsl:param name="findPath"/>
    <xsl:param name="name"/>
    <xsl:for-each select="../element">
        <xsl:variable name="plainPath"><xsl:value-of select="translate(substring-before(substring-after(@path,'('),')'), '(1*(', '')" /></xsl:variable>
        <xsl:if test="$findPath=concat(concat($plainPath,'\'),$name)">
            <xsl:choose>
                <xsl:when test="@cppname"><xsl:value-of select="@cppname" /></xsl:when>
                <xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
