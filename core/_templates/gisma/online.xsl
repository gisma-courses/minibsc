<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" version="2.0" xmlns:functx="http://www.functx.com"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:import href="../../core/presentation/online/elml.xsl"/>
    <!-- ***** Parameter definitions  *****-->
    <xsl:param name="css_framework" select="'none'"/>
    <!--The name of this layout (=folder name of template folder!) -->
    <xsl:param name="layout" select="'gisma'"/>
    <xsl:character-map name="comment">
        <!-- Comment start -->
        <xsl:output-character character="&#xE001;" string="&lt;"/>
        <!-- Comment end -->
        <xsl:output-character character="&#xE002;" string="&gt;"/>
        <!-- path_full (breadcrumb) separator -->
        <xsl:output-character character="&#xE003;" string=" &gt; " xpath-default-namespace=""/>
    </xsl:character-map>
    <!-- ***** Template definitions  ***** -->
    <xsl:template name="elml:LayoutBody">
        <xsl:param name="prev">
            <xsl:call-template name="elml:prev_file"/>
        </xsl:param>
        <xsl:param name="next">
            <xsl:call-template name="elml:next_file"/>
        </xsl:param>
        <body>

            <xsl:if test="$manifest_type='scorm'">
                <xsl:attribute name="onunload">
                    <xsl:value-of>finish()</xsl:value-of>
                </xsl:attribute>
            </xsl:if>

            <div class="bodywidth">
                <a accesskey="1" href="#navigation" title="Zur Navigation springen">
                    &#xE001;<![CDATA[!----]]>&#xE002; </a>
                <a accesskey="2" href="#content" title="Zum Inhalt springen">
                    &#xE001;<![CDATA[!----]]>&#xE002; </a>
                <a name="top"> &#xE001;<![CDATA[!----]]>&#xE002; </a>

                <div id="breadcrumbnav">

                    <a href="http://www.uni-marburg.de">
                        <h2>Philipps Universität Marburg</h2>
                    </a>
                    <a href="http://www.uni-marburg.de/fb19">
                        <h4>Fachbereich Geographie</h4>
                    </a>


                </div>
                <div id="headerarea">

                    <div style="float:right;width:195px;">
                        <div class="imgunilogo">
                            <a href="http://www.uni-marburg.de/fb19/einrichtung/gisma">
                                <img alt="PUM Logo" height="90" width="180"
                                    src="../../../_templates/gisma/images/think_gisma_logo.png"/>
                            </a>
                        </div>
                        <div class="imginstitute"> </div>
                    </div>
                    <div id="headertitelpos">

                        <div id="servicenavpos">

                            <a accesskey="0" href="{$server}">Home</a>
                            <xsl:text> | </xsl:text>
                            <xsl:if test="not($contact='')">
                                <a accesskey="3">
                                    <xsl:attribute name="href">
                                        <xsl:text>mailto:</xsl:text>
                                        <xsl:value-of select="$contact"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$name_contact"/>
                                </a>
                                <xsl:text> | </xsl:text>
                            </xsl:if>



                            <!--                            <form accept-charset="UTF-8" action="http://www.google.de/result.html"
                                id="searchbox" method="get">
                                <input name="cx" type="hidden"
                                    value="017226819753922132248:_5skna39w8y"/>
                                <input name="cof" type="hidden" value="FORID:11"/>
                                <input id="custom" name="sitesearch" type="hidden" value=""/>
                                <div class="serviceform">
                                    <input accesskey="31" name="q" type="text"/>
                                </div>
                                <div class="serviceform">
                                    <a href="javascript:document.forms['searchbox'].submit();"
                                        >Suche</a>
                                </div>
                            </form>-->
                            <!-- Form to subscribe eLML Newsletter instead of search
							<form action="https://lists.sourceforge.net/lists/subscribe/elml-news" method="post" name="newsletter-elml">
								<div class="serviceform">
									<input accesskey="5" name="email" type="text" value="your@email" onfocus="if (this.value=='your@email') this.value=''" onblur="if (this.value=='') this.value='your@email'"/>
								</div>
								<input type="hidden" name="pw">
									<xsl:attribute name="value">
										<xsl:value-of select="generate-id()"/>
									</xsl:attribute>
								</input>
								<input type="hidden" name="pw-conf">
									<xsl:attribute name="value">
										<xsl:value-of select="generate-id()"/>
									</xsl:attribute>
								</input>
								<input type="hidden" name="digest" value="0"/>
								<div class="serviceform">
									<a href="javascript:document.forms['newsletter-elml'].submit();">Newsletter abonnieren</a>
								</div>
								</form> -->
                        </div>

                        <h1>
                            <xsl:value-of select="/elml:lesson/@title"/>
                        </h1>
                    </div>
                </div>

                <div class="floatclear"> &#xE001;<![CDATA[!----]]>&#xE002; </div>
                <div id="breadcrumbnav">
                    <!-- <xsl:call-template name="elml:path_full"/>-->
                </div>
                <div class="floatclear"> &#xE001;<![CDATA[!----]]>&#xE002; </div>
                <div class="endheaderline">
                    <img alt="separation line" height="1"
                        src="../../../_templates/gisma/authoring/images/1.gif" width="1"/>
                </div>
                <div id="toolnav">

                    <xsl:if test="not(contains($prev,'none'))">

                        <a href="{$prev}">
                            <img src="../../../_templates/{$layout}/images/arrow_left.gif"
                                height="13" width="9" alt="Go to previous page" border="0"/> zurück </a>

                    </xsl:if>
                    <xsl:if test="not(contains($next,'none'))">

                        <a href="{$next}">
                            <img src="../../../_templates/{$layout}/images/arrow_right.gif"
                                height="13" width="9" alt="Go to next page" border="0"/> vor </a>

                    </xsl:if>
                </div>
                <div class="floatclear"> &#xE001;<![CDATA[!----]]>&#xE002; </div>
                <div id="col1">
                    <div id="secnav">
                        <xsl:call-template name="elml:navigation_start"/>
                        &#xE001;<![CDATA[!----]]>&#xE002; </div>
                    <xsl:call-template name="elml:cc_code"/>
                </div>
                <div class="contcol2">
                    <a accesskey="2" class="namedanchor" name="content">
                        &#xE001;<![CDATA[!----]]>&#xE002; </a>

                    <div class="content">
                        <xsl:call-template name="elml:LayoutBodyContent"/>
                    </div>
                    <div id="toolnav">


                        <xsl:if test="not(contains($prev,'none'))">

                            <a href="{$prev}">
                                <img src="../../../_templates/{$layout}/images/arrow_left.gif"
                                    height="13" width="9" alt="Go to previous page" border="0"/>
                                zurück </a>

                            <xsl:if test="not(contains($next,'none'))">

                                <a href="{$next}">
                                    <img src="../../../_templates/{$layout}/images/arrow_right.gif"
                                        height="13" width="9" alt="Go to next page" border="0"/> vor </a>

                            </xsl:if>


                        </xsl:if>
                        <a href="#top">
                            <img src="../../../_templates/{$layout}/images/arrow_weiss.gif"
                                height="13" width="9" border="0"/>
                            <img src="../../../_templates/{$layout}/images/arrow_up.gif" height="13"
                                width="9" alt="Go to next page" border="0"/> top </a>
                    </div>
                    <div class="footermargintop"> &#xE001;<![CDATA[!----]]>&#xE002; </div>


                    <div class="solidline">
                        <img alt="separation line" height="1"
                            src="../../../_templates/gisma/authoring/images/1.gif" width="1"/>
                    </div>
                    <div id="footer">
                        <xsl:call-template name="elml:footer_gitta"/>
                    </div>
                </div>
            </div>
        </body>
    </xsl:template>

    <xsl:template match="elml:annotation">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:call-template name="elml:annotation_icon"/>
            <span class="annotation">
                <xsl:attribute name="id">
                    <xsl:text>annotation</xsl:text>
                    <xsl:value-of select="position()"/>
                </xsl:attribute>
                <xsl:call-template name="elml:Label"/>
                <xsl:apply-templates/>
            </span>
            <xsl:call-template name="elml:LayoutTooltip"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="elml:annotation_icon">
        <img src="../../../_templates/{$layout}/icons/annotation.png" class="annotation_icon"
            width="16" height="16">
            <xsl:attribute name="title">
                <xsl:value-of select="$name_annotation"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:value-of select="$name_annotation"/>
            </xsl:attribute>
            <xsl:attribute name="onmouseover">
                <xsl:text>TagToTip('annotation</xsl:text>
                <xsl:value-of select="position()"/>
                <xsl:text>', STICKY, true, CLOSEBTN, true, COPYCONTENT, false, TITLE, '</xsl:text>
                <xsl:value-of select="$name_annotation"/>
                <xsl:text>', BGCOLOR, 'white', BORDERCOLOR, 'black', WIDTH, 180, OFFSETX, -210, OFFSETY, -100)</xsl:text>
            </xsl:attribute>
        </img>
    </xsl:template>
    <!-- ***** Navigation Top (class primarnav) *****-->
    <xsl:template name="elml:navigation_prim">
        <xsl:param name="filename">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:param name="actual_lesson">
            <xsl:value-of select="/elml:lesson/@label"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$multiple='on'">
                <xsl:for-each
                    select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                    <xsl:apply-templates
                        select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson"
                        mode="navigation_prim">
                        <xsl:with-param name="filename" select="$filename"/>
                        <xsl:with-param name="actual_lesson" select="$actual_lesson"/>
                    </xsl:apply-templates>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="/elml:lesson/elml:*" mode="navigation_prim">
                    <xsl:with-param name="filename" select="$filename"/>
                    <xsl:with-param name="actual_lesson" select="$actual_lesson"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="elml:lesson" mode="navigation_prim">
        <xsl:param name="filename"/>
        <xsl:param name="actual_lesson"/>
        <xsl:param name="navact">
            <xsl:if
                test="($actual_lesson=/elml:lesson/@label) and ($filename = concat('index', $filename_suffix))">
                <xsl:text>_act</xsl:text>
            </xsl:if>
        </xsl:param>
        <xsl:call-template name="elml:nav_item_link">
            <xsl:with-param name="filename" select="$filename"/>
            <xsl:with-param name="navact" select="$navact"/>
            <xsl:with-param name="isnavigation">path_full</xsl:with-param>
        </xsl:call-template>
        <div class="linkseparator">|</div>
    </xsl:template>

    <xsl:template
        match="elml:entry | elml:goals | elml:glossary | elml:context | elml:index | elml:bibliography | elml:metadata"
        mode="navigation_prim"/>

    <xsl:template match="elml:unit | elml:selfAssessment | elml:summary | elml:furtherReading"
        mode="navigation_prim">
        <xsl:param name="filename"/>
        <xsl:param name="filenameactual">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:param name="navact">
            <xsl:choose>
                <xsl:when test="$filename = $filenameactual">
                    <xsl:text>_act</xsl:text>
                </xsl:when>
                <xsl:when
                    test="(name(.)='entry') and ($filename = concat('index', $filename_suffix))">
                    <xsl:text>_act</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:call-template name="elml:nav_item_link">
                <xsl:with-param name="filename" select="$filename"/>
                <xsl:with-param name="navact" select="$navact"/>
                <xsl:with-param name="isnavigation">path_full</xsl:with-param>
            </xsl:call-template>
            <div class="linkseparator">|</div>
        </xsl:if>
    </xsl:template>





    <xsl:template match="elml:lesson" mode="navigation_lesson">
        <xsl:param name="filename"/>
        <xsl:param name="actual_lesson"/>
        <xsl:param name="navact">
            <xsl:if
                test="($actual_lesson=/elml:lesson/@label) and ($filename = concat('index', $filename_suffix))">
                <xsl:text>_act</xsl:text>
            </xsl:if>
        </xsl:param>
        <tr align="left" valign="top">
            <td width="215" height="34" class="background_nav">
                <p
                    style="text-align:left; line-height: 100%; text-indent:0px;margin-right:10px; margin-left:0px; margin-top: 5px; margin-bottom: 5px;">
                    <!-- Lesson -->

                    <xsl:call-template name="elml:nav_item_link_gitta">
                        <xsl:with-param name="filename" select="$filename"/>
                        <xsl:with-param name="navact" select="$navact"/>
                    </xsl:call-template>
                </p>
            </td>
            <td width="28" height="34" class="background"/>
        </tr>
        <xsl:if
            test="(document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/@subnavigation='yes') or ($actual_lesson=/elml:lesson/@label)">
            <xsl:choose>
                <xsl:when test="/elml:lesson/@label='website'">
                    <xsl:apply-templates select="elml:unit  " mode="navigation_unit_website">
                        <xsl:with-param name="filename" select="$filename"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates
                        select="elml:unit | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listoffigures | elml:listoftables | elml:index | elml:bibliography | elml:metadata"
                        mode="navigation_unit">
                        <xsl:with-param name="filename" select="$filename"/>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template
        match="elml:unit | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listoffigures | elml:listoftables | elml:index | elml:bibliography | elml:metadata"
        mode="navigation_unit">
        <xsl:param name="filename"/>
        <xsl:param name="filenameactual">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:param name="navicon">
            <xsl:choose>
                <xsl:when
                    test="name(.)='bibliography' and not($role='tutor' or /elml:lesson/elml:metadata/@role=$role or not(/elml:lesson/elml:metadata/@role))">
                    <xsl:text>zurueck</xsl:text>
                </xsl:when>
                <xsl:when
                    test="(count(preceding-sibling::elml:unit)=number(0)) and (count(following-sibling::*)=number(0))">
                    <xsl:text>einrueckone</xsl:text>
                </xsl:when>
                <xsl:when test="count(preceding-sibling::elml:unit)=number(0)">
                    <xsl:text>einrueck</xsl:text>
                </xsl:when>
                <xsl:when test="count(following-sibling::*)=number(0)">
                    <xsl:text>zurueck</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="navline">
            <xsl:choose>
                <xsl:when test="$navicon='zurueck'">
                    <xsl:text>first</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>second</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="navact">
            <xsl:choose>
                <xsl:when test="$filename = $filenameactual">
                    <xsl:text>_act</xsl:text>
                </xsl:when>
                <xsl:when
                    test="(name(.)='entry') and ($filename = concat('index', $filename_suffix))">
                    <xsl:text>_act</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <tr align="left" valign="top">
                <td width="215" height="34" class="background_nav">
                    <p
                        style="font-size:11.5px;text-align:left; line-height: 100%; text-indent: 0px; margin-left: 15px; margin-top: 4px; margin-bottom: 4px;">
                        <!-- UNIT hier menueinrückung-->
                        <!-- unit element HIER WIRD DAS MENU FOrmatiert -->

                        <xsl:call-template name="elml:nav_item_link_gitta">
                            <xsl:with-param name="filename" select="$filename"/>
                            <xsl:with-param name="navact" select="$navact"/>
                        </xsl:call-template>
                    </p>
                </td>
                <td width="28" class="background"/>
            </tr>
            <xsl:if
                test="(name(.)='unit') and (($pagebreak_level='unit') or ($pagebreak_level='lo')) and (($filename = $filenameactual) or contains($filename,@label))">
                <xsl:apply-templates
                    select="elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading"
                    mode="navigation_lo">
                    <xsl:with-param name="filename" select="$filename"/>

                </xsl:apply-templates>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="elml:unit  | elml:selfAssessment | elml:summary | elml:furtherReading"
        mode="sitemap">
        <xsl:param name="filename"/>
        <xsl:param name="filenameactual">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:param name="navicon">
            <xsl:choose>
                <xsl:when test="name(.)='summary'">
                    <xsl:text>zurueck</xsl:text>
                </xsl:when>
                <xsl:when
                    test="(count(preceding-sibling::elml:unit)=number(0)) and (count(following-sibling::*)=number(0))">
                    <xsl:text>einrueckone</xsl:text>
                </xsl:when>
                <xsl:when test="count(preceding-sibling::elml:unit)=number(0)">
                    <xsl:text>einrueck</xsl:text>
                </xsl:when>
                <xsl:when test="count(following-sibling::*)=number(0)">
                    <xsl:text>zurueck</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="navline">
            <xsl:choose>
                <xsl:when test="$navicon='zurueck'">
                    <xsl:text>first</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>second</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="navact">
            <xsl:choose>
                <xsl:when test="$filename = $filenameactual">
                    <xsl:text>_act</xsl:text>
                </xsl:when>
                <xsl:when
                    test="(name(.)='entry') and ($filename = concat('index', $filename_suffix))">
                    <xsl:text>_act</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <tr align="left" valign="top">
                <td width="215" height="34" class="background_nav">
                    <p
                        style="text-align:left; line-height: 100%; text-indent:0px; margin-left:0px; margin-top: 4; margin-bottom: 4px;">

                        <xsl:call-template name="elml:nav_item_link_gitta">
                            <xsl:with-param name="filename" select="$filename"/>
                            <xsl:with-param name="navact" select="$navact"/>
                        </xsl:call-template>
                    </p>
                </td>
                <td width="28" class="background"/>
            </tr>
            <xsl:if
                test="(name(.)='unit') and (($pagebreak_level='unit') or ($pagebreak_level='lo')) and (($filename = $filenameactual) or contains($filename,@label))">
                <xsl:apply-templates
                    select="elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading"
                    mode="navigation_lo">
                    <xsl:with-param name="filename" select="$filename"/>
                </xsl:apply-templates>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template
        match=" elml:lesson | elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading"
        mode="navigation_lo">
        <xsl:param name="filename"/>
        <xsl:param name="filenameactual">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:param name="navicon">
            <xsl:choose>
                <xsl:when
                    test="(count(preceding-sibling::elml:learningObject)=number(0)) and (count(following-sibling::*)=number(0))">
                    <xsl:text>einrueckone</xsl:text>
                </xsl:when>
                <xsl:when test="count(preceding-sibling::elml:learningObject)=number(0)">
                    <xsl:text>einrueck</xsl:text>
                </xsl:when>
                <xsl:when test="count(following-sibling::*)=number(0)">
                    <xsl:text>zurueck</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="navline">
            <xsl:choose>
                <xsl:when test="$navicon='zurueck' or $navicon='einrueckone'">
                    <xsl:text>second</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>third</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="navact">
            <xsl:choose>
                <xsl:when test="$filename = $filenameactual">
                    <xsl:text>_act</xsl:text>
                </xsl:when>
                <xsl:when
                    test="(name(.)='entry') and ($filename = concat('unit_',parent::elml:unit/@label,$filename_suffix)) and ($pagebreak_level='lo')">
                    <xsl:text>_act</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <tr align="left" valign="top">
            <td width="215" height="34" class="background_nav">
                <p
                    style="text-align:left; line-height: 100%; text-indent: 0px; margin-right:10px; margin-left: 45px; margin-top: 3px; margin-bottom: 3px;">
                    <!-- LO Ebene -->
                    <xsl:call-template name="elml:nav_item_link_gitta">
                        <xsl:with-param name="filename" select="$filename"/>
                        <xsl:with-param name="navact" select="$navact"/>
                    </xsl:call-template>
                </p>
            </td>
            <td width="28" class="background"/>
        </tr>
    </xsl:template>

    <xsl:template name="elml:nav_item_link_gitta">
        <xsl:param name="navact"/>
        <xsl:param name="filename"/>
        <xsl:param name="filenameactual">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$navact='_act'">
                <span>
                    <xsl:attribute name="class">
                        <xsl:text>navigationActual</xsl:text>
                    </xsl:attribute>
                    <xsl:call-template name="elml:Kapitel">
                        <xsl:with-param name="isnavigation">yes</xsl:with-param>
                    </xsl:call-template>
                    <xsl:if
                        test="contains($filenameactual, 'unit_') and contains($optional_units, substring-after(substring-before($filenameactual, $filename_suffix), 'unit_'))">
                        <xsl:value-of select="$name_optionalunits_symbol"/>
                    </xsl:if>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <a>
                    <xsl:attribute name="class">
                        <xsl:text>navigationLink</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:if test="$multiple='on'">
                            <xsl:text>../../../</xsl:text>
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:text>/</xsl:text>
                            <xsl:value-of select="$lang"/>
                            <xsl:text>/html/</xsl:text>
                        </xsl:if>
                        <xsl:call-template name="elml:Label_param_withfilename"/>
                    </xsl:attribute>
                    <xsl:call-template name="elml:Kapitel">
                        <xsl:with-param name="isnavigation">yes</xsl:with-param>
                    </xsl:call-template>
                    <xsl:if
                        test="contains($filenameactual, 'unit_') and contains($optional_units, substring-after(substring-before($filenameactual, $filename_suffix), 'unit_'))">
                        <xsl:value-of select="$name_optionalunits_symbol"/>
                    </xsl:if>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- More Templates -->
    <xsl:template name="elml:footer">
        <xsl:choose>
            <xsl:when test="/elml:lesson/elml:metadata/elml:rights/elml:copyrightURL">
                <a href="{/elml:lesson/elml:metadata/elml:rights/elml:copyrightURL}" target="_blank">
                    <xsl:text disable-output-escaping="no"> © </xsl:text>
                    <xsl:value-of select="/elml:lesson/elml:metadata/elml:rights/elml:copyright"/>

                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text disable-output-escaping="no"> © </xsl:text>
                <xsl:value-of select="/elml:lesson/elml:metadata/elml:rights/elml:copyright"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text> </xsl:text>
        <a href="http://www.elml.org/" target="_blank">(eLML)</a>
        <xsl:if test="not($bugtracker='')">
            <xsl:text> | </xsl:text>
            <a target="_blank">
                <xsl:attribute name="href">
                    <xsl:value-of select="$bugtracker"/>
                </xsl:attribute>
                <xsl:value-of select="$name_bugtracker"/>
            </a>
        </xsl:if>
        <xsl:if test="not($contact='')">
            <xsl:text> | </xsl:text>
            <a>
                <xsl:attribute name="href">
                    <xsl:text>mailto:</xsl:text>
                    <xsl:value-of select="$contact"/>
                </xsl:attribute>
                <xsl:value-of select="$name_contact"/>
            </a>
        </xsl:if>
        <xsl:text> | </xsl:text>
        <a>
            <xsl:attribute name="href">
                <xsl:text>../text/</xsl:text>
                <xsl:value-of select="/elml:lesson/@label"/>
                <xsl:text>.pdf</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="$name_print"/> (PDF)</a>
        <xsl:text> | Update: </xsl:text>
        <xsl:value-of select="day-from-date(current-date())"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="month-from-date(current-date())"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="year-from-date(current-date())"/>
    </xsl:template>
    <xsl:template match="elml:newLine">
        <xsl:choose>
            <xsl:when test="@space='long'">
                <br/>
                <br/>
            </xsl:when>
            <xsl:otherwise>
                <br/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="elml:footer_gitta">
        <p class="footer"> Update: <xsl:value-of select="day-from-date(current-date())"/>
            <xsl:text>.</xsl:text>
            <xsl:value-of select="month-from-date(current-date())"/>
            <xsl:text>.</xsl:text>
            <xsl:value-of select="year-from-date(current-date())"/>
            <a href="http://www.elml.ch/" target="_blank"> powered by eLML - &amp; - </a>
            <a href="http://www.gitta.info/" target="_blank"> GITTA </a> - <a>
                <xsl:attribute name="href">
                    <xsl:text>../text/</xsl:text>
                    <xsl:value-of select="/elml:lesson/@label"/>
                    <xsl:text>.pdf</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="$name_print"/> (PDF)</a> - <a rel="license" target="_blank">
                <!--<xsl:value-of select="GISBScL1.pdf"/> (PDF)</a> - <a rel="license" target="_blank">-->
                <xsl:attribute name="href">
                    <xsl:text>http://creativecommons.org/licenses/by-nc-sa/3.0/deed.</xsl:text>
                    <xsl:value-of select="$lang"/>
                </xsl:attribute>
                <xsl:text disable-output-escaping="no">  Creative Commons </xsl:text>
                <img alt="Creative Commons License © " border="0"
                    src="../../../_templates/gisma/icons/creativecommons.png" height="18" width="40"
                    align="bottom"/>
            </a> - <a>
                <xsl:attribute name="href">
                    <xsl:text>mailto:</xsl:text>
                    <xsl:value-of select="$contact"/>
                </xsl:attribute>
                <xsl:value-of select="$name_contact"/>
            </a>
        </p>

    </xsl:template>

    <xsl:template name="elml:cc_code"> &#xE001;!--<rdf:RDF xmlns="http://web.resource.org/cc/"
            xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
            <Work rdf:about="">
                <license rdf:resource="http://creativecommons.org/licenses/by-nc-sa/3.0/"/>
                <dc:type rdf:resource="http://purl.org/dc/dcmitype/InteractiveResource"/>
            </Work>
            <License rdf:about="http://creativecommons.org/licenses/by-nc-sa/3.0/">
                <permits rdf:resource="http://web.resource.org/cc/Reproduction"/>
                <permits rdf:resource="http://web.resource.org/cc/Distribution"/>
                <requires rdf:resource="http://web.resource.org/cc/Notice"/>
                <requires rdf:resource="http://web.resource.org/cc/Attribution"/>
                <prohibits rdf:resource="http://web.resource.org/cc/CommercialUse"/>
                <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks"/>
                <requires rdf:resource="http://web.resource.org/cc/ShareAlike"/>
            </License>
        </rdf:RDF> --&#xE002; </xsl:template>

    <xsl:template name="elml:LayoutTooltipScriptConfig">
        <xsl:text disable-output-escaping="yes"> 
            
            <![CDATA[

//===================  GLOBAL TOOPTIP CONFIGURATION  =========================//
var  tt_Debug	= false		// false or true - recommended: false once you release your page to the public
var  tt_Enabled	= true		// Allows to (temporarily) suppress tooltips, e.g. by providing the user with a button that sets this global variable to false
var  TagsToTip	= true		// false or true - if true, HTML elements to be converted to tooltips via TagToTip() are automatically hidden;
							// if false, you should hide those HTML elements yourself

// For each of the following config variables there exists a command, which is
// just the variablename in uppercase, to be passed to Tip() or TagToTip() to
// configure tooltips individually. Individual commands override global
// configuration. Order of commands is arbitrary.
// Example: onmouseover="Tip('Tooltip text', LEFT, true, BGCOLOR, '#FF9900', FADEIN, 400)"

config. Above			= true 	// false or true - tooltip above mousepointer
config. BgColor 		= '#E2E7FF' // Background colour (HTML colour value, in quotes)
config. BgImg			= ''		// Path to background image, none if empty string ''
config. BorderColor		= '#003099'
config. BorderStyle		= 'solid'	// Any permitted CSS value, but I recommend 'solid', 'dotted' or 'dashed'
config. BorderWidth		= 1
config. CenterMouse		= false 	// false or true - center the tip horizontally below (or above) the mousepointer
config. ClickClose		= false 	// false or true - close tooltip if the user clicks somewhere
config. ClickSticky		= true		// false or true - make tooltip sticky if user left-clicks on the hovered element while the tooltip is active
config. CloseBtn		= false 	// false or true - closebutton in titlebar
config. CloseBtnColors	= ['#990000', '#FFFFFF', '#DD3333', '#FFFFFF']	  // [Background, text, hovered background, hovered text] - use empty strings '' to inherit title colours
config. CloseBtnText	= '&nbsp;X&nbsp;'	// Close button text (may also be an image tag)
config. CopyContent		= true		// When converting a HTML element to a tooltip, copy only the element's content, rather than converting the element by its own
config. Delay			= 400		// Time span in ms until tooltip shows up
config. Duration		= 0 		// Time span in ms after which the tooltip disappears; 0 for infinite duration, < 0 for delay in ms _after_ the onmouseout until the tooltip disappears
config. FadeIn			= 400 		// Fade-in duration in ms, e.g. 400; 0 for no animation
config. FadeOut			= 60
config. FadeInterval	= 30		// Duration of each fade step in ms (recommended: 30) - shorter is smoother but causes more CPU-load
config. Fix				= null		// Fixated position - x- an y-oordinates in brackets, e.g. [210, 480], or null for no fixation
config. FollowMouse		= true		// false or true - tooltip follows the mouse
config. FontColor		= '#000044'
config. FontFace		= 'Verdana,Geneva,sans-serif'
config. FontSize		= '12px' 	// E.g. '9pt' or '12px' - unit is mandatory
config. FontWeight		= 'normal'	// 'normal' or 'bold';
config. Height			= 0 		// Tooltip height; 0 for automatic adaption to tooltip content, < 0 (e.g. -100) for a maximum for automatic adaption
config. JumpHorz		= false		// false or true - jump horizontally to other side of mouse if tooltip would extend past clientarea boundary
config. JumpVert		= true		// false or true - jump vertically		"
config. Left			= false 	// false or true - tooltip on the left of the mouse
config. OffsetX			= 14		// Horizontal offset of left-top corner from mousepointer
config. OffsetY			= 8 		// Vertical offset
config. Opacity			= 95		// Integer between 0 and 100 - opacity of tooltip in percent
config. Padding			= 3 		// Spacing between border and content
config. Shadow			= false 	// false or true
config. ShadowColor		= '#C0C0C0'
config. ShadowWidth		= 5
config. Sticky			= false 	// false or true - fixate tip, ie. don't follow the mouse and don't hide on mouseout
config. TextAlign		= 'left'	// 'left', 'right' or 'justify'
config. Title			= ''		// Default title text applied to all tips (no default title: empty string '')
config. TitleAlign		= 'left'	// 'left' or 'right' - text alignment inside the title bar
config. TitleBgColor	= ''		// If empty string '', BorderColor will be used
config. TitleFontColor	= '#FFFFFF'	// Color of title text - if '', BgColor (of tooltip body) will be used
config. TitleFontFace	= ''		// If '' use FontFace (boldified)
config. TitleFontSize	= '12pt'		// If '' use FontSize
config. Width			= 350 		// Tooltip width; 0 for automatic adaption to tooltip content; < -1 (e.g. -240) for a maximum width for that automatic adaption;
									// -1: tooltip width confined to the width required for the titlebar
//=======  END OF TOOLTIP CONFIG, DO NOT CHANGE ANYTHING BELOW  ==============//


		 ]]> </xsl:text>
    </xsl:template>
</xsl:stylesheet>
