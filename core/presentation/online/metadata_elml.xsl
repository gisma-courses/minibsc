<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" xmlns="http://www.w3.org/1999/xhtml" version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all">
    <!-- ***** Metadata Elements (only visible if role attribute allows it) *****-->
    <xsl:template match="elml:metadata">
        <xsl:param name="filename">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="($pagebreak_level='unit') or ($pagebreak_level='lo')">
                <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}{$filename}" format="online">
                    <html>
                        <xsl:call-template name="elml:LayoutHead"/>
                        <xsl:call-template name="elml:LayoutBody"/>
                    </html>
                </xsl:result-document>
            </xsl:when>
            <xsl:when test="$display='yes'">
                <xsl:call-template name="elml:LayoutBodyContent"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:organisation">
        <form action="">
            <p> Please note that the Metadata-chapter is only available in English!</p>
            <h3 id="Organisation">Organisation</h3>
            <table class="metadata_table">
                <tr>
                    <td valign="top">Level</td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="contains(elml:get_pathHTML(base-uri(),/elml:lesson/@label), 'gitta')">
                                <xsl:element name="input">
                                    <xsl:attribute name="type">
                                        <xsl:text>radio</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="name">
                                        <xsl:text>level</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="disabled">
                                        <xsl:text>disabled</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="value">
                                        <xsl:text>Basic</xsl:text>
                                    </xsl:attribute>
                                    <xsl:if test="@level='Basic'">
                                        <xsl:attribute name="checked">
                                            <xsl:text>checked</xsl:text>
                                        </xsl:attribute>
                                    </xsl:if>
                                </xsl:element> Basic <xsl:element name="input">
                                    <xsl:attribute name="type">
                                        <xsl:text>radio</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="name">
                                        <xsl:text>level</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="disabled">
                                        <xsl:text>disabled</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="value">
                                        <xsl:text>Intermediate</xsl:text>
                                    </xsl:attribute>
                                    <xsl:if test="@level='Intermediate'">
                                        <xsl:attribute name="checked">
                                            <xsl:text>checked</xsl:text>
                                        </xsl:attribute>
                                    </xsl:if>
                                </xsl:element> Intermediate <xsl:element name="input">
                                    <xsl:attribute name="type">
                                        <xsl:text>radio</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="name">
                                        <xsl:text>level</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="disabled">
                                        <xsl:text>disabled</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="value">
                                        <xsl:text>Case Study</xsl:text>
                                    </xsl:attribute>
                                    <xsl:if test="@level='Advanced'">
                                        <xsl:attribute name="checked">
                                            <xsl:text>checked</xsl:text>
                                        </xsl:attribute>
                                    </xsl:if>
                                </xsl:element> Advanced </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="@level"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <tr>
                    <td valign="top">Module:</td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="contains(elml:get_pathHTML(base-uri(),/elml:lesson/@label), 'gitta')">
                                <select name="module" disabled="disabled" size="8">
                                    <xsl:element name="option">
                                        <xsl:if test="@module='SY'">
                                            <xsl:attribute name="selected">
                                                <xsl:text>selected</xsl:text>
                                            </xsl:attribute>
                                        </xsl:if>SY: Evaluation and Use of Commercial GIS</xsl:element>
                                    <xsl:element name="option">
                                        <xsl:if test="@module='DC'">
                                            <xsl:attribute name="selected">
                                                <xsl:text>selected</xsl:text>
                                            </xsl:attribute>
                                        </xsl:if>DC: Data Capture</xsl:element>
                                    <xsl:element name="option">
                                        <xsl:if test="@module='SM'">
                                            <xsl:attribute name="selected">
                                                <xsl:text>selected</xsl:text>
                                            </xsl:attribute>
                                        </xsl:if>SM: Spatial Modeling</xsl:element>
                                    <xsl:element name="option">
                                        <xsl:if test="@module='DM'">
                                            <xsl:attribute name="selected">
                                                <xsl:text>selected</xsl:text>
                                            </xsl:attribute>
                                        </xsl:if>DM: Fundamentals of Database Systems</xsl:element>
                                    <xsl:element name="option">
                                        <xsl:if test="@module='AN'">
                                            <xsl:attribute name="selected">
                                                <xsl:text>selected</xsl:text>
                                            </xsl:attribute>
                                        </xsl:if>SA: Spatial Analysis</xsl:element>
                                    <xsl:element name="option">
                                        <xsl:if test="@module='PR'">
                                            <xsl:attribute name="selected">
                                                <xsl:text>selected</xsl:text>
                                            </xsl:attribute>
                                        </xsl:if>PR: Cartographic Data Presentation</xsl:element>
                                    <xsl:element name="option">
                                        <xsl:if test="@module='SD'">
                                            <xsl:attribute name="selected">
                                                <xsl:text>selected</xsl:text>
                                            </xsl:attribute>
                                        </xsl:if>SD: Systems Design</xsl:element>
                                    <xsl:element name="option">
                                        <xsl:if test="@module='CS'">
                                            <xsl:attribute name="selected">
                                                <xsl:text>selected</xsl:text>
                                            </xsl:attribute>
                                        </xsl:if>CS: Case Studies</xsl:element>
                                </select>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="@module"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <tr>
                    <td valign="top">Lesson:</td>
                    <td>
                        <xsl:apply-templates/>
                    </td>
                </tr>
            </table>
        </form>
    </xsl:template>
    <xsl:template match="elml:creationPosition">
        <xsl:choose>
            <xsl:when test="elml:posNumber">This is Lesson: <b>No. <xsl:value-of select="elml:posNumber"/> (<xsl:value-of select="/elml:lesson/@label"/>) </b>
            </xsl:when>
            <xsl:otherwise> The previous Lesson: <i>
                    <xsl:choose>
                        <xsl:when test="(elml:previous='none')">
                            <xsl:text>none</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:text>../../../</xsl:text>
                                    <xsl:value-of select="elml:previous"/>
                                    <xsl:text>/</xsl:text>
                                    <xsl:value-of select="$lang"/>
                                    <xsl:text>/html/index.html</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of select="elml:previous"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </i>
                <br/> This is Lesson: <b>
                    <xsl:value-of select="/elml:lesson/@label"/>
                </b>
                <br/> The following Lesson: <i>
                    <xsl:choose>
                        <xsl:when test="(elml:following='none')">
                            <xsl:text>none</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:text>../../../</xsl:text>
                                    <xsl:value-of select="elml:following"/>
                                    <xsl:text>/</xsl:text>
                                    <xsl:value-of select="$lang"/>
                                    <xsl:text>/html/index.html</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of select="elml:following"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </i>
            </xsl:otherwise>
        </xsl:choose>
        <br/>
    </xsl:template>
    <xsl:template match="elml:prerequisites">
        <h3 id="Prerequisites">Prerequisites</h3>
        <xsl:choose>
            <xsl:when test="elml:preReqItem and not(elml:preReqItem/@label='none')">
                <p>You should work through the following lessons or fulfill these prerequisites before starting this lesson:</p>
                <ul>
                    <xsl:apply-templates/>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <p>There are no prerequisites for this lesson. <xsl:value-of select="elml:preReqItem[@label='none']"/></p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:preReqItem">
        <li>
            <xsl:if test="@priority='High'">
                <b>Important: </b>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="(@label='none')"/>
                <xsl:otherwise>
                    <xsl:text>Lesson </xsl:text>
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:text>../../../</xsl:text>
                            <xsl:value-of select="@label"/>
                            <xsl:text>/</xsl:text>
                            <xsl:value-of select="$lang"/>
                            <xsl:text>/html/index.html</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="@label"/>
                    </xsl:element>
                    <xsl:text>: </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="."/>
            <xsl:if test="@priority">
                <i> (Priority: <xsl:value-of select="@priority"/>)</i>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:keywords">
        <xsl:if test="not(elml:keywordItem='')">
            <p><xsl:text>Keywords: </xsl:text>
                <xsl:for-each select="elml:keywordItem">
                    <xsl:sort/>
                    <xsl:value-of select="."/>
                    <xsl:if test="not(position()=last())">, </xsl:if>
                </xsl:for-each>. </p>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:technical">
        <h3 id="Technical"> Technical requirements </h3>
        <p>The following Multimedia-types are used in this lesson. Please check that your browser supports them all:</p>
        <ul>
            <li>Text</li>
            <xsl:if test="//elml:multimedia/@type='gif'">
                <li>Picture (GIF)</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='jpeg'">
                <li>Picture (JPEG)</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='png'">
                <li>Picture (PNG)</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='flash'">
                <li>Flash</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='quicktime'">
                <li>Quicktime Video</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='mpeg'">
                <li>MPEG Video</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='mp3'">
                <li>MP3</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='realone'">
                <li>RealOne (Audio/Video)</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='svg'">
                <li>SVG</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='applet'">
                <li>Java Applet</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='vrml'">
                <li>VRML</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='x3d'">
                <li>X3D</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='mathml'">
                <li>MathML</li>
            </xsl:if>
            <xsl:if test="//elml:multimedia/@type='div'">
                <li>HTML or PHP</li>
            </xsl:if>
        </ul>
        <p>Please check that your computer meets the following technical requirements:</p>
        <table class="metadata_table">
            <tr>
                <td>
                    <b>Type</b>
                </td>
                <td>
                    <b>Name</b>
                </td>
                <td>
                    <b>min. Ver.</b>
                </td>
                <td>
                    <b>Installation remarks</b>
                </td>
            </tr>
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    <xsl:template match="elml:technicalRequirement">
        <tr>
            <td>
                <xsl:value-of select="elml:type"/>
            </td>
            <td>
                <xsl:choose>
                    <xsl:when test="elml:downloadURL">
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="elml:downloadURL"/>
                            </xsl:attribute>
                            <xsl:value-of select="elml:name"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="elml:name"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <xsl:value-of select="elml:minimumVersion"/>
            </td>
            <td>
                <xsl:value-of select="elml:installationRemarks"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="elml:lessonInfo">
        <h3 id="Information">Lesson Information </h3>
        <form action="">
            <table class="metadata_table">
                <tr>
                    <td valign="top">Language: </td>
                    <td>
                        <p>
                            <xsl:element name="input">
                                <xsl:attribute name="type">
                                    <xsl:text>radio</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="name">
                                    <xsl:text>language</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="disabled">
                                    <xsl:text>disabled</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="value">
                                    <xsl:text>en</xsl:text>
                                </xsl:attribute>
                                <xsl:if test="elml:language/@language='en'">
                                    <xsl:attribute name="checked">
                                        <xsl:text>checked</xsl:text>
                                    </xsl:attribute>
                                </xsl:if>
                            </xsl:element> English (EN) <xsl:element name="input">
                                <xsl:attribute name="type">
                                    <xsl:text>radio</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="name">
                                    <xsl:text>language</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="disabled">
                                    <xsl:text>disabled</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="value">
                                    <xsl:text>de</xsl:text>
                                </xsl:attribute>
                                <xsl:if test="elml:language/@language='de'">
                                    <xsl:attribute name="checked">
                                        <xsl:text>checked</xsl:text>
                                    </xsl:attribute>
                                </xsl:if>
                            </xsl:element> German (DE) <xsl:element name="input">
                                <xsl:attribute name="type">
                                    <xsl:text>radio</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="name">
                                    <xsl:text>language</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="disabled">
                                    <xsl:text>disabled</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="value">
                                    <xsl:text>fr</xsl:text>
                                </xsl:attribute>
                                <xsl:if test="elml:language/@language='fr'">
                                    <xsl:attribute name="checked">
                                        <xsl:text>checked</xsl:text>
                                    </xsl:attribute>
                                </xsl:if>
                            </xsl:element> French (FR) <xsl:element name="input">
                                <xsl:attribute name="type">
                                    <xsl:text>radio</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="name">
                                    <xsl:text>language</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="disabled">
                                    <xsl:text>disabled</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="value">
                                    <xsl:text>it</xsl:text>
                                </xsl:attribute>
                                <xsl:if test="elml:language/@language='it'">
                                    <xsl:attribute name="checked">
                                        <xsl:text>checked</xsl:text>
                                    </xsl:attribute>
                                </xsl:if>
                            </xsl:element> Italian (IT) </p>
                        <p>
                            <xsl:choose>
                                <xsl:when test="elml:language/@derived='yes'"> This lesson has been translated from <i>
                                        <xsl:value-of select="elml:language/@originalLanguage"/>
                                    </i> to the actual language! </xsl:when>
                                <xsl:otherwise> This is the original language of this lesson. </xsl:otherwise>
                            </xsl:choose>
                        </p>
                    </td>
                </tr>
                <xsl:apply-templates/>
            </table>
        </form>
    </xsl:template>
    <xsl:template match="elml:lifecycle">
        <tr>
            <td valign="top">Lifecycle: </td>
            <td>Version <b>
                    <xsl:value-of select="elml:version"/>
                </b> (Created: <xsl:value-of select="elml:version/@creationDate"/>; last modified: <xsl:value-of select="elml:version/@modificationDate"/>).</td>
        </tr>
        <tr>
            <td valign="top">Authors: </td>
            <td>
                <ul>
                    <xsl:apply-templates select="elml:contribute"/>
                </ul>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="elml:contribute">
        <xsl:for-each select="elml:person">
            <li>
                <xsl:value-of select="@name"/> (<xsl:value-of select="@responsible"/>, <xsl:value-of select="@departement"/>@<xsl:value-of select="@institute"/>
                <xsl:if test="@email">
                    <xsl:text>, </xsl:text>
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:text>mailto:</xsl:text>
                            <xsl:value-of select="@email"/>
                        </xsl:attribute>
                        <xsl:value-of select="@email"/>
                    </xsl:element>
                </xsl:if>
                <xsl:text>)</xsl:text>
                <xsl:if test="not(.='')">
                    <xsl:text>: </xsl:text>
                    <i>
                        <xsl:value-of select="."/>
                    </i>
                </xsl:if>
            </li>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="elml:educational">
        <xsl:if test="elml:difficulty">
            <tr>
                <td valign="top">Difficulty Level: </td>
                <td>
                    <xsl:element name="input">
                        <xsl:attribute name="type">
                            <xsl:text>radio</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>difficulty</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="disabled">
                            <xsl:text>disabled</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="value">
                            <xsl:text>Low</xsl:text>
                        </xsl:attribute>
                        <xsl:if test="elml:difficulty='Low'">
                            <xsl:attribute name="checked">
                                <xsl:text>checked</xsl:text>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:element> Low <xsl:element name="input">
                        <xsl:attribute name="type">
                            <xsl:text>radio</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>difficulty</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="disabled">
                            <xsl:text>disabled</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="value">
                            <xsl:text>Medium</xsl:text>
                        </xsl:attribute>
                        <xsl:if test="elml:difficulty='Medium'">
                            <xsl:attribute name="checked">
                                <xsl:text>checked</xsl:text>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:element> Medium <xsl:element name="input">
                        <xsl:attribute name="type">
                            <xsl:text>radio</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>difficulty</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="disabled">
                            <xsl:text>disabled</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="value">
                            <xsl:text>High</xsl:text>
                        </xsl:attribute>
                        <xsl:if test="elml:difficulty='High'">
                            <xsl:attribute name="checked">
                                <xsl:text>checked</xsl:text>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:element> High</td>
            </tr>
        </xsl:if>
        <tr>
            <td valign="top">Typical Learning Time: </td>
            <td>
                <xsl:value-of select="elml:typicalLearningTime/elml:time"/>
                <xsl:if test="elml:typicalLearningTime/elml:description"> (<xsl:value-of select="elml:typicalLearningTime/elml:description"/>)</xsl:if>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="elml:rights"/>
</xsl:stylesheet>
