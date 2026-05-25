<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" xmlns="http://www.w3.org/1999/xhtml" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all">
    <xsl:template match="elml:tableheading">
        <th>
            <xsl:call-template name="elml:CSS_Class"/>
            <xsl:call-template name="elml:Label"/>
            <xsl:call-template name="elml:Alignment"/>
            <xsl:if test="@colspan">
                <xsl:attribute name="colspan">
                    <xsl:value-of select="@colspan"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@rowspan">
                <xsl:attribute name="rowspan">
                    <xsl:value-of select="@rowspan"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </th>
    </xsl:template>
    <xsl:template match="elml:tabledata">
        <td>
            <xsl:call-template name="elml:CSS_Class"/>
            <xsl:call-template name="elml:Label"/>
            <xsl:call-template name="elml:Alignment"/>
            <xsl:if test="@colspan">
                <xsl:attribute name="colspan">
                    <xsl:value-of select="@colspan"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@rowspan">
                <xsl:attribute name="rowspan">
                    <xsl:value-of select="@rowspan"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    <xsl:template match="elml:list">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:call-template name="elml:Title"/>
            <xsl:if test="@icon and not($layout='none')">
                <p>
                    <xsl:call-template name="Icon">
                        <xsl:with-param name="icon" select="@icon"/>
                    </xsl:call-template>
                </p>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="@listStyle='ordered'">
                    <ol>
                        <xsl:call-template name="elml:CSS_Class"/>
                        <xsl:call-template name="elml:Label"/>
                        <xsl:apply-templates/>
                    </ol>
                </xsl:when>
                <xsl:otherwise>
                    <ul>
                        <xsl:call-template name="elml:CSS_Class"/>
                        <xsl:call-template name="elml:Label"/>
                        <xsl:apply-templates/>
                    </ul>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="@bibIDRef">
                <p>
                    <xsl:call-template name="elml:BibliographyRef"/>
                </p>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:box">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <div>
                <xsl:call-template name="elml:CSS_Class"/>
                <xsl:if test="@title">
                    <xsl:attribute name="title">
                        <xsl:value-of select="@title"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:call-template name="elml:Label"/>
                <xsl:call-template name="elml:Title"/>
                <xsl:if test="@icon and not($layout='none')">
                    <xsl:call-template name="Icon">
                        <xsl:with-param name="icon" select="@icon"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:apply-templates/>
            </div>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:popup">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:variable name="varname">
            <xsl:text>solution</xsl:text>
            <xsl:value-of select="generate-id()"/>
        </xsl:variable>
        <xsl:if test="$display='yes'">
            <p id="{$varname}" class="popupTitle" style="cursor: pointer;">
                <xsl:if test="not($layout='firedocs')">
                    <xsl:attribute name="onclick">
                        <xsl:text>onBlock('</xsl:text>
                        <xsl:value-of select="$varname"/>
                        <xsl:text>')</xsl:text>
                    </xsl:attribute>
                </xsl:if>
                <xsl:call-template name="elml:Label"/>
                <xsl:if test="@icon and not($layout='none')">
                    <xsl:call-template name="Icon">
                        <xsl:with-param name="icon" select="@icon"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="@title and not($name_solutiontext='')">
                        <xsl:value-of select="@title"/>
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="$name_solutiontext"/>
                        <xsl:text>) </xsl:text>
                    </xsl:when>
                    <xsl:when test="@title and $name_solutiontext=''">
                        <xsl:value-of select="@title"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$name_solutiontext"/>
                    </xsl:otherwise>
                </xsl:choose>
            </p>
            <div id="{$varname}text">
                <xsl:attribute name="style">
                    <xsl:choose>
                        <xsl:when test="$layout='firedocs'">
                            <xsl:text>cursor: pointer;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>display: none; cursor: pointer;</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:call-template name="elml:CSS_Class"/>
                <xsl:if test="@title">
                    <xsl:attribute name="title">
                        <xsl:value-of select="@title"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="not($layout='firedocs')">
                    <xsl:attribute name="onclick">
                        <xsl:text>off('</xsl:text>
                        <xsl:value-of select="$varname"/>
                        <xsl:text>')</xsl:text>
                    </xsl:attribute>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="text()">
                        <p>
                            <xsl:apply-templates/>
                        </p>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:multimedia">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:param name="inline">
            <xsl:call-template name="elml:inline"/>
        </xsl:param>
        <xsl:param name="pic_alignment">
            <xsl:choose>
                <xsl:when test="@align">
                    <xsl:value-of select="@align"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>left</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:choose>
                <!-- Activate this line if you dont want to allow user generated code in XHTML 1.1 because it can mess up page
                    <xsl:when test="$html_version='1.1' and @type='div'"/> -->
                <xsl:when test="@type='div'">
                    <xsl:call-template name="elml:Title"/>
                    <xsl:choose>
                        <xsl:when test="$layout='firedocs'">
                            <code>[Code cannot be displayed by Firedocs!]</code>
                        </xsl:when>
                        <xsl:when test="@label">
                            <span>
                                <xsl:call-template name="elml:Label"/>
                                <xsl:apply-templates mode="copy"/>
                            </span>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates mode="copy"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="($html_version='1.1' or $html_version='5') and $inline='no'">
                    <xsl:if test="@icon and not($layout='none')">
                        <xsl:call-template name="Icon">
                            <xsl:with-param name="icon" select="@icon"/>
                        </xsl:call-template>
                    </xsl:if>
                    <xsl:call-template name="elml:Title"/>
                    <div>
                        <xsl:choose>
                            <xsl:when test="@cssClass">
                                <xsl:call-template name="elml:CSS_Class"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="class">
                                    <xsl:text>multimedia_paragraph_</xsl:text>
                                    <xsl:value-of select="$pic_alignment"/>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:call-template name="elml:MultimediaShow"/>
                        <xsl:call-template name="elml:Legend"/>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="@icon and $inline='no' and not($layout='none')">
                        <xsl:call-template name="Icon">
                            <xsl:with-param name="icon" select="@icon"/>
                        </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="$inline='no'">
                        <xsl:call-template name="elml:Title"/>
                    </xsl:if>
                    <span>
                        <xsl:choose>
                            <xsl:when test="@cssClass">
                                <xsl:call-template name="elml:CSS_Class"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="class">
                                    <xsl:text>multimedia_</xsl:text>
                                    <xsl:choose>
                                        <xsl:when test="$inline='yes' and not(@align)">
                                            <xsl:text>inline</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="$inline='yes'">
                                            <xsl:text>inline_</xsl:text>
                                            <xsl:value-of select="$pic_alignment"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>paragraph_</xsl:text>
                                            <xsl:value-of select="$pic_alignment"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:call-template name="elml:MultimediaShow"/>
                        <xsl:call-template name="elml:Legend"/>
                    </span>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:item">
        <li>
            <xsl:call-template name="elml:CSS_Class"/>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="elml:formatted">
        <xsl:choose>
            <xsl:when test="@label or @cssClass or @labelRef">
                <span>
                    <xsl:call-template name="elml:CSS_Class"/>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:choose>
                        <xsl:when test="@style='bold' and ($html_version='1.1' or $html_version='5')">
                            <strong>
                                <xsl:apply-templates/>
                            </strong>
                        </xsl:when>
                        <xsl:when test="@style='bold'">
                            <b>
                                <xsl:apply-templates/>
                            </b>
                        </xsl:when>
                        <xsl:when test="@style='subscript'">
                            <sub>
                                <xsl:value-of select="."/>
                            </sub>
                        </xsl:when>
                        <xsl:when test="@style='superscript'">
                            <sup>
                                <xsl:value-of select="."/>
                            </sup>
                        </xsl:when>
                        <xsl:when test="@style='italic' and ($html_version='1.1' or $html_version='5')">
                            <em>
                                <xsl:apply-templates/>
                            </em>
                        </xsl:when>
                        <xsl:when test="@style='italic'">
                            <i>
                                <xsl:apply-templates/>
                            </i>
                        </xsl:when>
                        <xsl:when test="@style='underlined'">
                            <span style="text-decoration:underline;">
                                <xsl:apply-templates/>
                            </span>
                        </xsl:when>
                        <xsl:when test="@style='crossedOut' and ($html_version='1.1' or $html_version='5')">
                            <del>
                                <xsl:apply-templates/>
                            </del>
                        </xsl:when>
                        <xsl:when test="@style='crossedOut'">
                            <span style="text-decoration:line-through;">
                                <xsl:apply-templates/>
                            </span>
                        </xsl:when>
                        <xsl:when test="@style='upperCase'">
                            <span style="text-transform:uppercase;">
                                <xsl:apply-templates/>
                            </span>
                        </xsl:when>
                        <xsl:when test="@style='lowerCase'">
                            <span style="text-transform:lowercase;">
                                <xsl:apply-templates/>
                            </span>
                        </xsl:when>
                        <xsl:when test="@style='code'">
                            <code>
                                <xsl:apply-templates/>
                            </code>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@style='bold' and ($html_version='1.1' or $html_version='5')">
                        <strong>
                            <xsl:apply-templates/>
                        </strong>
                    </xsl:when>
                    <xsl:when test="@style='bold'">
                        <b>
                            <xsl:apply-templates/>
                        </b>
                    </xsl:when>
                    <xsl:when test="@style='subscript'">
                        <sub>
                            <xsl:value-of select="."/>
                        </sub>
                    </xsl:when>
                    <xsl:when test="@style='superscript'">
                        <sup>
                            <xsl:value-of select="."/>
                        </sup>
                    </xsl:when>
                    <xsl:when test="@style='italic' and ($html_version='1.1' or $html_version='5')">
                        <em>
                            <xsl:apply-templates/>
                        </em>
                    </xsl:when>
                    <xsl:when test="@style='italic'">
                        <i>
                            <xsl:apply-templates/>
                        </i>
                    </xsl:when>
                    <xsl:when test="@style='underlined'">
                        <span style="text-decoration:underline;">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@style='crossedOut' and ($html_version='1.1' or $html_version='5')">
                        <del>
                            <xsl:apply-templates/>
                        </del>
                    </xsl:when>
                    <xsl:when test="@style='crossedOut'">
                        <span style="text-decoration:line-through;">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@style='upperCase'">
                        <span style="text-transform:uppercase;">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@style='lowerCase'">
                        <span style="text-transform:lowercase;">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@style='code'">
                        <code>
                            <xsl:apply-templates/>
                        </code>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:inline">
        <xsl:variable name="inlineOrBlock">
            <xsl:for-each select="../text()">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="name(parent::*)='paragraph'">
                <xsl:text>yes</xsl:text>
            </xsl:when>
            <xsl:when test="name()='term' and name(parent::*)='item' and name(following-sibling::*[1])='list'">
                <xsl:text>yes</xsl:text>
            </xsl:when>
            <xsl:when test="(following-sibling::node()/name()='newLine') or (preceding-sibling::node()/name()='newLine')">
                <xsl:text>yes</xsl:text>
            </xsl:when>
            <xsl:when test="not(string-length($inlineOrBlock) &gt; 0) and ((boolean(name(preceding-sibling::*[1])) or boolean(name(following-sibling::*[1]))) or (count(../*)=number('1') and (name(parent::*)='look' or name(parent::*)='act' or name(parent::*)='clarify' or name(parent::*)='tabledata' or name(parent::*)='tableheading' or name(parent::*)='columnLeft' or name(parent::*)='columnMiddle' or name(parent::*)='columnRight' or name(parent::*)='entry' or name(parent::*)='selfAssessment' or name(parent::*)='summary')) and not(name(parent::*)='link'))">
                <xsl:text>no</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>yes</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:Alignment">
        <xsl:choose>
            <xsl:when test="($layout='firedocs' or $html_version='1.1' or $html_version='5') and (@width or @height or @align or @valign)">
                <xsl:attribute name="style">
                    <xsl:if test="@width">
                        <xsl:text>width: </xsl:text>
                        <xsl:value-of select="@width"/>
                        <xsl:if test="@units='percent'">
                            <xsl:text>%</xsl:text>
                        </xsl:if>
                        <xsl:text>; </xsl:text>
                    </xsl:if>
                    <xsl:if test="@height">
                        <xsl:text>height: </xsl:text>
                        <xsl:value-of select="@height"/>
                        <xsl:if test="@units='percent'">
                            <xsl:text>%</xsl:text>
                        </xsl:if>
                        <xsl:text>; </xsl:text>
                    </xsl:if>
                    <xsl:if test="@align">
                        <xsl:text>text-align: </xsl:text>
                        <xsl:value-of select="@align"/>
                        <xsl:text>; </xsl:text>
                    </xsl:if>
                    <xsl:if test="@valign">
                        <xsl:text>vertical-align: </xsl:text>
                        <xsl:value-of select="@valign"/>
                        <xsl:text>; </xsl:text>
                    </xsl:if>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="@width">
                    <xsl:attribute name="width">
                        <xsl:value-of select="@width"/>
                        <xsl:if test="@units='percent'">
                            <xsl:text>%</xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@height">
                    <xsl:attribute name="height">
                        <xsl:value-of select="@height"/>
                        <xsl:if test="@units='percent'">
                            <xsl:text>%</xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@align or @valign">
                    <xsl:attribute name="style">
                        <xsl:if test="@align">
                            <xsl:text>text-align: </xsl:text>
                            <xsl:value-of select="@align"/>
                            <xsl:text>; </xsl:text>
                        </xsl:if>
                        <xsl:if test="@valign">
                            <xsl:text>vertical-align: </xsl:text>
                            <xsl:value-of select="@valign"/>
                            <xsl:text>; </xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:CSS_Class">
        <xsl:param name="label" select="@labelRef"/>
        <xsl:attribute name="class">
            <xsl:choose>
                <xsl:when test="@role='tutor'">
                    <xsl:value-of select="@role"/>
                </xsl:when>
                <xsl:when test="@cssClass">
                    <xsl:value-of select="@cssClass"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="name()"/>
                    <!-- alternating rows -->
                    <xsl:if test="(position() mod 2 != 0) and (name()='tablerow' or name()='lObjective' or name()='item')">
                        <xsl:text>Alt</xsl:text>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:if test="@labelRef and not($use_labelReferences='no')">
            <xsl:attribute name="onmouseover">
                <xsl:text>document.getElementById('</xsl:text>
                <xsl:value-of select="//*[@label=$label]/../@label"/>
                <xsl:text>_</xsl:text>
                <xsl:value-of select="@labelRef"/>
                <xsl:value-of select="$filename_suffix"/>
                <xsl:text>').style.backgroundColor = '</xsl:text>
                <xsl:choose>
                    <xsl:when test="$use_labelReferences='yes'">red</xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$use_labelReferences"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>';</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="onmouseout">
                <xsl:text>document.getElementById('</xsl:text>
                <xsl:value-of select="//*[@label=$label]/../@label"/>
                <xsl:text>_</xsl:text>
                <xsl:value-of select="@labelRef"/>
                <xsl:value-of select="$filename_suffix"/>
                <xsl:text>').style.backgroundColor = '';</xsl:text>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:Title">
        <xsl:if test="@title">
            <h4>
                <xsl:value-of select="@title"/>
            </h4>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:Legend">
        <xsl:if test="@legend or @bibIDRef">
            <span class="legend" style="display:block">
                <xsl:value-of select="@legend"/>
                <xsl:call-template name="elml:BibliographyRef"/>
            </span>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:MultimediaAttributes">
        <xsl:choose>
            <xsl:when test="@width">
                <xsl:attribute name="width">
                    <xsl:value-of select="@width"/>
                    <xsl:if test="@units='percent'">
                        <xsl:text>%</xsl:text>
                    </xsl:if>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="@type='mp3'">
                <xsl:attribute name="width">150</xsl:attribute>
            </xsl:when>
            <xsl:when test="@type='quicktime' or @type='mpeg' or @type='realone'">
                <xsl:attribute name="width">300</xsl:attribute>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="(@type='quicktime' or @type='mpeg' or @type='mp3' or @type='realone') and @height">
                <xsl:if test="not(@units='percent')">
                    <xsl:attribute name="height">
                        <xsl:value-of select="number(@height) + 16"/>
                    </xsl:attribute>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@height">
                <xsl:attribute name="height">
                    <xsl:value-of select="@height"/>
                    <xsl:if test="@units='percent'">
                        <xsl:text>%</xsl:text>
                    </xsl:if>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="@type='mp3'">
                <xsl:attribute name="height">
                    <xsl:value-of select="16"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="@type='quicktime' or @type='mpeg' or @type='realone'">
                <xsl:attribute name="height">
                    <xsl:value-of select="200"/>
                </xsl:attribute>
            </xsl:when>
        </xsl:choose>
        <xsl:call-template name="elml:CSS_Class"/>
        <xsl:if test="@legend">
            <xsl:attribute name="title">
                <xsl:value-of select="@legend"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:Image">
        <xsl:param name="pathMultimedia"/>
        <img class="content_image">
            <xsl:call-template name="elml:Label"/>
            <xsl:attribute name="src">
                <xsl:value-of select="$pathMultimedia"/>
            </xsl:attribute>
            <xsl:call-template name="elml:MultimediaAttributes"/>
            <xsl:attribute name="alt">
                <xsl:value-of select="@legend"/>
            </xsl:attribute>
        </img>
    </xsl:template>
    <xsl:template name="elml:Flash">
        <xsl:param name="pathMultimedia"/>
        <object type="application/x-shockwave-flash">
            <xsl:call-template name="elml:Label"/>
            <xsl:call-template name="elml:MultimediaAttributes"/>
            <xsl:attribute name="data">
                <xsl:value-of select="$pathMultimedia"/>
            </xsl:attribute>
            <param name="movie">
                <xsl:attribute name="value">
                    <xsl:value-of select="$pathMultimedia"/>
                </xsl:attribute>
            </param>
            <param name="quality" value="best"/>
            <param name="scale" value="exactfit"/>
            <param name="menu" value="true"/>
            <param name="play" value="false"/>
            <param name="wmode" value="opaque"/>
            <xsl:if test="$use_embed='yes'">
                <embed pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" quality="best" scale="exactfit" menu="true" play="false" wmode="opaque">
                    <xsl:attribute name="src">
                        <xsl:value-of select="$pathMultimedia"/>
                    </xsl:attribute>
                    <xsl:call-template name="elml:MultimediaAttributes"/>
                </embed>
            </xsl:if>
        </object>
    </xsl:template>
    <xsl:template name="elml:Quicktime">
        <xsl:param name="pathMultimedia"/>
        <object type="video/quicktime" classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" coebase="http://www.apple.com/qtactivex/qtplugin.cab" pluginspage="http://www.apple.com/quicktime/download/">
            <xsl:call-template name="elml:Label"/>
            <xsl:call-template name="elml:MultimediaAttributes"/>
            <xsl:attribute name="data">
                <xsl:value-of select="$pathMultimedia"/>
            </xsl:attribute>
            <param name="src">
                <xsl:attribute name="value">
                    <xsl:value-of select="$pathMultimedia"/>
                </xsl:attribute>
            </param>
            <param name="scale" value="aspect"/>
            <param name="kioskmode" value="false"/>
            <xsl:choose>
                <xsl:when test="ancestor::node()/name()='popup'">
                    <param name="autoplay" value="true"/>
                    <param name="controller" value="false"/>
                    <param name="autostart" value="true"/>
                </xsl:when>
                <xsl:otherwise>
                    <param name="autoplay" value="false"/>
                    <param name="controller" value="true"/>
                    <param name="autostart" value="false"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="$use_embed='yes'">
                <embed pluginspage="http://www.apple.com/quicktime/download/" type="video/quicktime" kioskmode="false" scale="aspect">
                    <xsl:attribute name="autostart">
                        <xsl:choose>
                            <xsl:when test="ancestor::node()/name()='popup'">true</xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:attribute name="autoplay">
                        <xsl:choose>
                            <xsl:when test="ancestor::node()/name()='popup'">true</xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:attribute name="controller">
                        <xsl:choose>
                            <xsl:when test="ancestor::node()/name()='popup'">false</xsl:when>
                            <xsl:otherwise>true</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:attribute name="src">
                        <xsl:value-of select="$pathMultimedia"/>
                    </xsl:attribute>
                    <xsl:call-template name="elml:MultimediaAttributes"/>
                </embed>
            </xsl:if>
        </object>
    </xsl:template>
    <xsl:template name="elml:MPEG">
        <xsl:param name="pathMultimedia"/>
        <object type="video/mpeg">
            <xsl:call-template name="elml:Label"/>
            <xsl:call-template name="elml:MultimediaAttributes"/>
            <xsl:attribute name="data">
                <xsl:value-of select="$pathMultimedia"/>
            </xsl:attribute>
            <param name="src">
                <xsl:attribute name="value">
                    <xsl:value-of select="$pathMultimedia"/>
                </xsl:attribute>
            </param>
            <param name="scale" value="aspect"/>
            <xsl:choose>
                <xsl:when test="ancestor::node()/name()='popup'">
                    <param name="autoplay" value="true"/>
                    <param name="controller" value="false"/>
                    <param name="autostart" value="true"/>
                </xsl:when>
                <xsl:otherwise>
                    <param name="autoplay" value="false"/>
                    <param name="controller" value="true"/>
                    <param name="autostart" value="false"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="$use_embed='yes'">
                <embed pluginspage="http://www.apple.com/quicktime/download/" type="video/mpeg" scale="aspect">
                    <xsl:attribute name="autostart">
                        <xsl:choose>
                            <xsl:when test="ancestor::node()/name()='popup'">true</xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:attribute name="autoplay">
                        <xsl:choose>
                            <xsl:when test="ancestor::node()/name()='popup'">true</xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:attribute name="controller">
                        <xsl:choose>
                            <xsl:when test="ancestor::node()/name()='popup'">false</xsl:when>
                            <xsl:otherwise>true</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:attribute name="src">
                        <xsl:value-of select="$pathMultimedia"/>
                    </xsl:attribute>
                    <xsl:call-template name="elml:MultimediaAttributes"/>
                </embed>
            </xsl:if>
        </object>
    </xsl:template>
    <xsl:template name="elml:MP3">
        <xsl:param name="pathMultimedia"/>
        <object type="audio/mpeg">
            <xsl:call-template name="elml:Label"/>
            <xsl:call-template name="elml:MultimediaAttributes"/>
            <xsl:attribute name="data">
                <xsl:value-of select="$pathMultimedia"/>
            </xsl:attribute>
            <param name="src">
                <xsl:attribute name="value">
                    <xsl:value-of select="$pathMultimedia"/>
                </xsl:attribute>
            </param>
            <param name="filename">
                <xsl:attribute name="value">
                    <xsl:value-of select="$pathMultimedia"/>
                </xsl:attribute>
            </param>
            <xsl:choose>
                <xsl:when test="ancestor::node()/name()='popup'">
                    <param name="autoplay" value="true"/>
                    <param name="controller" value="false"/>
                    <param name="autostart" value="true"/>
                </xsl:when>
                <xsl:otherwise>
                    <param name="autoplay" value="false"/>
                    <param name="controller" value="true"/>
                    <param name="autostart" value="false"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="$use_embed='yes'">
                <embed pluginspage="http://www.apple.com/quicktime/download/" type="audio/mpeg">
                    <xsl:attribute name="autostart">
                        <xsl:choose>
                            <xsl:when test="ancestor::node()/name()='popup'">true</xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:attribute name="autoplay">
                        <xsl:choose>
                            <xsl:when test="ancestor::node()/name()='popup'">true</xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:attribute name="controller">
                        <xsl:choose>
                            <xsl:when test="ancestor::node()/name()='popup'">false</xsl:when>
                            <xsl:otherwise>true</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:attribute name="src">
                        <xsl:value-of select="$pathMultimedia"/>
                    </xsl:attribute>
                    <xsl:call-template name="elml:MultimediaAttributes"/>
                </embed>
            </xsl:if>
        </object>
    </xsl:template>
    <xsl:template name="elml:RealOne">
        <xsl:param name="pathMultimedia"/>
        <object type="audio/x-pn-realaudio-plugin">
            <xsl:call-template name="elml:Label"/>
            <xsl:call-template name="elml:MultimediaAttributes"/>
            <xsl:attribute name="data">
                <xsl:value-of select="$pathMultimedia"/>
            </xsl:attribute>
            <param name="src">
                <xsl:attribute name="value">
                    <xsl:value-of select="$pathMultimedia"/>
                </xsl:attribute>
            </param>
            <xsl:choose>
                <xsl:when test="ancestor::node()/name()='popup'">
                    <param name="autoplay" value="true"/>
                    <param name="autostart" value="true"/>
                </xsl:when>
                <xsl:otherwise>
                    <param name="autoplay" value="false"/>
                    <param name="autostart" value="false"/>
                </xsl:otherwise>
            </xsl:choose>
            <param name="controls" value="ImageWindow"/>
            <xsl:if test="$use_embed='yes'">
                <embed pluginspage="http://www.real.com/" type="audio/x-pn-realaudio-plugin" controls="ImageWindow">
                    <xsl:attribute name="autostart">
                        <xsl:choose>
                            <xsl:when test="ancestor::node()/name()='popup'">true</xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:attribute name="src">
                        <xsl:value-of select="$pathMultimedia"/>
                    </xsl:attribute>
                    <xsl:call-template name="elml:MultimediaAttributes"/>
                </embed>
            </xsl:if>
        </object>
    </xsl:template>
    <xsl:template name="elml:VRML">
        <xsl:param name="pathMultimedia"/>
        <object type="model/vrml">
            <xsl:call-template name="elml:Label"/>
            <xsl:call-template name="elml:MultimediaAttributes"/>
            <xsl:attribute name="data">
                <xsl:value-of select="$pathMultimedia"/>
            </xsl:attribute>
            <param name="src">
                <xsl:attribute name="value">
                    <xsl:value-of select="$pathMultimedia"/>
                </xsl:attribute>
            </param>
            <xsl:if test="$use_embed='yes'">
                <embed type="model/vrml">
                    <xsl:attribute name="src">
                        <xsl:value-of select="$pathMultimedia"/>
                    </xsl:attribute>
                    <xsl:call-template name="elml:MultimediaAttributes"/>
                </embed>
            </xsl:if>
        </object>
    </xsl:template>
    <xsl:template name="elml:X3D">
        <xsl:param name="pathMultimedia"/>
        <object type="model/x3d+xml">
            <xsl:call-template name="elml:Label"/>
            <xsl:call-template name="elml:MultimediaAttributes"/>
            <xsl:attribute name="data">
                <xsl:value-of select="$pathMultimedia"/>
            </xsl:attribute>
            <param name="src">
                <xsl:attribute name="value">
                    <xsl:value-of select="$pathMultimedia"/>
                </xsl:attribute>
            </param>
            <xsl:if test="$use_embed='yes'">
                <embed type="model/x3d+xml" pluginspage="http://www.web3d.org/applications/tools/viewers_and_browsers/">
                    <xsl:attribute name="src">
                        <xsl:value-of select="$pathMultimedia"/>
                    </xsl:attribute>
                    <xsl:call-template name="elml:MultimediaAttributes"/>
                </embed>
            </xsl:if>
        </object>
    </xsl:template>
</xsl:stylesheet>
