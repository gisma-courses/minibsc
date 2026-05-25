<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" xmlns="http://www.w3.org/1999/xhtml" xmlns:xhtml="http://www.w3.org/1999/xhtml" version="2.0" xmlns:functx="http://www.functx.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <!--DO NOT TOUCH ANYTHING IN THIS FILE! THESE ARE DEFAULT VALUES! -->
    <!--To personalize use the config and templates file of your project. See documentation. -->
    <!--The name of the file with the default titles (and other) names -->
    <xsl:import href="../terms.xsl"/>
    <xsl:import href="../params.xsl"/>
    <xsl:import href="common.xsl"/>
    <xsl:import href="scripts_styles.xsl"/>
    <!--The name of the default bibliography file. Do change it in your online.xsl if you want to use another one! -->
    <xsl:import href="biblio_harvard.xsl"/>
    <!--The name of the default metadata file. Do change it in your online.xsl if you want to use another one! -->
    <xsl:import href="metadata_elml.xsl"/>
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" media-type="text/html" use-character-maps="comment" name="online"/>
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" name="manifest" media-type="text/xml"/>
    <xsl:output method="text" omit-xml-declaration="yes" encoding="UTF-8" media-type="text/text" name="script"/>
    <xsl:strip-space elements="*"/>
    <xsl:function name="elml:get_pathHTML">
        <xsl:param name="baseURI" as="xs:string"/>
        <xsl:param name="lessonlabel" as="xs:string"/>
        <xsl:variable name="pathHTML_temp">
            <xsl:choose>
                <xsl:when test="contains($baseURI, '\')">
                    <xsl:value-of select="functx:substring-before-last($baseURI, concat('\', $lessonlabel,'\'))"/>
                    <xsl:text>\</xsl:text>
                    <xsl:value-of select="$lessonlabel"/>
                    <xsl:text>\</xsl:text>
                    <xsl:value-of select="$lang"/>
                    <xsl:text>\html\</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="functx:substring-before-last($baseURI, concat('/', $lessonlabel,'/'))"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$lessonlabel"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$lang"/>
                    <xsl:text>/html/</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="string(concat($pathHTML_temp[1],$pathHTML_temp[2],$pathHTML_temp[3],$pathHTML_temp[4],$pathHTML_temp[5],$pathHTML_temp[6],$pathHTML_temp[7],$pathHTML_temp[8]))"/>
    </xsl:function>
    <xsl:function name="elml:get_linkcssclass">
        <xsl:param name="navact" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="$navact='_act'">
                <xsl:text>navigationActual</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>navigationLink</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:variable name="filename_suffix">
        <xsl:choose>
            <xsl:when test="//elml:multimedia/@type='mathml'">
                <xsl:text>.xml</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>.html</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:character-map name="comment">
        <!-- Comment start -->
        <xsl:output-character character="&#xE001;" string="&lt;"/>
        <!-- Comment end -->
        <xsl:output-character character="&#xE002;" string="&gt;"/>
        <!-- path_full (breadcrumb) separator -->
        <xsl:output-character character="&#xE003;" string=" &gt;&gt; "/>
    </xsl:character-map>
    <!-- ***** Root and ECLASS Elements *****-->
    <xsl:template name="elml:LayoutHead">
        <head>
            <xsl:if test="//elml:multimedia/@type='mathml'">
                <xsl:processing-instruction name="xml-stylesheet"> href="http://www.w3.org/Math/XSL/mathml.xsl" type="text/xsl" </xsl:processing-instruction>
            </xsl:if>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <meta http-equiv="Content-Script-Type" content="text/javascript"/>
            <meta name="description">
                <xsl:attribute name="content">
                    <xsl:value-of select="/elml:lesson/@title"/>
                    <xsl:if test="not(name()='lesson')">
                        <xsl:text>: </xsl:text>
                        <xsl:call-template name="elml:Kapitel_Title"/>
                    </xsl:if>
                    <xsl:text>. </xsl:text>
                    <xsl:choose>
                        <xsl:when test="name()='learningObject' or name()='summary' or name()='selfAssessment'">
                            <xsl:for-each select="descendant::node()/@title">
                                <xsl:value-of select="."/>
                                <xsl:if test="not(ends-with( current(), '.')) and not(ends-with(., '?')) and not(ends-with(., '!')) and not(ends-with(., ':'))">
                                    <xsl:text>.</xsl:text>
                                </xsl:if>
                                <xsl:text> </xsl:text>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="name()='lesson' or name()='unit'">
                            <xsl:if test="elml:entry/@title">
                                <xsl:value-of select="elml:entry/@title"/>
                                <xsl:text>. </xsl:text>
                            </xsl:if>
                            <xsl:for-each select="elml:entry/descendant::node()/@title">
                                <xsl:value-of select="."/>
                                <xsl:if test="not(ends-with( current(), '.')) and not(ends-with(., '?')) and not(ends-with(., '!')) and not(ends-with(., ':'))">
                                    <xsl:text>.</xsl:text>
                                </xsl:if>
                                <xsl:text> </xsl:text>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="name()='furtherReading'">
                            <xsl:text>A list of recommended writings for further reading on this topic. Includes: </xsl:text>
                            <xsl:for-each-group select="elml:resItem/@bibIDRef" group-by="/elml:lesson/elml:bibliography/*[@bibID=current()]/name()">
                                <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/name()" order="ascending" lang="{$lang}"/>
                                <xsl:call-template name="elml:name_biblio">
                                    <xsl:with-param name="itemname" select="concat(name(/elml:lesson/elml:bibliography/*[@bibID=current()]),'Meta')"/>
                                </xsl:call-template>
                                <xsl:choose>
                                    <xsl:when test="not(position()=last())">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>.</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each-group>
                        </xsl:when>
                        <xsl:when test="name()='bibliography'">
                            <xsl:text>A comprehensive list of writings cited within this lesson. Includes: </xsl:text>
                            <xsl:for-each-group select="node()" group-by="name()">
                                <xsl:sort select="name()" order="ascending" lang="{$lang}"/>
                                <xsl:call-template name="elml:name_biblio">
                                    <xsl:with-param name="itemname" select="concat(name(),'Meta')"/>
                                </xsl:call-template>
                                <xsl:choose>
                                    <xsl:when test="not(position()=last())">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>.</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each-group>
                        </xsl:when>
                        <xsl:when test="name()='glossary'">
                            <xsl:text>List of this lessons relevant terms with its definitions and further explanations. </xsl:text>
                        </xsl:when>
                        <xsl:when test="name()='index'">
                            <xsl:text>List of words and associated pointers - either links or page numbers (in printed version) - to where those words can be found in the lesson. Not to be confused with the glossary. </xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </xsl:attribute>
            </meta>
            <meta name="copyright">
                <xsl:attribute name="content">
                    <xsl:value-of select="/elml:lesson/elml:metadata/elml:rights/elml:copyright"/>
                    <xsl:if test="/elml:lesson/elml:metadata/elml:rights/elml:copyrightURL">
                        <xsl:text> (see </xsl:text>
                        <xsl:value-of select="$server"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="/elml:lesson/@label"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$lang"/>
                        <xsl:text>/html/</xsl:text>
                        <xsl:value-of select="/elml:lesson/elml:metadata/elml:rights/elml:copyrightURL"/>
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                </xsl:attribute>
            </meta>
            <meta name="author">
                <xsl:attribute name="content">
                    <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:contribute/elml:person">
                        <xsl:value-of select="@name"/> (<xsl:value-of select="@responsible"/>) <xsl:if test="not(position()=last())">, </xsl:if>
                    </xsl:for-each>
                </xsl:attribute>
            </meta>
            <meta name="keywords">
                <xsl:attribute name="content">
                    <xsl:value-of select="/elml:lesson/@title"/>, <xsl:for-each select="/elml:lesson/elml:metadata/elml:keywords/elml:keywordItem">
                        <xsl:value-of select="."/>
                        <xsl:if test="not(position()=last())">, </xsl:if>
                    </xsl:for-each>
                    <xsl:for-each select="/elml:lesson/elml:glossary/elml:definition">
                        <xsl:value-of select="@term"/>, </xsl:for-each>
                </xsl:attribute>
            </meta>
            <title>
                <xsl:if test="not(@title)">
                    <xsl:value-of select="/elml:lesson/@title"/>
                    <xsl:text>: </xsl:text>
                </xsl:if>
                <xsl:call-template name="elml:Kapitel"/>
            </title>
            <xsl:if test="descendant::elml:selfCheck">
                <xsl:call-template name="elml:LayoutSelfCheckCSS"/>
                <xsl:call-template name="elml:LayoutSelfCheckScript"/>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="not($layout='none')">
                    <link href="../../../_templates/{$layout}/elml.css" type="text/css" rel="stylesheet" media="screen"/>
                    <link href="../../../_templates/{$layout}/elml_print.css" type="text/css" rel="stylesheet" media="print,handheld"/>
                    <script src="../../../_templates/{$layout}/elml.js" type="text/javascript"><![CDATA[ ]]></script>
                </xsl:when>
                <xsl:when test="$css_framework='yaml'">
                    <link href="http://www.yaml.de/fileadmin/css/layout_2col_left.css" type="text/css" rel="stylesheet" media="screen"/>
                    <xsl:call-template name="elml:LayoutHeadDefaultCSS"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="elml:LayoutHeadDefaultCSS"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="$css_framework='yaml'">
                <xsl:text disable-output-escaping="yes"> <![CDATA[
                    <!--[if lte IE 7]>
                    <link href="../../../_templates]]></xsl:text>
                <xsl:text disable-output-escaping="yes"><![CDATA[/yaml/patches/patch_layout_draft.css" rel="stylesheet" type="text/css" />
                        <![endif]--> 
                        ]]> </xsl:text>
            </xsl:if>
            <xsl:if test="$lightwindow='yes'">
                <script type="text/javascript" src="../../../_templates/{$layout}/lightwindow/javascript/prototype.js" id="lwloader_prototype_js"><![CDATA[ ]]></script>
                <script type="text/javascript" src="../../../_templates/{$layout}/lightwindow/javascript/effects.js" id="lwloader_effects_js"><![CDATA[ ]]></script>
                <script type="text/javascript" src="../../../_templates/{$layout}/lightwindow/javascript/lightwindow_loader.js" id="lwloader"><![CDATA[ ]]></script>
            </xsl:if>
            <xsl:if test="$manifest_type='scorm'">
                <script type="text/javascript" language="JavaScript1.2" src="scorm_generic.js"/>
            </xsl:if>
        </head>
    </xsl:template>
    <!-- Default template for the body part of HTML document if YAML is used or if no template is used -->
    <xsl:template name="elml:LayoutBody">
        <body>
            <xsl:if test="$manifest_type='scorm'">
                <xsl:attribute name="onunload">
                    <xsl:value-of>finish()</xsl:value-of>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:LayoutBodySkiplinks"/>
            <xsl:choose>
                <xsl:when test="$css_framework='yaml'">
                    <div id="page_margins">
                        <div id="page">
                            <div id="header">
                                <div id="topnav">
                                    <span>
                                        <xsl:call-template name="elml:path_full"/>
                                    </span>
                                </div>
                                <h1>
                                    <xsl:value-of select="/elml:lesson/@title"/>
                                </h1>
                            </div>
                            <xsl:if test="$multiple='on'">
                                <!-- #nav: Top Navigation -->
                                <div id="nav">
                                    <div id="nav_main">
                                        <ul>
                                            <xsl:call-template name="elml:navigation_top"/>
                                        </ul>
                                    </div>
                                </div>
                                <!-- #nav: - End -->
                            </xsl:if>
                            <!-- #main: Start Content Part -->
                            <div id="main" class="hideright">
                                <!-- #col1: First column contains navigation in eLML -->
                                <div id="col1">
                                    <div id="col1_content" class="clearfix">
                                        <xsl:call-template name="elml:navigation"/>
                                    </div>
                                </div>
                                <!-- #col1: - End -->
                                <!-- #col2: Second column contains context information (if available) in eLML -->
                                <div id="col2">
                                    <div id="col2_content" class="clearfix">
                                        <h2>Context Information</h2>
                                        <p>...</p>
                                    </div>
                                </div>
                                <!-- #col2: - End -->
                                <!-- #col3: Third and variable column contains all the content in eLML -->
                                <div id="col3">
                                    <a id="top" name="top"/>
                                    <a id="content_link" name="content_link"/>
                                    <div id="col3_content" class="clearfix">
                                        <xsl:call-template name="elml:LayoutBodyContent"/>
                                    </div>
                                    <!-- IE Column Clearing -->
                                    <div id="ie_clearing">
                                        <xsl:text disable-output-escaping="yes"><![CDATA[ &nbsp; ]]></xsl:text>
                                    </div>
                                    <!-- End: IE Column Clearing -->
                                </div>
                                <!-- #col3: - Ende -->
                            </div>
                            <!-- #main: - End -->
                            <!-- #Footer: Begin Footer -->
                            <div id="footer">
                                <xsl:call-template name="elml:footer"/>
                            </div>
                            <!-- #Footer: End -->
                        </div>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="elml:navigation"/>
                    <a name="top"/>
                    <a id="content_link" name="content_link"/>
                    <xsl:call-template name="elml:LayoutBodyContent"/>
                    <hr/>
                    <xsl:call-template name="elml:footer"/>
                </xsl:otherwise>
            </xsl:choose>
        </body>
    </xsl:template>
    <!-- The Skiplinks are needed for screenreaders and should be added to every layout right after the body tag -->
    <xsl:template name="elml:LayoutBodySkiplinks">
        <!-- Start: Skiplink-Navigation -->
        <a class="skip" href="#navigation_link" style="position: absolute; left: -1000em; width: 20em;">
            <xsl:attribute name="title">
                <xsl:value-of select="$name_internalLink"/>
                <xsl:text> Menu</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="$name_internalLink"/>
            <xsl:text> Menu</xsl:text>
        </a>
        <a class="skip" href="#content_link" style="position: absolute; left: -1000em; width: 20em;">
            <xsl:attribute name="title">
                <xsl:value-of select="$name_internalLink"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$name_content"/>
            </xsl:attribute>
            <xsl:value-of select="$name_internalLink"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$name_content"/>
        </a>
        <!-- End: Skiplink-Navigation -->
    </xsl:template>
    <xsl:template name="elml:LayoutBodyContent">
        <!-- Skiplink-Anchor: Content -->
        <xsl:choose>
            <xsl:when test="((name(.)='clarify') or (name(.)='look') or (name(.)='act')) and not(@title)"/>
            <!-- Delete this statement if you want a default title for the entry element -->
            <xsl:when test="(name(.)='entry') and not(@title)">
                <span>
                    <xsl:call-template name="elml:Label"/>
                </span>
            </xsl:when>
            <xsl:when test="($pagebreak_level='lesson') and ((name(.)='clarify') or (name(.)='look') or (name(.)='act'))">
                <h4>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:call-template name="elml:Kapitel"/>
                </h4>
            </xsl:when>
            <xsl:when test="(($pagebreak_level='lesson') and ((name(.)='learningObject') or ((name(parent::*)='unit') and ((name(.)='entry') or (name(.)='goals') or (name(.)='selfAssessment') or (name(.)='summary') or (name(.)='furtherReading'))))) or (($pagebreak_level='unit') and ((name(.)='clarify') or (name(.)='look') or (name(.)='act')))">
                <h3>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:call-template name="elml:Kapitel"/>
                </h3>
            </xsl:when>
            <xsl:when test="(name(.)='clarify') or (name(.)='look') or (name(.)='act') or (name(.)='entry') or (name(.)='goals') or (($pagebreak_level='unit') and ((name(.)='learningObject') or ((name(parent::*)='unit') and ((name(.)='selfAssessment') or (name(.)='summary') or (name(.)='furtherReading'))))) or (($pagebreak_level='lesson') and ((name(.)='unit') or (name(.)='glossary') or (name(.)='listOfFigures') or (name(.)='listOfTables') or (name(.)='index') or (name(.)='bibliography') or (name(.)='metadata') or ((name(parent::*)='lesson') and ((name(.)='selfAssessment') or (name(.)='summary') or (name(.)='furtherReading'))) ))">
                <h2>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:call-template name="elml:Kapitel"/>
                </h2>
            </xsl:when>
            <xsl:otherwise>
                <h1>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:call-template name="elml:Kapitel"/>
                </h1>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="name(.)='unit' and contains($optional_units, @label)">
            <p class="tutor">
                <xsl:value-of select="$name_optionalunits_text"/>
            </p>
        </xsl:if>
        <xsl:if test="@role='tutor'">
            <p class="tutor">
                <xsl:value-of select="$name_tutoronly"/>
            </p>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="name(.)='glossary'">
                <dl class="glossary">
                    <xsl:apply-templates>
                        <xsl:sort select="@term" order="ascending" lang="{$lang}"/>
                    </xsl:apply-templates>
                </dl>
            </xsl:when>
            <xsl:when test="name(.)='listOfTables' and not(//elml:table)">
                <p>
                    <xsl:value-of select="$name_tables"/>
                    <xsl:value-of select="$name_glossary_empty"/>
                </p>
            </xsl:when>
            <xsl:when test="name(.)='listOfTables'">
                <ul>
                    <xsl:call-template name="elml:CSS_Class"/>
                    <xsl:for-each select="//elml:table">
                        <li>
                            <xsl:call-template name="elml:Legend_listof"/>
                            <xsl:if test="@bibIDRef">
                                <xsl:call-template name="elml:BibliographyRef"/>
                            </xsl:if>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:when>
            <xsl:when test="name(.)='listOfFigures' and not(//elml:multimedia)">
                <p>
                    <xsl:value-of select="$name_figures"/>
                    <xsl:value-of select="$name_glossary_empty"/>
                </p>
            </xsl:when>
            <xsl:when test="name(.)='listOfFigures'">
                <ul>
                    <xsl:call-template name="elml:CSS_Class"/>
                    <xsl:for-each select="//elml:multimedia">
                        <xsl:if test="not(@type='div')">
                            <li>
                                <xsl:call-template name="elml:Legend_listof"/>
                                <xsl:if test="@bibIDRef">
                                    <xsl:call-template name="elml:BibliographyRef"/>
                                </xsl:if>
                                <xsl:text> (</xsl:text>
                                <xsl:value-of select="@type"/>
                                <xsl:text>)</xsl:text>
                            </li>
                        </xsl:if>
                    </xsl:for-each>
                </ul>
            </xsl:when>
            <xsl:when test="name(.)='index' and not(//elml:indexItem)">
                <p>
                    <xsl:value-of select="$name_index"/>
                    <xsl:value-of select="$name_glossary_empty"/>
                </p>
            </xsl:when>
            <xsl:when test="name(.)='index'">
                <ul class="index_list">
                    <xsl:for-each-group select="//elml:indexItem" group-by="(if (@affiliatedTo) then  @affiliatedTo else .)">
                        <xsl:sort select="." order="ascending" case-order="lower-first"/>
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>
                            <xsl:text>: </xsl:text>
                            <xsl:for-each select="current-group()">
                                <xsl:variable name="indexID">
                                    <xsl:value-of select="generate-id()"/>
                                </xsl:variable>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:for-each select="ancestor::node()[name()='learningObject' or name()='selfAssessment' or name()='furtherReading' or name()='unit' or name()='lesson'][1]">
                                            <xsl:variable name="filename_index">
                                                <xsl:call-template name="elml:Label_param_withfilename"/>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="contains($filename_index, '#')">
                                                    <xsl:value-of select="concat(substring-before($filename_index, '#'), '#', $indexID)"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="concat($filename_index, '#', $indexID)"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                    </xsl:attribute>
                                    <xsl:choose>
                                        <xsl:when test="@mainEntry='yes'">
                                            <b>
                                                <xsl:text>--></xsl:text>
                                            </b>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>--></xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </a>
                                <xsl:if test="not(position()=last())">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </li>
                    </xsl:for-each-group>
                </ul>
            </xsl:when>
            <xsl:when test="name(.)='furtherReading'">
                <xsl:choose>
                    <xsl:when test="@sorting='off'">
                        <ul class="furtherReading">
                            <xsl:for-each select="elml:resItem">
                                <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]">
                                    <xsl:with-param name="comment" select="text()"/>
                                    <xsl:with-param name="furtherReading" select="@bibIDRef"/>
                                    <xsl:with-param name="pageNr" select="@pageNr"/>
                                </xsl:apply-templates>
                            </xsl:for-each>
                        </ul>
                    </xsl:when>
                    <xsl:when test="@sorting='byYear'">
                        <ul class="furtherReading">
                            <xsl:for-each select="elml:resItem">
                                <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@publicationYear" order="descending" lang="{$lang}"/>
                                <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]">
                                    <xsl:with-param name="comment" select="text()"/>
                                    <xsl:with-param name="furtherReading" select="@bibIDRef"/>
                                    <xsl:with-param name="pageNr" select="@pageNr"/>
                                </xsl:apply-templates>
                            </xsl:for-each>
                        </ul>
                    </xsl:when>
                    <xsl:when test="@sorting='groupByType'">
                        <xsl:for-each-group select="elml:resItem/@bibIDRef" group-by="/elml:lesson/elml:bibliography/*[@bibID=current()]/name()">
                            <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/name()" order="ascending" lang="{$lang}"/>
                            <h2>
                                <xsl:call-template name="elml:name_biblio">
                                    <xsl:with-param name="itemname" select="name(/elml:lesson/elml:bibliography/*[@bibID=current()])"/>
                                </xsl:call-template>
                            </h2>
                            <ul class="furtherReading">
                                <xsl:for-each select="current-group()">
                                    <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@author" order="ascending" lang="{$lang}"/>
                                    <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()]">
                                        <xsl:with-param name="comment" select="../text()"/>
                                        <xsl:with-param name="furtherReading" select="current()"/>
                                        <xsl:with-param name="pageNr" select="../@pageNr"/>
                                    </xsl:apply-templates>
                                </xsl:for-each>
                            </ul>
                        </xsl:for-each-group>
                    </xsl:when>
                    <xsl:when test="@sorting='groupByYear'">
                        <xsl:for-each-group select="elml:resItem/@bibIDRef" group-by="/elml:lesson/elml:bibliography/*[@bibID=current()]/@publicationYear">
                            <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@publicationYear" order="descending" lang="{$lang}"/>
                            <h2>
                                <xsl:value-of select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@publicationYear"/>
                            </h2>
                            <ul class="furtherReading">
                                <xsl:for-each select="current-group()">
                                    <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@author"/>
                                    <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()]">
                                        <xsl:with-param name="comment" select="../text()"/>
                                        <xsl:with-param name="furtherReading" select="current()"/>
                                        <xsl:with-param name="pageNr" select="../@pageNr"/>
                                    </xsl:apply-templates>
                                </xsl:for-each>
                            </ul>
                        </xsl:for-each-group>
                    </xsl:when>
                    <xsl:otherwise>
                        <ul class="furtherReading">
                            <xsl:for-each select="elml:resItem">
                                <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@author" order="ascending" lang="{$lang}"/>
                                <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]">
                                    <xsl:with-param name="comment" select="text()"/>
                                    <xsl:with-param name="furtherReading" select="@bibIDRef"/>
                                    <xsl:with-param name="pageNr" select="@pageNr"/>
                                </xsl:apply-templates>
                            </xsl:for-each>
                        </ul>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="name(.)='bibliography'">
                <xsl:choose>
                    <xsl:when test="@sorting='off'">
                        <ul class="bibliography">
                            <xsl:apply-templates/>
                        </ul>
                    </xsl:when>
                    <xsl:when test="@sorting='byYear'">
                        <ul class="bibliography">
                            <xsl:apply-templates>
                                <xsl:sort select="@publicationYear" order="descending" lang="{$lang}"/>
                            </xsl:apply-templates>
                        </ul>
                    </xsl:when>
                    <xsl:when test="@sorting='groupByType'">
                        <xsl:for-each-group select="node()" group-by="name()">
                            <xsl:sort select="name()" order="ascending" lang="{$lang}"/>
                            <h2>
                                <xsl:call-template name="elml:name_biblio">
                                    <xsl:with-param name="itemname" select="name()"/>
                                </xsl:call-template>
                            </h2>
                            <ul class="bibliography">
                                <xsl:apply-templates select="current-group()">
                                    <xsl:sort select="@author" order="ascending" lang="{$lang}"/>
                                </xsl:apply-templates>
                            </ul>
                        </xsl:for-each-group>
                    </xsl:when>
                    <xsl:when test="@sorting='groupByYear'">
                        <xsl:for-each-group select="node()" group-by="@publicationYear">
                            <xsl:sort select="@publicationYear" order="descending" lang="{$lang}"/>
                            <h2>
                                <xsl:value-of select="@publicationYear"/>
                            </h2>
                            <ul class="bibliography">
                                <xsl:apply-templates select="current-group()">
                                    <xsl:sort select="@author" order="ascending" lang="{$lang}"/>
                                </xsl:apply-templates>
                            </ul>
                        </xsl:for-each-group>
                    </xsl:when>
                    <xsl:otherwise>
                        <ul class="bibliography">
                            <xsl:apply-templates>
                                <xsl:sort select="@author" order="ascending" lang="{$lang}"/>
                            </xsl:apply-templates>
                        </ul>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="name(.)='goals'">
                <xsl:choose>
                    <xsl:when test="@presentation='table'">
                        <table class="goals">
                            <xsl:if test="@intStatement">
                                <tr>
                                    <th align="left">
                                        <xsl:value-of select="@intStatement"/>
                                    </th>
                                </tr>
                            </xsl:if>
                            <xsl:for-each select="elml:lObjective">
                                <xsl:if test="(@role='student') or (@role=$role) or (not (@role))">
                                    <tr>
                                        <xsl:call-template name="elml:CSS_Class"/>
                                        <td>
                                            <xsl:apply-templates/>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </xsl:for-each>
                        </table>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="@intStatement">
                            <p class="paragraph">
                                <xsl:value-of select="@intStatement"/>
                            </p>
                        </xsl:if>
                        <ul class="goals">
                            <xsl:for-each select="elml:lObjective">
                                <xsl:if test="(@role='student') or (@role=$role) or (not (@role))">
                                    <li>
                                        <xsl:call-template name="elml:CSS_Class"/>
                                        <xsl:apply-templates/>
                                    </li>
                                </xsl:if>
                            </xsl:for-each>
                        </ul>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="elml:metasetupinfo"/>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="$multiple='on'">
                <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                    <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson"/>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="elml:manifest"/>
        <xsl:call-template name="elml:sitemap"/>
    </xsl:template>
    <xsl:template match="elml:lesson">
        <xsl:param name="filename">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="($pagebreak_level='lesson') or ($pagebreak_level='unit') or ($pagebreak_level='lo')">
                <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}{$filename}" format="online">
                    <html>
                        <xsl:call-template name="elml:LayoutHead"/>
                        <xsl:call-template name="elml:LayoutBody"/>
                    </html>
                </xsl:result-document>
                <xsl:choose>
                    <xsl:when test="contains(base-uri(), '\')">
                        <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}..\index.html" format="online">
                            <html>
                                <head>
                                    <title>Redirect</title>
                                    <meta http-equiv="Refresh">
                                        <xsl:attribute name="content">
                                            <xsl:text>0; URL=html/index</xsl:text>
                                            <xsl:value-of select="$filename_suffix"/>
                                        </xsl:attribute>
                                    </meta>
                                </head>
                                <body>You will be redirected to the start of the lesson</body>
                            </html>
                        </xsl:result-document>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}../index.html" format="online">
                            <html>
                                <head>
                                    <title>Redirect</title>
                                    <meta http-equiv="Refresh">
                                        <xsl:attribute name="content">
                                            <xsl:text>0; URL=html/index</xsl:text>
                                            <xsl:value-of select="$filename_suffix"/>
                                        </xsl:attribute>
                                    </meta>
                                </head>
                                <body>You will be redirected to the start of the lesson</body>
                            </html>
                        </xsl:result-document>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <html>
                    <xsl:call-template name="elml:LayoutHead"/>
                    <xsl:call-template name="elml:LayoutBody"/>
                </html>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="descendant::node()/@feedback or descendant::elml:term or descendant::elml:annotation">
            <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}wz_tooltip.js" format="script">
                <xsl:call-template name="elml:LayoutTooltipScript"/>
            </xsl:result-document>
        </xsl:if>
        <xsl:if test="descendant::elml:selfCheck">
            <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}selfCheck.js" format="script">
                <xsl:call-template name="elml:LayoutSelfCheckScriptCode"/>
            </xsl:result-document>
            <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}selfCheck.css" format="script">
                <xsl:call-template name="elml:LayoutSelfCheckCSSCode"/>
            </xsl:result-document>
        </xsl:if>
        <xsl:if test="$manifest_type='scorm'">
            <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}scorm_generic.js" format="script">
                <xsl:call-template name="elml:scorm_generic_js"/>
            </xsl:result-document>
            <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}imscp_rootv1p1p2.xsd" format="script">
                <xsl:call-template name="elml:scorm_generic_imscp_xsd"/>
            </xsl:result-document>
            <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}imsmd_rootv1p2p1.xsd" format="script">
                <xsl:call-template name="elml:scorm_generic_imsmd_xsd"/>
            </xsl:result-document>
            <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}adlcp_rootv1p2.xsd" format="script">
                <xsl:call-template name="elml:scorm_generic_adlcp_xsd"/>
            </xsl:result-document>
            <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}ims_xml.xsd" format="script">
                <xsl:call-template name="elml:scorm_generic_xml_xsd"/>
            </xsl:result-document>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:unit">
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
    <xsl:template match="elml:learningObject">
        <xsl:param name="filename">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$pagebreak_level='lo'">
                <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}{$filename}" format="online">
                    <html>
                        <xsl:call-template name="elml:LayoutHead"/>
                        <xsl:call-template name="elml:LayoutBody"/>
                    </html>
                </xsl:result-document>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="elml:LayoutBodyContent"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:metasetupinfo">
        <!--Check if there is some setup info available and if the user is allowed to see it.-->
        <xsl:if test="(@metaSetUpInfo) and (not(@metaSetUpInfo ='none')) and (not(@metaSetUpInfo ='nothing')) and ($role='tutor')">
            <p class="tutor">
                <xsl:value-of select="$name_metaSetUpInfo"/>
                <xsl:value-of select="@metaSetUpInfo"/>
            </p>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:clarify | elml:look | elml:act">
        <div>
            <xsl:if test="not(@title)">
                <xsl:call-template name="elml:Label"/>
            </xsl:if>
            <xsl:call-template name="elml:CSS_Class"/>
            <xsl:call-template name="elml:LayoutBodyContent"/>
        </div>
    </xsl:template>
    <xsl:template match="elml:entry">
        <!--Template to display the entry text both on lesson and on unit level.-->
        <xsl:call-template name="elml:LayoutBodyContent"/>
    </xsl:template>
    <xsl:template match="elml:goals">
        <!--Template to display the goals both on lesson and on unit level.-->
        <xsl:if test="elml:lObjective">
            <xsl:call-template name="elml:LayoutBodyContent"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:selfAssessment">
        <!--Template for self assessment both on lesson and on unit level.-->
        <xsl:param name="filename">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="(($pagebreak_level='unit') and (name(parent::*)='lesson')) or ($pagebreak_level='lo')">
                <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}{$filename}" format="online">
                    <html>
                        <xsl:call-template name="elml:LayoutHead"/>
                        <xsl:call-template name="elml:LayoutBody"/>
                    </html>
                </xsl:result-document>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="elml:LayoutBodyContent"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:summary">
        <!--Template to display summaries both on lesson and on unit level.-->
        <xsl:param name="filename">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="(($pagebreak_level='unit') and (name(parent::*)='lesson')) or ($pagebreak_level='lo')">
                <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}{$filename}" format="online">
                    <html>
                        <xsl:call-template name="elml:LayoutHead"/>
                        <xsl:call-template name="elml:LayoutBody"/>
                    </html>
                </xsl:result-document>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="elml:LayoutBodyContent"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- ***** Glossary and Index Elements *****-->
    <xsl:template match="elml:glossary">
        <!--Template to display the glossary of this lesson. Uses the next template (called definition) for the display of each term.-->
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
    <xsl:template match="elml:definition">
        <xsl:param name="term"/>
        <xsl:param name="icon"/>
        <xsl:param name="content"/>
        <dt>
            <xsl:if test="not($content='yes')">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id()"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="$term">
                    <xsl:value-of select="$term"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@term"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>: </xsl:text>
        </dt>
        <dd>
            <xsl:if test="$icon and not($layout='none') and $content='yes'">
                <img src="../../../_templates/{$layout}/icons/{$icon}.{$icon_filetype}" title="{$icon}" alt="{$icon}" class="icon"/>
            </xsl:if>
            <xsl:apply-templates/>
            <xsl:call-template name="elml:BibliographyRef"/>
        </dd>
    </xsl:template>
    <xsl:template match="elml:index | elml:listOfFigures | elml:listOfTables">
        <!--Template to display the index, list of tables and list of figures of this lesson. -->
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
    <!-- ***** Bibliography Elements (most stuff in external file biblio_*.xsl) *****-->
    <xsl:template name="elml:BibliographyRef">
        <!--A template used to generate bibliography references within the lesson, eg. (Fisler 2004)-->
        <xsl:if test="@bibIDRef">
            <xsl:variable name="id" select="@bibIDRef"/>
            <xsl:variable name="author">
                <xsl:choose>
                    <xsl:when test="/elml:lesson/elml:bibliography/*[@bibID=$id]/@author">
                        <xsl:value-of select="/elml:lesson/elml:bibliography/*[@bibID=$id]/@author"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$name_anon"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:text> </xsl:text>
            <xsl:if test="not(@yearOnly='yes')">
                <xsl:text>(</xsl:text>
            </xsl:if>
            <a class="bibLink">
                <xsl:attribute name="href">
                    <xsl:if test="($pagebreak_level='unit') or ($pagebreak_level='lo')">
                        <xsl:value-of select="/elml:lesson/@label"/>
                        <xsl:text>_bibliography</xsl:text>
                        <xsl:value-of select="$filename_suffix"/>
                    </xsl:if>
                    <xsl:if test="$pagebreak_level='lesson'">
                        <xsl:text>index</xsl:text>
                        <xsl:value-of select="$filename_suffix"/>
                    </xsl:if>
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="generate-id(/elml:lesson/elml:bibliography/*[@bibID=$id])"/>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="contains($author, ',')">
                        <xsl:value-of select="substring-before($author, ',')"/>
                        <xsl:if test="contains(substring-after($author, ','), ',')">
                            <xsl:text> et al.</xsl:text>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$author"/>
                    </xsl:otherwise>
                </xsl:choose>
            </a>
            <xsl:if test="/elml:lesson/elml:bibliography/*[@bibID=$id]/@publicationYear or @pageNr">
                <xsl:choose>
                    <xsl:when test="@yearOnly='yes'">
                        <xsl:text> (</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="/elml:lesson/elml:bibliography/*[@bibID=$id]/@publicationYear"/>
                <xsl:if test="@pageNr">
                    <xsl:choose>
                        <xsl:when test="$lang='de'">
                            <xsl:text>, S. </xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>, p. </xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of select="@pageNr"/>
                </xsl:if>
            </xsl:if>
            <xsl:if test="/elml:lesson/elml:bibliography/*[@bibID=$id]/@publicationYear or @pageNr or not(@yearOnly='yes')">
                <xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:furtherReading">
        <!--Builds the further reading chapter-->
        <xsl:param name="filename">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="(($pagebreak_level='unit') and (name(parent::*)='lesson')) or ($pagebreak_level='lo')">
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
    <xsl:template match="elml:bibliography">
        <!--Builds the bilbiography chapter-->
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
    <!-- ***** "Paragraph" Elements like colum, table, multimedia, link etc. *****-->
    <xsl:template match="elml:column">
        <!--Template that matches the "column" paragraph type.-->
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:param name="columnleftwidth">
            <xsl:choose>
                <xsl:when test="elml:columnMiddle">
                    <xsl:text>33</xsl:text>
                </xsl:when>
                <xsl:when test="*/@units='percent'">
                    <xsl:choose>
                        <xsl:when test="elml:columnLeft/@width &lt; '29' or elml:columnRight/@width &gt; '70'">
                            <xsl:text>25</xsl:text>
                        </xsl:when>
                        <xsl:when test="elml:columnLeft/@width &lt; '35' or elml:columnRight/@width &gt; '64'">
                            <xsl:text>33</xsl:text>
                        </xsl:when>
                        <xsl:when test="elml:columnLeft/@width &lt; '42' or elml:columnRight/@width &gt; '58'">
                            <xsl:text>38</xsl:text>
                        </xsl:when>
                        <xsl:when test="elml:columnLeft/@width &lt; '58' or elml:columnRight/@width &gt; '42'">
                            <xsl:text>50</xsl:text>
                        </xsl:when>
                        <xsl:when test="elml:columnLeft/@width &lt; '64' or elml:columnRight/@width &gt; '35'">
                            <xsl:text>62</xsl:text>
                        </xsl:when>
                        <xsl:when test="elml:columnLeft/@width &lt; '70' or elml:columnRight/@width &gt; '29'">
                            <xsl:text>66</xsl:text>
                        </xsl:when>
                        <xsl:when test="elml:columnLeft/@width &gt; '69' or elml:columnRight/@width &lt; '30'">
                            <xsl:text>75</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>50</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>50</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$css_framework='yaml' and $display='yes'">
                <div>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:attribute name="class">
                        <xsl:text>subcolumns </xsl:text>
                        <xsl:choose>
                            <xsl:when test="@cssClass">
                                <xsl:value-of select="@cssClass"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="name()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="elml:columnRight/@units='pixels' and elml:columnRight/@width and not(elml:columnMiddle)">
                            <xsl:apply-templates select="elml:columnRight" mode="yaml">
                                <xsl:with-param name="columnleftwidth" select="$columnleftwidth"/>
                            </xsl:apply-templates>
                            <xsl:apply-templates select="elml:columnLeft" mode="yaml">
                                <xsl:with-param name="columnleftwidth" select="$columnleftwidth"/>
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates mode="yaml">
                                <xsl:with-param name="columnleftwidth" select="$columnleftwidth"/>
                            </xsl:apply-templates>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
            </xsl:when>
            <xsl:when test="$display='yes'">
                <table>
                    <xsl:call-template name="elml:CSS_Class"/>
                    <xsl:call-template name="elml:Label"/>
                    <tr valign="top">
                        <xsl:apply-templates/>
                    </tr>
                </table>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:columnLeft | elml:columnMiddle | elml:columnRight">
        <td>
            <xsl:call-template name="elml:CSS_Class"/>
            <xsl:call-template name="elml:WidthHeight"/>
            <xsl:call-template name="elml:Alignment"/>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    <xsl:template match="elml:columnLeft" mode="yaml">
        <xsl:param name="columnleftwidth"/>
        <div>
            <xsl:attribute name="class">
                <xsl:text>c</xsl:text>
                <xsl:value-of select="$columnleftwidth"/>
                <xsl:text>l</xsl:text>
            </xsl:attribute>
            <xsl:if test="../elml:columnRight/@units='pixels' and ../elml:columnRight/@width and not(../elml:columnMiddle)">
                <xsl:attribute name="style">
                    <xsl:text>width:auto; float:none; margin-right: </xsl:text>
                    <xsl:value-of select="../elml:columnRight/@width"/>
                    <xsl:text>px;</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <div>
                <xsl:attribute name="class">
                    <xsl:text>subcl </xsl:text>
                    <xsl:choose>
                        <xsl:when test="@cssClass">
                            <xsl:value-of select="@cssClass"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="name()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="@align='right'">
                            <xsl:text> float_right</xsl:text>
                        </xsl:when>
                        <xsl:when test="@align='center'">
                            <xsl:text> center</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="elml:columnMiddle" mode="yaml">
        <xsl:param name="columnleftwidth"/>
        <div class="c33l">
            <div>
                <xsl:attribute name="class">
                    <xsl:text>subc </xsl:text>
                    <xsl:choose>
                        <xsl:when test="@cssClass">
                            <xsl:value-of select="@cssClass"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="name()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="@align='right'">
                            <xsl:text> float_right</xsl:text>
                        </xsl:when>
                        <xsl:when test="@align='center'">
                            <xsl:text> center</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="elml:columnRight" mode="yaml">
        <xsl:param name="columnleftwidth"/>
        <div>
            <xsl:attribute name="class">
                <xsl:text>c</xsl:text>
                <xsl:choose>
                    <xsl:when test="$columnleftwidth='75'">
                        <xsl:text>25</xsl:text>
                    </xsl:when>
                    <xsl:when test="$columnleftwidth='66' or ../elml:columnMiddle">
                        <xsl:text>33</xsl:text>
                    </xsl:when>
                    <xsl:when test="$columnleftwidth='62'">
                        <xsl:text>38</xsl:text>
                    </xsl:when>
                    <xsl:when test="$columnleftwidth='38'">
                        <xsl:text>62</xsl:text>
                    </xsl:when>
                    <xsl:when test="$columnleftwidth='33'">
                        <xsl:text>66</xsl:text>
                    </xsl:when>
                    <xsl:when test="$columnleftwidth='25'">
                        <xsl:text>75</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>50</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>r</xsl:text>
            </xsl:attribute>
            <xsl:if test="@units='pixels' and @width and not(../elml:columnMiddle)">
                <xsl:attribute name="style">
                    <xsl:text>width: </xsl:text>
                    <xsl:value-of select="../elml:columnRight/@width"/>
                    <xsl:text>px;</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <div>
                <xsl:attribute name="class">
                    <xsl:text>subcr </xsl:text>
                    <xsl:choose>
                        <xsl:when test="@cssClass">
                            <xsl:value-of select="@cssClass"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="name()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="@align='right'">
                            <xsl:text> float_right</xsl:text>
                        </xsl:when>
                        <xsl:when test="@align='center'">
                            <xsl:text> center</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="elml:table">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:call-template name="elml:Title"/>
            <xsl:if test="@icon and not($layout='none')">
                <img src="../../../_templates/{$layout}/icons/{@icon}.{$icon_filetype}" title="{@icon}" alt="{@icon}" class="icon"/>
            </xsl:if>
            <table>
                <xsl:call-template name="elml:CSS_Class"/>
                <xsl:call-template name="elml:Label"/>
                <xsl:call-template name="elml:WidthHeight"/>
                <xsl:if test="elml:tablerow/*[name()='tableheading']">
                    <thead>
                        <xsl:for-each select="elml:tablerow/*[name()='tableheading']/..">
                            <tr>
                                <xsl:call-template name="elml:CSS_Class"/>
                                <xsl:apply-templates/>
                            </tr>
                        </xsl:for-each>
                    </thead>
                </xsl:if>
                <tbody>
                    <xsl:for-each select="elml:tablerow/*[name()='tabledata']/..">
                        <tr>
                            <xsl:call-template name="elml:CSS_Class"/>
                            <xsl:apply-templates/>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
            <xsl:call-template name="elml:Legend"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:term">
        <xsl:param name="termid" select="@glossRef"/>
        <xsl:param name="content"/>
        <xsl:param name="term">
            <xsl:choose>
                <xsl:when test="text()">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="/elml:lesson/elml:glossary/elml:definition[@term=$termid]/@term"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="inline">
            <xsl:call-template name="elml:inline"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$inline='no'">
                <dl class="glossary">
                    <xsl:apply-templates select="/elml:lesson/elml:glossary/elml:definition[@term=$termid]">
                        <xsl:with-param name="term" select="$term"/>
                        <xsl:with-param name="icon" select="@icon"/>
                        <xsl:with-param name="content">yes</xsl:with-param>
                    </xsl:apply-templates>
                </dl>
            </xsl:when>
            <xsl:otherwise>
                <a>
                    <xsl:call-template name="elml:CSS_Class"/>
                    <xsl:attribute name="href">
                        <xsl:if test="not($pagebreak_level='unit') and not($pagebreak_level='lo')">
                            <xsl:text>#</xsl:text>
                        </xsl:if>
                        <xsl:value-of select="/elml:lesson/@label"/>
                        <xsl:text>_</xsl:text>
                        <xsl:text>glossary</xsl:text>
                        <xsl:value-of select="$filename_suffix"/>
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="generate-id(/elml:lesson/elml:glossary/elml:definition[@term=$termid])"/>
                    </xsl:attribute>
                    <xsl:call-template name="elml:tooltipAttribute">
                        <xsl:with-param name="termid" select="$termid"/>
                    </xsl:call-template>
                    <xsl:if test="not($layout='none')">
                        <img src="../../../_templates/{$layout}/icons/term.{$icon_filetype}" width="12" height="10" alt="term" class="term_icon"/>
                    </xsl:if>
                    <xsl:value-of select="$term"/>
                </a>
                <xsl:call-template name="elml:LayoutTooltip"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:tooltipAttribute">
        <xsl:param name="termid"/>
        <xsl:variable name="apos">&#39;</xsl:variable>
        <xsl:attribute name="onmouseover">
            <xsl:text>Tip('</xsl:text>
            <xsl:choose>
                <xsl:when test="@feedback">
                    <xsl:value-of select="translate(translate(@feedback,&quot;&#xA;&quot;,&quot;&quot;),&quot;&apos;&quot;, &quot;&quot;&quot;&quot;)"/>
                    <xsl:text>')</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="translate(translate(/elml:lesson/elml:glossary/elml:definition[@term=$termid],&quot;&#xA;&quot;,&quot;&quot;),&quot;&apos;&quot;, &quot;&quot;&quot;&quot;)"/>
                    <xsl:text>', TITLE, '</xsl:text>
                    <xsl:value-of select="/elml:lesson/elml:glossary/elml:definition[@term=$termid]/@term"/>
                    <xsl:text>')</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="onmouseout">
            <xsl:text>UnTip()</xsl:text>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="elml:annotation">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <div class="annotation">
                <xsl:call-template name="elml:Label"/>
                <xsl:apply-templates/>
            </div>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:paragraph">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:call-template name="elml:Title"/>
            <xsl:if test="@icon and not($layout='none')">
                <img src="../../../_templates/{$layout}/icons/{@icon}.{$icon_filetype}" title="{@icon}" alt="{@icon}" class="icon"/>
            </xsl:if>
            <p>
                <xsl:call-template name="elml:CSS_Class"/>
                <xsl:if test="@title">
                    <xsl:attribute name="title">
                        <xsl:value-of select="@title"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:call-template name="elml:Label"/>
                <xsl:apply-templates/>
            </p>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:newLine">
        <xsl:choose>
            <xsl:when test="$css_framework='yaml' and @space='long'">
                <br/>
                <br/>
            </xsl:when>
            <xsl:when test="$css_framework='yaml'">
                <br/>
            </xsl:when>
            <xsl:when test="@space='long'">
                <br clear="all"/>
                <br clear="all"/>
            </xsl:when>
            <xsl:otherwise>
                <br clear="all"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:link">
        <xsl:param name="label" select="@targetLabel"/>
        <xsl:param name="target_lesson_file">
            <xsl:choose>
                <xsl:when test="@targetLesson and not(@targetLesson = /elml:lesson/@label)">
                    <xsl:value-of select="substring-before(base-uri(), /elml:lesson/@label)"/>
                    <xsl:value-of select="@targetLesson"/>
                    <xsl:text>/</xsl:text>
                    <xsl:choose>
                        <xsl:when test="@targetLessonLang">
                            <xsl:value-of select="@targetLessonLang"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$lang"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>/text/</xsl:text>
                    <xsl:value-of select="@targetLesson"/>
                    <xsl:text>.xml</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>none</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="link_title">
            <xsl:value-of select="@size"/>
            <xsl:if test="@size and (@legend or @type)">
                <xsl:text> - </xsl:text>
            </xsl:if>
            <xsl:value-of select="@legend"/>
            <xsl:if test="@type and @legend">
                <xsl:text> - </xsl:text>
            </xsl:if>
            <xsl:if test="@type">
                <xsl:text>Filetype: </xsl:text>
            </xsl:if>
            <xsl:value-of select="@type"/>
        </xsl:param>
        <xsl:param name="TempURL">
            <xsl:choose>
                <xsl:when test="not((@role='student') or (@role=$role) or (not (@role)))">
                    <xsl:text>none</xsl:text>
                </xsl:when>
                <xsl:when test="@uri">
                    <xsl:if test="@cssClass='lightwindow'and starts-with(@uri, '..')">
                        <xsl:value-of select="$server"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="/elml:lesson/@label"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$lang"/>
                        <xsl:text>/html/</xsl:text>
                    </xsl:if>
                    <xsl:value-of select="@uri"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="not($target_lesson_file='none')">
                            <xsl:variable name="target_lesson_html">
                                <xsl:text>../../../</xsl:text>
                                <xsl:value-of select="@targetLesson"/>
                                <xsl:text>/</xsl:text>
                                <xsl:choose>
                                    <xsl:when test="@targetLessonLang">
                                        <xsl:value-of select="@targetLessonLang"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$lang"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:text>/html/</xsl:text>
                            </xsl:variable>
                            <xsl:choose>
                                <xsl:when test="not($pagebreak_level='unit') and not($pagebreak_level='lo')">
                                    <xsl:value-of select="$target_lesson_html"/>
                                    <xsl:text>index</xsl:text>
                                </xsl:when>
                                <xsl:when test="doc-available($target_lesson_file) and @targetLabel">
                                    <xsl:value-of select="$target_lesson_html"/>
                                    <xsl:choose>
                                        <xsl:when test="document($target_lesson_file)/elml:lesson/elml:unit[@label=$label]">
                                            <xsl:text>unit_</xsl:text>
                                            <xsl:value-of select="@targetLabel"/>
                                        </xsl:when>
                                        <xsl:when test="document($target_lesson_file)/elml:lesson/*[@label=$label]">
                                            <xsl:value-of select="@targetLesson"/>
                                            <xsl:text>_</xsl:text>
                                            <xsl:value-of select="@targetLabel"/>
                                        </xsl:when>
                                        <xsl:when test="$pagebreak_level='unit' and document($target_lesson_file)//*[@label=$label]/ancestor::node()[name()='unit'][1]/@label">
                                            <xsl:text>unit_</xsl:text>
                                            <xsl:value-of select="document($target_lesson_file)//*[@label=$label]/ancestor::node()[name()='unit'][1]/@label"/>
                                        </xsl:when>
                                        <xsl:when test="$pagebreak_level='lo' and document($target_lesson_file)/elml:lesson/elml:unit/*[@label=$label]">
                                            <xsl:value-of select="document($target_lesson_file)//*[@label=$label]/../@label"/>
                                            <xsl:text>_</xsl:text>
                                            <xsl:value-of select="@targetLabel"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>index</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$target_lesson_html"/>
                                    <xsl:text>index</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="not($pagebreak_level='unit') and not($pagebreak_level='lo')">
                            <xsl:text>index</xsl:text>
                        </xsl:when>
                        <xsl:when test="(name(//*[@label=$label])='unit') and (($pagebreak_level='unit') or ($pagebreak_level='lo'))">
                            <xsl:text>unit_</xsl:text>
                            <xsl:value-of select="@targetLabel"/>
                        </xsl:when>
                        <xsl:when test="(name(//*[@label=$label])='learningObject' or name(//*[@label=$label])='summary' or name(//*[@label=$label])='selfAssessment') and ($pagebreak_level='lo')">
                            <xsl:value-of select="//*[@label=$label]/../@label"/>
                            <xsl:text>_</xsl:text>
                            <xsl:value-of select="@targetLabel"/>
                        </xsl:when>
                        <xsl:when test="$pagebreak_level='lo'">
                            <xsl:choose>
                                <xsl:when test="//*[@label=$label]/ancestor::node()/name()='learningObject'">
                                    <xsl:value-of select="//*[@label=$label]/ancestor::node()[name()='unit']/@label"/>
                                    <xsl:text>_</xsl:text>
                                    <xsl:choose>
                                        <xsl:when test="//*[@label=$label]/ancestor::node()[name()='learningObject']/@label">
                                            <xsl:value-of select="//*[@label=$label]/ancestor::node()[name()='learningObject']/@label"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>learningObject</xsl:text>
                                            <xsl:value-of select="1+count(//*[@label=$label]/ancestor::node()[name()='learningObject']/preceding-sibling::node()[name()='learningObject']/name())"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="//*[@label=$label]/ancestor::node()/name()='selfAssessment'">
                                    <xsl:choose>
                                        <xsl:when test="//*[@label=$label]/ancestor::node()/name()='unit'">
                                            <xsl:value-of select="//*[@label=$label]/ancestor::node()[name()='unit']/@label"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="/elml:lesson/@label"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text>_</xsl:text>
                                    <xsl:choose>
                                        <xsl:when test="//*[@label=$label]/ancestor::node()[name()='selfAssessment']/@label">
                                            <xsl:value-of select="//*[@label=$label]/ancestor::node()[name()='selfAssessment']/@label"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>selfAssessment</xsl:text>
                                            <xsl:value-of select="1+count(//*[@label=$label]/ancestor::node()[name()='selfAssessment']/preceding-sibling::node()[name()='learningObject']/name())+count(//*[@label=$label]/ancestor::node()[name()='selfAssessment']/preceding-sibling::node()[name()='selfAssessment']/name())"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="//*[@label=$label]/ancestor::node()/name()='summary'">
                                    <xsl:choose>
                                        <xsl:when test="//*[@label=$label]/ancestor::node()/name()='unit'">
                                            <xsl:value-of select="//*[@label=$label]/ancestor::node()[name()='unit']/@label"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="/elml:lesson/@label"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text>_</xsl:text>
                                    <xsl:choose>
                                        <xsl:when test="//*[@label=$label]/ancestor::node()[name()='summary']/@label">
                                            <xsl:value-of select="//*[@label=$label]/ancestor::node()[name()='summary']/@label"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>summary</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="//*[@label=$label]/ancestor::node()/name()='entry'">
                                    <xsl:choose>
                                        <xsl:when test="//*[@label=$label]/ancestor::node()/name()='unit'">
                                            <xsl:text>unit_</xsl:text>
                                            <xsl:value-of select="//*[@label=$label]/ancestor::node()[name()='unit']/@label"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>index</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>index</xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$pagebreak_level='unit'">
                            <xsl:choose>
                                <xsl:when test="//*[@label=$label]/ancestor::node()[name()='unit'][1]/@label">
                                    <xsl:text>unit_</xsl:text>
                                    <xsl:value-of select="//*[@label=$label]/ancestor::node()[name()='unit'][1]/@label"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>index</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>index</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of select="$filename_suffix"/>
                    <xsl:choose>
                        <xsl:when test="@targetLabel and $target_lesson_file='none'">
                            <xsl:choose>
                                <xsl:when test="$pagebreak_level='lo'">
                                    <xsl:if test="not(//*[@label=$label]/name()='lesson' or //*[@label=$label]/name()='unit' or //*[@label=$label]/name()='learningObject' or //*[@label=$label]/name()='selfAssessment' or //*[@label=$label]/name()='summary')">
                                        <xsl:text>#</xsl:text>
                                        <xsl:value-of select="//*[@label=$label]/../@label"/>
                                        <xsl:text>_</xsl:text>
                                        <xsl:value-of select="@targetLabel"/>
                                        <xsl:value-of select="$filename_suffix"/>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:when test="$pagebreak_level='unit'">
                                    <xsl:if test="not(//*[@label=$label]/name()='lesson' or //*[@label=$label]/parent::node()/name()='lesson')">
                                        <xsl:text>#</xsl:text>
                                        <xsl:value-of select="//*[@label=$label]/../@label"/>
                                        <xsl:text>_</xsl:text>
                                        <xsl:value-of select="@targetLabel"/>
                                        <xsl:value-of select="$filename_suffix"/>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>#</xsl:text>
                                    <xsl:choose>
                                        <xsl:when test="name(//*[@label=$label])='unit'">
                                            <xsl:text>unit_</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="//*[@label=$label]/../@label"/>
                                            <xsl:text>_</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:value-of select="@targetLabel"/>
                                    <xsl:value-of select="$filename_suffix"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$pagebreak_level='unit' and document($target_lesson_file)//*[@label=$label]/ancestor::node()[name()='unit'][1]/@label">
                            <xsl:text>#</xsl:text>
                            <xsl:value-of select="document($target_lesson_file)//*[@label=$label]/../@label"/>
                            <xsl:text>_</xsl:text>
                            <xsl:value-of select="@targetLabel"/>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="inline">
            <xsl:call-template name="elml:inline"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="($inline='no') and not(name(preceding-sibling::*[1])='link') and not(name(following-sibling::*[1])='link')">
                <p>
                    <xsl:call-template name="elml:CSS_Class"/>
                    <xsl:if test="@icon and not($layout='none')">
                        <img src="../../../_templates/{$layout}/icons/{@icon}.{$icon_filetype}" title="{@icon}" alt="{@icon}" class="icon"/>
                    </xsl:if>
                    <xsl:element name="a">
                        <xsl:call-template name="elml:CSS_Class"/>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$TempURL"/>
                        </xsl:attribute>
                        <xsl:if test="starts-with($TempURL, 'http') or ends-with($TempURL, '.pdf') or @target">
                            <xsl:attribute name="target">
                                <xsl:choose>
                                    <xsl:when test="@target">
                                        <xsl:value-of select="@target"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>_blank</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:attribute name="title">
                            <xsl:value-of select="$link_title"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                    <xsl:if test="@size or @type or @legend">
                        <xsl:text> [</xsl:text>
                        <xsl:value-of select="$link_title"/>
                        <xsl:text>] </xsl:text>
                    </xsl:if>
                </p>
            </xsl:when>
            <xsl:when test="$inline='no'">
                <xsl:if test="not(name(preceding-sibling::*[1])='link')">
                    <xsl:call-template name="elml:tableOpen"/>
                </xsl:if>
                <tr>
                    <xsl:if test="@icon and not($layout='none')">
                        <td align="left" valign="top">
                            <img src="../../../_templates/{$layout}/icons/{@icon}.{$icon_filetype}" title="{@icon}" alt="{@icon}" class="icon"/>
                        </td>
                    </xsl:if>
                    <td align="justify" valign="top">
                        <xsl:if test="not(@icon) or $layout='none'">
                            <xsl:attribute name="colspan">2</xsl:attribute>
                        </xsl:if>
                        <xsl:choose>
                            <xsl:when test="$TempURL='none'">
                                <xsl:apply-templates/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:element name="a">
                                    <xsl:call-template name="elml:CSS_Class"/>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="$TempURL"/>
                                    </xsl:attribute>
                                    <xsl:if test="starts-with($TempURL, 'http') or ends-with($TempURL, '.pdf') or @target">
                                        <xsl:attribute name="target">
                                            <xsl:choose>
                                                <xsl:when test="starts-with($TempURL, 'http') or ends-with($TempURL, '.pdf')">
                                                    <xsl:text>_blank</xsl:text>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="@target"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="title">
                                        <xsl:value-of select="$link_title"/>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                    <td align="right" valign="top">
                        <xsl:if test="@size">
                            <xsl:value-of select="@size"/>
                        </xsl:if>
                    </td>
                    <td align="left" valign="top">
                        <xsl:if test="@type">
                            <xsl:value-of select="@type"/>
                        </xsl:if>
                    </td>
                    <td align="justify" valign="top">
                        <xsl:if test="@legend">
                            <xsl:value-of select="@legend"/>
                        </xsl:if>
                    </td>
                </tr>
                <xsl:if test="not(name(following-sibling::*[1])='link')">
                    <xsl:call-template name="elml:tableClose"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$TempURL='none'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="a">
                    <xsl:call-template name="elml:CSS_Class"/>
                    <xsl:attribute name="href">
                        <xsl:value-of select="$TempURL"/>
                    </xsl:attribute>
                    <xsl:if test="starts-with($TempURL, 'http') or ends-with($TempURL, '.pdf') or @target">
                        <xsl:attribute name="target">
                            <xsl:choose>
                                <xsl:when test="starts-with($TempURL, 'http') or ends-with($TempURL, '.pdf')">
                                    <xsl:text>_blank</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="@target"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@size or @type">
                        <xsl:attribute name="id">
                            <xsl:value-of select="$TempURL"/>
                            <xsl:value-of select="position()"/>
                        </xsl:attribute>
                        <xsl:attribute name="onmouseover">
                            <xsl:text>onInline('</xsl:text>
                            <xsl:value-of select="$TempURL"/>
                            <xsl:value-of select="position()"/>
                            <xsl:text>')</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="onmouseout">
                            <xsl:text>off('</xsl:text>
                            <xsl:value-of select="$TempURL"/>
                            <xsl:value-of select="position()"/>
                            <xsl:text>')</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:choose>
                        <xsl:when test="@size or @type or @legend">
                            <xsl:attribute name="title">
                                <xsl:value-of select="$link_title"/>
                            </xsl:attribute>
                            <xsl:attribute name="caption">
                                <xsl:value-of select="text()"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="title">
                                <xsl:value-of select="text()"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates/>
                </xsl:element>
                <xsl:if test="@size or @type or @legend">
                    <span style="display: none;">
                        <xsl:attribute name="id">
                            <xsl:value-of select="$TempURL"/>
                            <xsl:value-of select="position()"/>
                            <xsl:text>text</xsl:text>
                        </xsl:attribute>
                        <xsl:text> [</xsl:text>
                        <xsl:value-of select="$link_title"/>
                        <xsl:text>] </xsl:text>
                    </span>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:tableOpen"> &#xE001;table class="link_table"&#xE002; </xsl:template>
    <xsl:template name="elml:tableClose"> &#xE001;/table&#xE002; </xsl:template>
    <xsl:template match="elml:selfCheck">
        <xsl:param name="selfCheckLabel">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:call-template name="elml:Title"/>
        <div id="{$selfCheckLabel}">
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="count(descendant::elml:answer[@correct='yes'])=1">
                        <xsl:text>singleChoice</xsl:text>
                    </xsl:when>
                    <xsl:when test="count(descendant::elml:gapText)>0">
                        <xsl:text>fillInBlanks</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>multipleChoice</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="@shuffle='yes'">
                    <xsl:text>Shuffle</xsl:text>
                </xsl:if>
            </xsl:attribute>
            <xsl:apply-templates>
                <xsl:with-param name="selfCheckLabel" select="$selfCheckLabel"/>
            </xsl:apply-templates>
            <xsl:call-template name="elml:selfCheckButtons"/>
        </div>
        <xsl:if test="descendant::node()/@feedback">
            <xsl:call-template name="elml:LayoutTooltip"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:multipleChoice">
        <xsl:param name="selfCheckLabel"/>
        <xsl:apply-templates select="elml:question|elml:answer">
            <xsl:with-param name="selfCheckLabel" select="$selfCheckLabel"/>
        </xsl:apply-templates>
        <xsl:if test="count(descendant::elml:answer[@correct='yes'])>1">
            <div class="missingMC">
                <xsl:value-of select="$name_selfCheckMissing"/>
            </div>
        </xsl:if>
        <xsl:apply-templates select="elml:solution"/>
    </xsl:template>
    <xsl:template match="elml:fillInBlanks">
        <xsl:param name="selfCheckLabel"/>
        <xsl:apply-templates>
            <xsl:with-param name="selfCheckLabel" select="$selfCheckLabel"/>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="elml:question">
        <div class="itemQuestion">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="elml:answer">
        <xsl:param name="selfCheckLabel"/>
        <xsl:param name="inputType">
            <xsl:choose>
                <xsl:when test="count(../elml:answer[@correct='yes'])=1">
                    <xsl:text>radio</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>checkbox</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="correctStatus">
            <xsl:choose>
                <xsl:when test="@correct='yes'">
                    <xsl:text>1</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <div class="itemAnswer">
            <input type="{$inputType}" name="{$selfCheckLabel}" value="{$correctStatus}" class="itemRadio" id="{$selfCheckLabel}_{generate-id(.)}"/>
            <div class="itemLabel">
                <label for="{$selfCheckLabel}_{generate-id(.)}">
                    <xsl:apply-templates/>
                    <xsl:text> </xsl:text>
                    <span class="itemFeedback"/>
                </label>
            </div>
            <xsl:choose>
                <xsl:when test="@feedback!=''">
                    <div class="itemHelp">
                        <xsl:call-template name="elml:tooltipAttribute"/>
                        <xsl:text>?</xsl:text>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <div class="itemHelp_disabled">
                        <xsl:text disable-output-escaping="yes"><![CDATA[ &nbsp; ]]></xsl:text>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    <xsl:template match="elml:gapText">
        <xsl:param name="selfCheckLabel"/>
        <div class="itemAnswer">
            <div class="itemLabel">
                <xsl:apply-templates>
                    <xsl:with-param name="selfCheckLabel" select="$selfCheckLabel"/>
                </xsl:apply-templates>
            </div>
            <div class="itemHelp_disabled">
                <xsl:text disable-output-escaping="yes"><![CDATA[ &nbsp; ]]></xsl:text>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="elml:gap">
        <xsl:param name="selfCheckLabel"/>
        <input type="text" value="" class="itemText" id="{$selfCheckLabel}_{generate-id(.)}" size="{string-length(.)}"/>
        <span class="itemFeedback"/>
        <span class="gapText">
            <xsl:value-of select="."/>
            <xsl:if test="@answers!=''">
                <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:value-of select="@answers"/>
        </span>
    </xsl:template>
    <xsl:template match="elml:solution">
        <div class="itemSolution">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template name="elml:selfCheckButtons">
        <xsl:param name="selfCheckLabel">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:param name="selfCheckFunction">
            <xsl:choose>
                <xsl:when test="count(descendant::elml:gapText)>0">
                    <xsl:text>Gaps</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>Choice</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <div class="itemCheck">
            <button type="submit" class="buttonCheck" onclick="check{$selfCheckFunction}('{$selfCheckLabel}');" onMouseOver="this.className='buttonCheck_hover';" onMouseOut="this.className='buttonCheck';">
                <xsl:value-of select="$name_selfCheckCorrect"/>
            </button>
            <button type="submit" class="buttonSolution_disabled" id="{$selfCheckLabel}_solution" onclick="solution{$selfCheckFunction}('{$selfCheckLabel}');" onMouseOver="this.className='buttonSolution_hover';" onMouseOut="this.className='buttonSolution';" disabled="true">
                <xsl:value-of select="$name_selfCheckSolve"/>
            </button>
        </div>
    </xsl:template>
    <xsl:template match="*|processing-instruction()" mode="copy">
        <xsl:choose>
            <xsl:when test="local-name()='php'">
                <xsl:processing-instruction name="{local-name()}">
                    <xsl:value-of select="."/>
                </xsl:processing-instruction>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="{local-name()}">
                    <!-- process attributes -->
                    <xsl:for-each select="@*">
                        <!-- remove attribute prefix (if any) -->
                        <xsl:attribute name="{local-name()}">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:apply-templates mode="copy"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:citation">
        <xsl:param name="inline">
            <xsl:call-template name="elml:inline"/>
        </xsl:param>
        <xsl:if test="@icon and $inline='no' and not($layout='none')">
            <img src="../../../_templates/{$layout}/icons/{@icon}.{$icon_filetype}" title="{@icon}" alt="{@icon}" class="icon"/>
        </xsl:if>
        <span>
            <xsl:call-template name="elml:CSS_Class"/>
            <xsl:choose>
                <xsl:when test="not(node())">
                    <xsl:call-template name="elml:BibliographyRef"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="$inline='no'">
                            <xsl:attribute name="style">display:block; padding-bottom: 1em;</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="style">display:inline</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="@yearOnly='yes'">
                            <xsl:call-template name="elml:BibliographyRef"/>
                            <xsl:text> &quot;</xsl:text>
                            <i>
                                <xsl:apply-templates/>
                            </i>
                            <xsl:text>&quot;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>&quot;</xsl:text>
                            <i>
                                <xsl:apply-templates/>
                            </i>
                            <xsl:text>&quot;</xsl:text>
                            <xsl:call-template name="elml:BibliographyRef"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template match="elml:indexItem">
        <span>
            <xsl:attribute name="id">
                <xsl:value-of select="generate-id()"/>
            </xsl:attribute>
            <xsl:call-template name="elml:CSS_Class"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="elml:toc">
        <xsl:param name="recurse">
            <xsl:choose>
                <xsl:when test="@recurse">
                    <xsl:value-of select="@recurse"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'no'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <ul class="toc">
            <xsl:choose>
                <xsl:when test="@scope='lessons' and $multiple='on'">
                    <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                        <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson" mode="toc">
                            <xsl:with-param name="recurse" select="$recurse"/>
                        </xsl:apply-templates>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when test="@scope='unit'">
                    <xsl:apply-templates select="ancestor::node()[name()='unit']/*" mode="toc">
                        <xsl:with-param name="recurse" select="$recurse"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:when test="@scope='learningObject' and ancestor::node()[name()='learningObject']/*/@title">
                    <xsl:apply-templates select="ancestor::node()[name()='learningObject']/*[@title]" mode="toc">
                        <xsl:with-param name="recurse" select="$recurse"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="/elml:lesson/*" mode="toc">
                        <xsl:with-param name="recurse" select="$recurse"/>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
        </ul>
    </xsl:template>
    <xsl:template match="elml:lesson | elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata | elml:clarify | elml:look | elml:act" mode="toc">
        <xsl:param name="recurse"/>
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <li class="navigationLink">
                <xsl:call-template name="elml:nav_item_link">
                    <xsl:with-param name="isnavigation">toc</xsl:with-param>
                </xsl:call-template>
                <xsl:if test="$recurse='yes' and (name()='lesson' or name()='unit' or name()='learningObject')">
                    <ul class="toc">
                        <xsl:apply-templates select="*[@title]" mode="toc">
                            <xsl:with-param name="recurse" select="'no'"/>
                        </xsl:apply-templates>
                    </ul>
                </xsl:if>
            </li>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:entry | elml:goals" mode="toc"/>
    <!-- ***** General Functions used in various templates *****-->
    <xsl:template name="elml:display">
        <xsl:choose>
            <xsl:when test="((@role='student') or (@role=$role) or (not (@role))) and not(@visible='print') and not(@visible='none')">
                <xsl:text>yes</xsl:text>
            </xsl:when>
            <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:next_file">
        <xsl:param name="Label_param_temp">
            <xsl:choose>
                <xsl:when test="$pagebreak_level='lesson'">
                    <xsl:text>none</xsl:text>
                </xsl:when>
                <xsl:when test="name(.)='lesson'">
                    <xsl:text>unit_</xsl:text>
                    <xsl:value-of select="elml:unit[1]/@label"/>
                </xsl:when>
                <xsl:when test="not(following::*[1]) and ($pagebreak_level='unit' or ($pagebreak_level='lo' and not(name(.)='unit')))">
                    <xsl:text>none</xsl:text>
                </xsl:when>
                <xsl:when test="name(.)='index'">
                    <xsl:choose>
                        <xsl:when test="/elml:lesson/elml:metadata and ($role='tutor' or /elml:lesson/elml:metadata/@role=$role or not(/elml:lesson/elml:metadata/@role)) and not(/elml:lesson/elml:metadata/@visible='none') and not(/elml:lesson/elml:metadata/@visible='print')">
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:text>_</xsl:text>
                            <xsl:text>metadata</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>none</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="name(.)='bibliography'">
                    <xsl:choose>
                        <xsl:when test="/elml:lesson/elml:index and not(/elml:lesson/elml:index/@visible='none') and not(/elml:lesson/elml:index/@visible='print')">
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:text>_</xsl:text>
                            <xsl:text>index</xsl:text>
                        </xsl:when>
                        <xsl:when test="/elml:lesson/elml:metadata and ($role='tutor' or /elml:lesson/elml:metadata/@role=$role or not(/elml:lesson/elml:metadata/@role)) and not(/elml:lesson/elml:metadata/@visible='none') and not(/elml:lesson/elml:metadata/@visible='print')">
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:text>_</xsl:text>
                            <xsl:text>metadata</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>none</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="name(.)='metadata'">
                    <xsl:text>none</xsl:text>
                </xsl:when>
                <xsl:when test="not(following-sibling::*[1]) and (name(parent::*)='lesson') and (name(.)='bibliography' or name(.)='glossary' or name(.)='furtherReading' or name(.)='summary' or name(.)='selfAssessment' or name(.)='listOfFigures' or name(.)='listOfTables' or name(.)='index')">
                    <xsl:text>none</xsl:text>
                </xsl:when>
                <xsl:when test="$pagebreak_level='unit'">
                    <xsl:choose>
                        <xsl:when test="name(following-sibling::*[1]) = 'unit' and (not(following-sibling::*[1]/@role) or following-sibling::*[1]/@role=$role or following-sibling::*[1]/@role='student')">
                            <xsl:text>unit</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="../@label"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>_</xsl:text>
                    <xsl:choose>
                        <xsl:when test="following-sibling::*[1]/@visible='none' or following-sibling::*[1]/@visible='print' or (following-sibling::*[1]/@role and not(following-sibling::*[1]/@role=$role or following-sibling::*[1]/@role='student'))">
                            <xsl:value-of select="name(following-sibling::*[2])"/>
                            <xsl:if test="name(following-sibling::*[2])='selfAssessment'">
                                <xsl:text>1</xsl:text>
                            </xsl:if>
                        </xsl:when>
                        <xsl:when test="following-sibling::*[1]/@label">
                            <xsl:value-of select="following-sibling::*[1]/@label"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="name(following-sibling::*[1])"/>
                            <xsl:if test="name(following-sibling::*[1])='selfAssessment'">
                                <xsl:number value="count(preceding-sibling::*[name(.)='selfAssessment'])+count(self::*[name(.)='selfAssessment'])+1"/>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$pagebreak_level='lo'">
                    <xsl:choose>
                        <xsl:when test="name(.)='unit'">
                            <xsl:value-of select="@label"/>
                        </xsl:when>
                        <xsl:when test="not(following-sibling::*[1]) and (name(parent::*/following-sibling::*[1])='unit' and (parent::*/following-sibling::*[1]/@role=$role or parent::*/following-sibling::*[1]/@role='student' or not(parent::*/following-sibling::*[1]/@role)))">
                            <xsl:text>unit</xsl:text>
                        </xsl:when>
                        <xsl:when test="not(following-sibling::*[1])">
                            <xsl:value-of select="/elml:lesson/@label"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="../@label"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>_</xsl:text>
                    <xsl:choose>
                        <xsl:when test="name(.)='unit'">
                            <xsl:choose>
                                <xsl:when test="elml:learningObject[1]/@label">
                                    <xsl:value-of select="elml:learningObject[1]/@label"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>learningObject1</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="following-sibling::*[1]/@label">
                            <xsl:value-of select="following-sibling::*[1]/@label"/>
                        </xsl:when>
                        <xsl:when test="name(following-sibling::*[1])='selfAssessment'">
                            <xsl:value-of select="name(following-sibling::*[1])"/>
                            <xsl:number value="count(preceding-sibling::*[name(.)='learningObject'])+count(self::*[name(.)='learningObject'])+count(preceding-sibling::*[name(.)='selfAssessment'])+count(self::*[name(.)='selfAssessment'])+1"/>
                        </xsl:when>
                        <xsl:when test="name(following-sibling::*[1])='learningObject'">
                            <xsl:value-of select="name(following-sibling::*[1])"/>
                            <xsl:number value="count(preceding-sibling::*[name(.)='learningObject'])+count(self::*[name(.)='learningObject'])+1"/>
                        </xsl:when>
                        <xsl:when test="not(following-sibling::*[1])">
                            <xsl:choose>
                                <xsl:when test="parent::*/following-sibling::*[1]/@role and not(parent::*/following-sibling::*[1]/@role=$role or parent::*/following-sibling::*[1]/@role='student')">
                                    <xsl:value-of select="name(parent::*/following-sibling::*[2])"/>
                                    <xsl:if test="name(parent::*/following-sibling::*[2])='selfAssessment'">
                                        <xsl:text>1</xsl:text>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:when test="parent::*/following-sibling::*[1]/@label">
                                    <xsl:value-of select="parent::*/following-sibling::*[1]/@label"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="name(parent::*/following-sibling::*[1])"/>
                                    <xsl:if test="name(parent::*/following-sibling::*[1])='selfAssessment'">
                                        <xsl:text>1</xsl:text>
                                    </xsl:if>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="name(following-sibling::*[1])"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
            <xsl:value-of select="$filename_suffix"/>
        </xsl:param>
        <xsl:value-of select="string(concat($Label_param_temp[1],$Label_param_temp[2],$Label_param_temp[3],$Label_param_temp[4],$Label_param_temp[5],$Label_param_temp[6],$Label_param_temp[7],$Label_param_temp[8],$Label_param_temp[9],$Label_param_temp[10],$Label_param_temp[11],$Label_param_temp[12]))"/>
    </xsl:template>
    <xsl:template name="elml:prev_file">
        <xsl:param name="Label_param_temp">
            <xsl:choose>
                <xsl:when test="name(.)='lesson'">
                    <xsl:text>none</xsl:text>
                </xsl:when>
                <xsl:when test="(name(.)='unit') and (name(preceding-sibling::*[1])='goals' or name(preceding-sibling::*[1])='entry' or (preceding-sibling::*[1]/@role and not(preceding-sibling::*[1]/@role=$role or preceding-sibling::*[1]/@role='student')))">
                    <xsl:text>index</xsl:text>
                </xsl:when>
                <xsl:when test="$pagebreak_level='unit'">
                    <xsl:choose>
                        <xsl:when test="name(preceding-sibling::*[1]) = 'unit'">
                            <xsl:text>unit</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="../@label"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>_</xsl:text>
                    <xsl:choose>
                        <xsl:when test="preceding-sibling::*[1]/@role and not(preceding-sibling::*[1]/@role=$role or preceding-sibling::*[1]/@role='student')">
                            <xsl:value-of select="preceding-sibling::*[2]/@label"/>
                        </xsl:when>
                        <xsl:when test="preceding-sibling::*[1]/@label">
                            <xsl:value-of select="preceding-sibling::*[1]/@label"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="name(preceding-sibling::*[1])"/>
                            <xsl:if test="name(preceding-sibling::*[1])='selfAssessment' or name(preceding-sibling::*[1])='learningObject'">
                                <xsl:number value="count(preceding-sibling::*[name(.)='selfAssessment'])"/>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$pagebreak_level='lo'">
                    <xsl:choose>
                        <xsl:when test="(name(preceding-sibling::*[1]) = 'entry') or (name(preceding-sibling::*[1]) = 'goals') or not(preceding-sibling::*[1])">
                            <xsl:text>unit</xsl:text>
                        </xsl:when>
                        <xsl:when test="preceding-sibling::*[1]/@role and not(preceding-sibling::*[1]/@role=$role or preceding-sibling::*[1]/@role='student')">
                            <xsl:value-of select="preceding-sibling::*[2]/@label"/>
                        </xsl:when>
                        <xsl:when test="name(preceding-sibling::*[1]) = 'unit'">
                            <xsl:value-of select="preceding-sibling::*[1]/@label"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="../@label"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>_</xsl:text>
                    <xsl:choose>
                        <xsl:when test="name(preceding-sibling::*[1])='unit'">
                            <xsl:choose>
                                <xsl:when test="preceding-sibling::*[1]/@role and not(preceding-sibling::*[1]/@role=$role or preceding-sibling::*[1]/@role='student')">
                                    <xsl:choose>
                                        <xsl:when test="preceding-sibling::*[2]/child::*[last()]/@label">
                                            <xsl:value-of select="preceding-sibling::*[2]/child::*[last()]/@label"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="name(preceding-sibling::*[2]/child::*[last()])"/>
                                            <xsl:if test="(name(preceding-sibling::*[2]/child::*[last()])='learningObject') or (name(preceding-sibling::*[2]/child::*[last()])='selfAssessment')">
                                                <xsl:number value="count(preceding-sibling::*[2]/child::*[name(.)='learningObject'])+count(preceding-sibling::*[2]/child::*[name(.)='selfAssessment'])"/>
                                            </xsl:if>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="preceding-sibling::*[1]/child::*[last()]/@label">
                                    <xsl:value-of select="preceding-sibling::*[1]/child::*[last()]/@label"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="name(preceding-sibling::*[1]/child::*[last()])"/>
                                    <xsl:if test="(name(preceding-sibling::*[1]/child::*[last()])='learningObject') or (name(preceding-sibling::*[1]/child::*[last()])='selfAssessment')">
                                        <xsl:number value="count(preceding-sibling::*[1]/child::*[name(.)='learningObject'])+count(preceding-sibling::*[1]/child::*[name(.)='selfAssessment'])"/>
                                    </xsl:if>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="(name(preceding-sibling::*[1]) = 'entry') or (name(preceding-sibling::*[1]) = 'goals') or not(preceding-sibling::*[1])">
                            <xsl:value-of select="../@label"/>
                        </xsl:when>
                        <xsl:when test="preceding-sibling::*[1]/@label">
                            <xsl:value-of select="preceding-sibling::*[1]/@label"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="name(preceding-sibling::*[1])"/>
                            <xsl:if test="name(preceding-sibling::*[1])='selfAssessment' or name(preceding-sibling::*[1])='learningObject'">
                                <xsl:number value="count(preceding-sibling::*[name(.)='learningObject'])+count(preceding-sibling::*[name(.)='selfAssessment'])"/>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
            <xsl:value-of select="$filename_suffix"/>
        </xsl:param>
        <xsl:value-of select="string(concat($Label_param_temp[1],$Label_param_temp[2],$Label_param_temp[3],$Label_param_temp[4],$Label_param_temp[5],$Label_param_temp[6],$Label_param_temp[7],$Label_param_temp[8],$Label_param_temp[9],$Label_param_temp[10],$Label_param_temp[11],$Label_param_temp[12]))"/>
    </xsl:template>
    <xsl:template name="elml:Label_param">
        <xsl:param name="Label_param_temp">
            <xsl:choose>
                <xsl:when test="name(.)='selfCheck'">
                    <xsl:choose>
                        <xsl:when test="@label">
                            <xsl:value-of select="@label"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="name(.)"/>
                            <xsl:value-of select="position()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="name(.)='unit'">
                    <xsl:text>unit_</xsl:text>
                    <xsl:value-of select="@label"/>
                </xsl:when>
                <xsl:when test="name(.)='lesson'">
                    <xsl:text>index</xsl:text>
                </xsl:when>
                <xsl:when test="@label">
                    <xsl:value-of select="../@label"/>
                    <xsl:text>_</xsl:text>
                    <xsl:value-of select="@label"/>
                </xsl:when>
                <xsl:when test="name()='glossary'">
                    <xsl:value-of select="../@label"/>
                    <xsl:text>_</xsl:text>
                    <xsl:text>glossary</xsl:text>
                </xsl:when>
                <xsl:when test="name()='listOfFigures'">
                    <xsl:value-of select="../@label"/>
                    <xsl:text>_</xsl:text>
                    <xsl:text>listoffigures</xsl:text>
                </xsl:when>
                <xsl:when test="name()='listOfTables'">
                    <xsl:value-of select="../@label"/>
                    <xsl:text>_</xsl:text>
                    <xsl:text>listoftables</xsl:text>
                </xsl:when>
                <xsl:when test="name()='index'">
                    <xsl:value-of select="../@label"/>
                    <xsl:text>_</xsl:text>
                    <xsl:text>index</xsl:text>
                </xsl:when>
                <xsl:when test="name()='bibliography'">
                    <xsl:value-of select="../@label"/>
                    <xsl:text>_</xsl:text>
                    <xsl:text>bibliography</xsl:text>
                </xsl:when>
                <xsl:when test="name()='metadata'">
                    <xsl:value-of select="../@label"/>
                    <xsl:text>_</xsl:text>
                    <xsl:text>metadata</xsl:text>
                </xsl:when>
                <xsl:when test="name()='clarify' or name()='look' or name()='act' or name()='multimedia' or name()='table'">
                    <xsl:value-of select="generate-id()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="../@label"/>
                    <xsl:text>_</xsl:text>
                    <xsl:value-of select="name(.)"/>
                    <xsl:if test="name(.)='learningObject' or name(.)='selfAssessment'">
                        <xsl:number level="single" count="elml:selfAssessment | elml:learningObject"/>
                    </xsl:if>
                    <xsl:if test="name(.)='entry' and (preceding-sibling::node()[1]/name()='entry' or preceding-sibling::node()[2]/name()='entry')">
                        <xsl:number level="single" count="elml:entry"/>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="$filename_suffix"/>
        </xsl:param>
        <xsl:value-of select="string(concat($Label_param_temp[1],$Label_param_temp[2],$Label_param_temp[3],$Label_param_temp[4],$Label_param_temp[5],$Label_param_temp[6],$Label_param_temp[7],$Label_param_temp[8]))"/>
    </xsl:template>
    <xsl:template name="elml:Label_param_withfilename">
        <xsl:param name="Label_param_temp">
            <xsl:choose>
                <xsl:when test="(not($pagebreak_level='lesson') and not($pagebreak_level='unit') and not($pagebreak_level='lo')) or name(.)='clarify' or name(.)='look' or name(.)='act'">
                    <xsl:text>#</xsl:text>
                </xsl:when>
                <xsl:when test="$pagebreak_level='lesson'">
                    <xsl:text>index</xsl:text>
                    <xsl:value-of select="$filename_suffix"/>
                    <xsl:text>#</xsl:text>
                </xsl:when>
                <xsl:when test="(name(parent::*)='lesson') and (name(.)='entry')">
                    <xsl:text>index</xsl:text>
                    <xsl:value-of select="$filename_suffix"/>
                    <xsl:text>#</xsl:text>
                </xsl:when>
                <xsl:when test="(name(.)='entry') or (($pagebreak_level='unit') and (name(parent::*)='unit'))">
                    <xsl:text>unit_</xsl:text>
                    <xsl:value-of select="../@label"/>
                    <xsl:value-of select="$filename_suffix"/>
                    <xsl:text>#</xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:value-of select="string(concat($Label_param_temp[1],$Label_param_temp[2],$Label_param_temp[3],$Label_param_temp[4],$Label_param_temp[5],$Label_param_temp[6],$Label_param_temp[7],$Label_param_temp[8]))"/>
    </xsl:template>
    <xsl:template name="elml:Label">
        <xsl:attribute name="id">
            <xsl:choose>
                <xsl:when test="@label or name(.)='entry' or name(.)='goals' or name(.)='summary' or name(.)='furtherReading' or name(.)='learningObject' or name(.)='selfAssessment' or name(.)='bibliography' or name(.)='glossary' or name(.)='listOfFigures' or name(.)='listOfTables' or name(.)='index' or name(.)='metadata' or name(.)='clarify' or name(.)='look' or name(.)='act'">
                    <xsl:call-template name="elml:Label_param"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="generate-id()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>
    <xsl:template name="elml:Legend_listof">
        <xsl:choose>
            <xsl:when test="@title and @legend">
                <xsl:value-of select="@title"/>
                <xsl:text>: </xsl:text>
                <xsl:value-of select="@legend"/>
            </xsl:when>
            <xsl:when test="@legend">
                <xsl:value-of select="@legend"/>
            </xsl:when>
            <xsl:when test="@title">
                <xsl:value-of select="@title"/>
            </xsl:when>
            <xsl:when test="@src">
                <xsl:value-of select="tokenize(@src,'/')[last()]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$name_nolegend"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- ***** Multimedia Functions used for the multimedia Element *****-->
    <xsl:template name="Icon">
        <xsl:param name="icon"/>
        <img src="../../../_templates/{$layout}/icons/{$icon}.{$icon_filetype}" title="{$icon}" alt="{$icon}" class="icon" style="padding-right:1.5em"/>
    </xsl:template>
    <xsl:template name="elml:MultimediaShow">
        <xsl:param name="pathMultimedia">
            <xsl:choose>
                <xsl:when test="@thumbnail">
                    <xsl:value-of select="@thumbnail"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@src"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="pathMultimediaSource">
            <xsl:value-of select="@src"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="@thumbnail">
                <a href="{$pathMultimediaSource}" target="_blank">
                    <xsl:if test="$lightwindow='yes'">
                        <xsl:attribute name="class">
                            <xsl:text>lightwindow</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="rel">
                            <xsl:text>Gallery[</xsl:text>
                            <xsl:choose>
                                <xsl:when test="ancestor::node()[name()='learningObject']/@navTitle">
                                    <xsl:value-of select="ancestor::node()[name()='learningObject']/@navTitle"/>
                                </xsl:when>
                                <xsl:when test="ancestor::node()[name()='entry']/@navTitle">
                                    <xsl:value-of select="ancestor::node()[name()='entry']/@navTitle"/>
                                </xsl:when>
                                <xsl:when test="ancestor::node()[name()='summary']/@navTitle">
                                    <xsl:value-of select="ancestor::node()[name()='summary']/@navTitle"/>
                                </xsl:when>
                                <xsl:when test="ancestor::node()[name()='unit']/@navTitle">
                                    <xsl:value-of select="ancestor::node()[name()='unit']/@navTitle"/>
                                </xsl:when>
                                <xsl:when test="ancestor::node()[name()='lesson']/@navTitle">
                                    <xsl:value-of select="ancestor::node()[name()='lesson']/@navTitle"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>other</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:text>]</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@legend">
                        <xsl:attribute name="title">
                            <xsl:value-of select="@legend"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:call-template name="elml:Image">
                        <xsl:with-param name="pathMultimedia">
                            <xsl:value-of select="$pathMultimedia"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </a>
            </xsl:when>
            <xsl:when test="@type">
                <xsl:choose>
                    <xsl:when test="@type='gif' or @type='jpeg' or @type='png'">
                        <xsl:call-template name="elml:Image">
                            <xsl:with-param name="pathMultimedia">
                                <xsl:value-of select="$pathMultimedia"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="@type='flash'">
                        <xsl:call-template name="elml:Flash">
                            <xsl:with-param name="pathMultimedia">
                                <xsl:value-of select="$pathMultimedia"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="@type='quicktime'">
                        <xsl:call-template name="elml:Quicktime">
                            <xsl:with-param name="pathMultimedia">
                                <xsl:value-of select="$pathMultimedia"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="@type='mpeg'">
                        <xsl:call-template name="elml:MPEG">
                            <xsl:with-param name="pathMultimedia">
                                <xsl:value-of select="$pathMultimedia"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="@type='mp3'">
                        <xsl:call-template name="elml:MP3">
                            <xsl:with-param name="pathMultimedia">
                                <xsl:value-of select="$pathMultimedia"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="@type='svg'">
                        <xsl:call-template name="elml:SVG">
                            <xsl:with-param name="pathMultimedia">
                                <xsl:value-of select="$pathMultimedia"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="@type='applet'">
                        <xsl:call-template name="elml:Applet">
                            <xsl:with-param name="pathMultimedia">
                                <xsl:value-of select="$pathMultimedia"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="@type='vrml'">
                        <xsl:call-template name="elml:VRML">
                            <xsl:with-param name="pathMultimedia">
                                <xsl:value-of select="$pathMultimedia"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="@type='x3d'">
                        <xsl:call-template name="elml:X3D">
                            <xsl:with-param name="pathMultimedia">
                                <xsl:value-of select="$pathMultimedia"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="@type='realone'">
                        <xsl:call-template name="elml:RealOne">
                            <xsl:with-param name="pathMultimedia">
                                <xsl:value-of select="$pathMultimedia"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="@type='mathml' and @src">
                        <xsl:choose>
                            <xsl:when test="starts-with(@src, 'http')">
                                <xsl:copy-of select="document(@src)/*"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:copy-of select="document(concat(elml:get_pathHTML(base-uri(),/elml:lesson/@label),@src))/*"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="@type='mathml'">
                        <xsl:copy-of select="child::*"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:Applet">
        <xsl:param name="pathMultimedia"/>
        <applet>
            <xsl:call-template name="elml:Label"/>
            <xsl:attribute name="codebase">
                <xsl:value-of select="substring-before($pathMultimedia, (tokenize($pathMultimedia,'/')[last()]))"/>
            </xsl:attribute>
            <xsl:attribute name="code">
                <xsl:value-of select="tokenize($pathMultimedia,'/')[last()]"/>
            </xsl:attribute>
            <xsl:call-template name="elml:MultimediaAttributes"/>
            <xsl:attribute name="alt">
                <xsl:value-of select="@legend"/>
            </xsl:attribute>
        </applet>
    </xsl:template>
    <!-- ***** IMA/SCORM Manifest File *****-->
    <xsl:template name="elml:manifest">
        <xsl:param name="pathRoot">
            <xsl:choose>
                <xsl:when test="contains(base-uri(), '\')">
                    <xsl:value-of select="substring-before(base-uri(), concat('\', /elml:lesson/@label))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring-before(base-uri(), concat('/', /elml:lesson/@label))"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="contains(base-uri(), '\')">
                <xsl:choose>
                    <xsl:when test="$manifest_type = 'both'">
                        <xsl:result-document href="{$pathRoot}\imsmanifests\scorm\imsmanifest_{/elml:lesson/@label}.xml" format="manifest">
                            <xsl:call-template name="elml:manifest_scorm"/>
                        </xsl:result-document>
                        <xsl:result-document href="{$pathRoot}\imsmanifests\ims\imsmanifest_{/elml:lesson/@label}.xml" format="manifest">
                            <xsl:call-template name="elml:manifest_ims"/>
                        </xsl:result-document>
                    </xsl:when>
                    <xsl:when test="$manifest_type = 'scorm'">
                        <xsl:result-document href="{$pathRoot}\imsmanifest.xml" format="manifest">
                            <xsl:call-template name="elml:manifest_scorm"/>
                        </xsl:result-document>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:result-document href="{$pathRoot}\imsmanifest.xml" format="manifest">
                            <xsl:call-template name="elml:manifest_ims"/>
                        </xsl:result-document>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$manifest_type = 'both'">
                        <xsl:result-document href="{$pathRoot}/imsmanifests/scorm/imsmanifest_{/elml:lesson/@label}.xml" format="manifest">
                            <xsl:call-template name="elml:manifest_scorm"/>
                        </xsl:result-document>
                        <xsl:result-document href="{$pathRoot}/imsmanifests/ims/imsmanifest_{/elml:lesson/@label}.xml" format="manifest">
                            <xsl:call-template name="elml:manifest_ims"/>
                        </xsl:result-document>
                    </xsl:when>
                    <xsl:when test="$manifest_type = 'scorm'">
                        <xsl:result-document href="{$pathRoot}/imsmanifest.xml" format="manifest">
                            <xsl:call-template name="elml:manifest_scorm"/>
                        </xsl:result-document>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:result-document href="{$pathRoot}/imsmanifest.xml" format="manifest">
                            <xsl:call-template name="elml:manifest_ims"/>
                        </xsl:result-document>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- ***** SCORM Content Package Manifest File *****-->
    <xsl:template name="elml:manifest_scorm">
        <xsl:param name="lessonlabel">
            <xsl:value-of select="/elml:lesson/attribute::label"/>
        </xsl:param>
        <manifest xmlns="http://www.imsproject.org/xsd/imscp_rootv1p1p2" xmlns:adlcp="http://www.adlnet.org/xsd/adlcp_rootv1p2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" identifier="MANIFEST-{/elml:lesson/@label}" version="ADL SCORM CP 1.2" xsi:schemaLocation="http://www.imsproject.org/xsd/imscp_rootv1p1p2 {$lessonlabel}{substring-after(elml:get_pathHTML(base-uri(),/elml:lesson/@label),/elml:lesson/attribute::label)}imscp_rootv1p1p2.xsd http://www.imsglobal.org/xsd/imsmd_rootv1p2p1  {$lessonlabel}{substring-after(elml:get_pathHTML(base-uri(),/elml:lesson/@label),/elml:lesson/attribute::label)}imsmd_rootv1p2p1.xsd http://www.adlnet.org/xsd/adlcp_rootv1p2 {$lessonlabel}{substring-after(elml:get_pathHTML(base-uri(),/elml:lesson/@label),/elml:lesson/attribute::label)}adlcp_rootv1p2.xsd">
            <metadata>
                <schema>ADL SCORM</schema>
                <schemaversion>1.2</schemaversion>
                <xsl:call-template name="elml:ims_metadata"/>
            </metadata>
            <organizations>
                <organization>
                    <xsl:attribute name="identifier">
                        <xsl:value-of select="/elml:lesson/@label"/>
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="document($config_file)/elml:config/elml:modules/elml:course/@title">
                            <xsl:element name="title">
                                <xsl:value-of select="document($config_file)/elml:config/elml:modules/elml:course/@title"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <title>
                                <xsl:value-of select="/elml:lesson/@title"/>
                            </title>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="$multiple='on'">
                            <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                                <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson" mode="manifest_org"/>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="/elml:lesson" mode="manifest_org"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </organization>
            </organizations>
            <resources>
                <xsl:choose>
                    <xsl:when test="$multiple='on'">
                        <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                            <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson" mode="manifest_res"/>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="/elml:lesson" mode="manifest_res"/>
                    </xsl:otherwise>
                </xsl:choose>
            </resources>
        </manifest>
    </xsl:template>
    <!-- ***** IMS Content Package Manifest File *****-->
    <xsl:template name="elml:manifest_ims">
        <manifest xmlns="http://www.imsproject.org/xsd/imscp_rootv1p1p2" xmlns:imsmd="http://www.imsglobal.org/xsd/imsmd_v1p2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" identifier="MANIFEST-{/elml:lesson/@label}" version="IMS CP 1.1">
            <xsl:attribute name="xsi:schemaLocation">http://www.imsproject.org/xsd/imscp_rootv1p1p2 http://www.imsproject.org/xsd/imscp_rootv1p1p2.xsd http://www.imsglobal.org/xsd/imsmd_v1p2 http://www.imsglobal.org/xsd/imsmd_v1p2p4.xsd</xsl:attribute>
            <metadata>
                <schema>IMS CONTENT</schema>
                <schemaversion>1.2.4</schemaversion>
                <xsl:call-template name="elml:ims_metadata"/>
            </metadata>
            <organizations>
                <organization>
                    <xsl:attribute name="identifier">
                        <xsl:value-of select="/elml:lesson/@label"/>
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="document($config_file)/elml:config/elml:modules/elml:course/@title">
                            <xsl:element name="title">
                                <xsl:value-of select="document($config_file)/elml:config/elml:modules/elml:course/@title"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <title>
                                <xsl:value-of select="/elml:lesson/@title"/>
                            </title>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="$multiple='on'">
                            <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                                <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson" mode="manifest_org"/>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="/elml:lesson" mode="manifest_org"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </organization>
            </organizations>
            <resources>
                <xsl:choose>
                    <xsl:when test="$multiple='on'">
                        <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                            <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson" mode="manifest_res"/>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="/elml:lesson" mode="manifest_res"/>
                    </xsl:otherwise>
                </xsl:choose>
            </resources>
        </manifest>
    </xsl:template>
    <xsl:template match="elml:lesson | elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="manifest_org">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <item xmlns="http://www.imsproject.org/xsd/imscp_rootv1p1p2">
                <xsl:attribute name="identifier">ITEM-<xsl:value-of select="generate-id()"/>
                </xsl:attribute>
                <xsl:attribute name="identifierref">RES-<xsl:value-of select="generate-id()"/>
                </xsl:attribute>
                <title>
                    <xsl:call-template name="elml:Kapitel">
                        <xsl:with-param name="isnavigation">yes</xsl:with-param>
                    </xsl:call-template>
                </title>
                <xsl:apply-templates select="elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="manifest_org"/>
            </item>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:lesson | elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="manifest_res">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:param name="manifest_filename">
            <xsl:call-template name="elml:Label_param_withfilename"/>
        </xsl:param>
        <xsl:param name="adlc_scormtype"> </xsl:param>
        <xsl:choose>
            <xsl:when test="$manifest_type = 'scorm'">
                <xsl:if test="$display='yes'">
                    <resource xmlns="http://www.imsproject.org/xsd/imscp_rootv1p1p2">
                        <xsl:attribute name="identifier">RES-<xsl:value-of select="generate-id()"/>
                        </xsl:attribute>
                        <xsl:attribute name="type">webcontent</xsl:attribute>
                        <xsl:attribute namespace="http://www.adlnet.org/xsd/adlcp_rootv1p2" name="scormtype">sco</xsl:attribute>
                        <xsl:attribute name="href"><xsl:value-of select="/elml:lesson/@label"/>/<xsl:value-of select="$lang"/>/html/<xsl:choose>
                                <xsl:when test="contains($manifest_filename, '#')">
                                    <xsl:value-of select="substring-before($manifest_filename, '#')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$manifest_filename"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <file>
                            <xsl:attribute name="href"><xsl:value-of select="/elml:lesson/@label"/>/<xsl:value-of select="$lang"/>/html/<xsl:choose>
                                    <xsl:when test="contains($manifest_filename, '#')">
                                        <xsl:value-of select="substring-before($manifest_filename, '#')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$manifest_filename"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                        </file>
                        <dependency>
                            <xsl:attribute name="identifierref">ALLRESOURCES</xsl:attribute>
                        </dependency>
                    </resource>
                    <xsl:apply-templates select="elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="manifest_res"/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="$display='yes'">
                    <resource xmlns="http://www.imsproject.org/xsd/imscp_rootv1p1p2">
                        <xsl:attribute name="identifier">RES-<xsl:value-of select="generate-id()"/>
                        </xsl:attribute>
                        <xsl:attribute name="type">webcontent</xsl:attribute>
                        <xsl:attribute name="href"><xsl:value-of select="/elml:lesson/@label"/>/<xsl:value-of select="$lang"/>/html/<xsl:choose>
                                <xsl:when test="contains($manifest_filename, '#')">
                                    <xsl:choose>
                                        <xsl:when test="contains(substring-before($manifest_filename, '#'), 'index')">
                                            <xsl:choose>
                                                <xsl:when test="substring-before($manifest_filename, '#') eq concat('index', $filename_suffix)">
                                                    <xsl:value-of select="substring-before($manifest_filename, '#')"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="concat(substring-before(substring-before($manifest_filename, '#'), 'index.'), $filename_suffix)"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="substring-before($manifest_filename, '#')"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$manifest_filename"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </resource>
                    <xsl:apply-templates select="elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="manifest_res"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- ***** IMS Meta-data *****-->
    <!-- ***** IMS Meta-data *****-->
    <xsl:template name="elml:ims_metadata">
        <lom xmlns="http://www.imsglobal.org/xsd/imsmd_rootv1p2p1">
            <general>
                <identifier>metadata-<xsl:value-of select="/elml:lesson/@label"/>
                </identifier>
                <title>
                    <langstring>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="$lang"/>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="document($config_file)/elml:config/elml:modules/elml:course/@title">
                                <xsl:value-of select="document($config_file)/elml:config/elml:modules/elml:course/@title"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="/elml:lesson/@title"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </langstring>
                </title>
                <language>
                    <xsl:value-of select="$lang"/>
                </language>
                <description>
                    <langstring>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="$lang"/>
                        </xsl:attribute>
                        <xsl:text>See summary within the lesson for a description of the content. </xsl:text>
                    </langstring>
                </description>
                <xsl:for-each select="/elml:lesson/elml:metadata/elml:keywords/elml:keywordItem">
                    <keyword>
                        <langstring>
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="$lang"/>
                            </xsl:attribute>
                            <xsl:value-of select="."/>
                        </langstring>
                    </keyword>
                </xsl:for-each>
                <xsl:for-each select="/elml:lesson/elml:glossary/elml:definition">
                    <keyword>
                        <langstring>
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="$lang"/>
                            </xsl:attribute>
                            <xsl:value-of select="@term"/>
                        </langstring>
                    </keyword>
                </xsl:for-each>
                <structure>
                    <source>
                        <langstring xml:lang="x-none">LOMv1.0</langstring>
                    </source>
                    <value>
                        <langstring xml:lang="x-none">Linear</langstring>
                    </value>
                </structure>
                <aggregationlevel>
                    <source>
                        <langstring xml:lang="x-none">LOMv1.0</langstring>
                    </source>
                    <value>
                        <langstring xml:lang="x-none">3</langstring>
                    </value>
                </aggregationlevel>
            </general>
            <lifecycle>
                <version>
                    <langstring>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="$lang"/>
                        </xsl:attribute>
                        <xsl:value-of select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:version"/>
                        <xsl:text> (created: </xsl:text>
                        <xsl:value-of select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:version/@creationDate"/>
                        <xsl:text>/modified: </xsl:text>
                        <xsl:value-of select="day-from-date(current-date())"/>
                        <xsl:text>.</xsl:text>
                        <xsl:value-of select="month-from-date(current-date())"/>
                        <xsl:text>.</xsl:text>
                        <xsl:value-of select="year-from-date(current-date())"/>
                        <xsl:text>)</xsl:text>
                    </langstring>
                </version>
                <xsl:if test="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:commentsNextVersion">
                    <status>
                        <source>
                            <langstring>
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="$lang"/>
                                </xsl:attribute>
                                <xsl:text>eLML description</xsl:text>
                            </langstring>
                        </source>
                        <value>
                            <langstring>
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="$lang"/>
                                </xsl:attribute>
                                <xsl:value-of select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:commentsNextVersion"/>
                            </langstring>
                        </value>
                    </status>
                </xsl:if>
                <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:contribute/elml:person">
                    <contribute>
                        <role>
                            <source>
                                <langstring>
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="$lang"/>
                                    </xsl:attribute>
                                    <xsl:text>eLML description</xsl:text>
                                </langstring>
                            </source>
                            <value>
                                <langstring>
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="$lang"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="@responsible"/>: <xsl:value-of select="."/>
                                </langstring>
                            </value>
                        </role>
                        <centity>
                            <vcard> BEGIN:VCARD N;CHARSET=UTF-8:<xsl:value-of select="substring-after(@name, ' ')"/>;<xsl:value-of select="substring-before(@name, ' ')"/>;;; FN;CHARSET=UTF-8:<xsl:value-of select="@name"/> ORG:<xsl:value-of select="@institute"/>; <xsl:value-of select="@departement"/> EMAIL;INTERNET:<xsl:value-of select="@email"/> END:VCARD </vcard>
                        </centity>
                    </contribute>
                </xsl:for-each>
            </lifecycle>
            <metametadata>
                <metadatascheme>LOMv1.0</metadatascheme>
                <language>en</language>
            </metametadata>
            <technical>
                <xsl:choose>
                    <xsl:when test="$manifest_type = 'scorm'">
                        <format>ADL SCORM v1.2 Reader</format>
                    </xsl:when>
                    <xsl:otherwise>
                        <format>IMS CP v1.1.3 Reader</format>
                    </xsl:otherwise>
                </xsl:choose>
                <format>text/html</format>
                <xsl:if test="//elml:multimedia/@type='gif'">
                    <format>image/gif</format>
                </xsl:if>
                <xsl:if test="//elml:multimedia/@type='jpeg'">
                    <format>image/jpeg</format>
                </xsl:if>
                <xsl:if test="//elml:multimedia/@type='png'">
                    <format>image/png</format>
                </xsl:if>
                <xsl:if test="//elml:multimedia/@type='flash'">
                    <format>application/x-shockwave-flash</format>
                </xsl:if>
                <xsl:if test="//elml:multimedia/@type='quicktime'">
                    <format>video/quicktime</format>
                </xsl:if>
                <xsl:if test="//elml:multimedia/@type='mpeg'">
                    <format>video/mpeg</format>
                </xsl:if>
                <xsl:if test="//elml:multimedia/@type='mp3'">
                    <format>audio/mpeg</format>
                </xsl:if>
                <xsl:if test="//elml:multimedia/@type='realone'">
                    <format>audio/x-realaudio</format>
                </xsl:if>
                <xsl:if test="//elml:multimedia/@type='svg'">
                    <format>image/svg+xml</format>
                </xsl:if>
                <xsl:if test="//elml:multimedia/@type='applet'">
                    <format>application/x-java-applet</format>
                </xsl:if>
                <xsl:if test="//elml:multimedia/@type='vrml'">
                    <format>x-world/x-vrml</format>
                </xsl:if>
                <xsl:if test="//elml:multimedia/@type='x3d'">
                    <format>model/x3d+xml</format>
                </xsl:if>
                <size>0</size>
                <location type="URI">
                    <xsl:value-of select="$server"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="/elml:lesson/@label"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$lang"/>
                </location>
                <requirement>
                    <type>
                        <source>
                            <langstring xml:lang="x-none">LOMv1.0</langstring>
                        </source>
                        <value>
                            <langstring xml:lang="x-none">Operating System</langstring>
                        </value>
                    </type>
                    <name>
                        <source>
                            <langstring xml:lang="x-none">LOMv1.0</langstring>
                        </source>
                        <value>
                            <langstring xml:lang="x-none">Multi-OS</langstring>
                        </value>
                    </name>
                </requirement>
                <requirement>
                    <type>
                        <source>
                            <langstring xml:lang="x-none">LOMv1.0</langstring>
                        </source>
                        <value>
                            <langstring xml:lang="x-none">Browser</langstring>
                        </value>
                    </type>
                    <name>
                        <source>
                            <langstring xml:lang="x-none">LOMv1.0</langstring>
                        </source>
                        <value>
                            <langstring xml:lang="x-none">Any</langstring>
                        </value>
                    </name>
                    <minimumversion>XHTML 1.0 Compatible, including Flash Plugin</minimumversion>
                </requirement>
                <xsl:for-each select="/elml:lesson/elml:metadata/elml:technical/elml:technicalRequirement">
                    <xsl:if test="not(type='OS') and not(type='OS')">
                        <requirement>
                            <type>
                                <source>
                                    <langstring xml:lang="x-none">LOMv1.0</langstring>
                                </source>
                                <value>
                                    <langstring xml:lang="x-none">
                                        <xsl:choose>
                                            <xsl:when test="type='PlugIn'">Plugin</xsl:when>
                                            <xsl:when test="type='Software'">Application</xsl:when>
                                            <xsl:otherwise>None</xsl:otherwise>
                                        </xsl:choose>
                                    </langstring>
                                </value>
                            </type>
                            <name>
                                <source>
                                    <langstring xml:lang="x-none">LOMv1.0</langstring>
                                </source>
                                <value>
                                    <langstring xml:lang="x-none">
                                        <xsl:value-of select="elml:name"/>
                                    </langstring>
                                </value>
                            </name>
                            <minimumversion>
                                <xsl:value-of select="elml:minimumVersion"/>
                            </minimumversion>
                        </requirement>
                    </xsl:if>
                </xsl:for-each>
                <installationremarks>
                    <langstring>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="$lang"/>
                        </xsl:attribute>
                        <xsl:value-of select="/elml:lesson/elml:metadata/elml:technical/elml:technicalRequirement/elml:installationRemarks"/>
                    </langstring>
                </installationremarks>
            </technical>
            <educational>
                <interactivitytype>
                    <source>
                        <langstring xml:lang="x-none">LOMv1.0</langstring>
                    </source>
                    <value>
                        <langstring xml:lang="x-none">Mixed</langstring>
                    </value>
                </interactivitytype>
                <learningresourcetype>
                    <source>
                        <langstring xml:lang="x-none">LOMv1.0</langstring>
                    </source>
                    <value>
                        <langstring xml:lang="x-none">IMS</langstring>
                    </value>
                </learningresourcetype>
                <intendedenduserrole>
                    <source>
                        <langstring xml:lang="x-none">LOMv1.0</langstring>
                    </source>
                    <value>
                        <langstring xml:lang="x-none">Learner</langstring>
                    </value>
                </intendedenduserrole>
                <context>
                    <source>
                        <langstring xml:lang="x-none">LOMv1.0</langstring>
                    </source>
                    <value>
                        <langstring xml:lang="x-none">Higher Education</langstring>
                    </value>
                </context>
                <typicalagerange>
                    <langstring xml:lang="en">18-99</langstring>
                </typicalagerange>
                <difficulty>
                    <source>
                        <langstring xml:lang="x-none">LOMv1.0</langstring>
                    </source>
                    <value>
                        <langstring xml:lang="x-none">
                            <xsl:value-of select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:educational/elml:difficulty"/>
                        </langstring>
                    </value>
                </difficulty>
                <typicallearningtime>
                    <datetime>
                        <xsl:value-of select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:educational/elml:typicalLearningTime/elml:time"/>
                    </datetime>
                </typicallearningtime>
                <description>
                    <langstring>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="$lang"/>
                        </xsl:attribute>
                        <xsl:value-of select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:educational/elml:typicalLearningTime/elml:description"/>
                    </langstring>
                </description>
                <language>
                    <xsl:value-of select="$lang"/>
                </language>
            </educational>
            <rights>
                <cost>
                    <source>
                        <langstring xml:lang="x-none">LOMv1.0</langstring>
                    </source>
                    <value>
                        <langstring xml:lang="x-none">
                            <xsl:value-of select="/elml:lesson/elml:metadata/elml:rights/elml:cost"/>
                        </langstring>
                    </value>
                </cost>
                <copyrightandotherrestrictions>
                    <source>
                        <langstring xml:lang="x-none">LOMv1.0</langstring>
                    </source>
                    <value>
                        <langstring xml:lang="x-none">yes</langstring>
                    </value>
                </copyrightandotherrestrictions>
                <description>
                    <langstring>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="$lang"/>
                        </xsl:attribute>
                        <xsl:value-of select="/elml:lesson/elml:metadata/elml:rights/elml:copyright"/>
                        <xsl:if test="/elml:lesson/elml:metadata/elml:rights/elml:description"> (<xsl:value-of select="/elml:lesson/elml:metadata/elml:rights/elml:description"/>)</xsl:if>
                    </langstring>
                </description>
            </rights>
            <xsl:if test="/elml:lesson/elml:metadata/elml:organisation/elml:creationPosition/elml:previous">
                <relation>
                    <kind>
                        <source>
                            <langstring xml:lang="x-none">LOMv1.0</langstring>
                        </source>
                        <value>
                            <langstring xml:lang="x-none">IsBasedOn</langstring>
                        </value>
                    </kind>
                    <resource>
                        <identifier>
                            <xsl:value-of select="/elml:lesson/elml:metadata/elml:organisation/elml:creationPosition/elml:previous"/>
                        </identifier>
                        <description>
                            <langstring xml:lang="en">
                                <xsl:text>This lessons previous lesson is: </xsl:text>
                                <xsl:value-of select="/elml:lesson/elml:metadata/elml:organisation/elml:creationPosition/elml:previous"/>
                            </langstring>
                        </description>
                        <catalogentry>
                            <catalog>eLML lesson</catalog>
                            <entry>
                                <langstring xml:lang="en">
                                    <xsl:value-of select="/elml:lesson/elml:metadata/elml:organisation/elml:creationPosition/elml:previous"/>
                                </langstring>
                            </entry>
                        </catalogentry>
                    </resource>
                </relation>
            </xsl:if>
            <xsl:if test="/elml:lesson/elml:metadata/elml:organisation/elml:creationPosition/elml:following">
                <relation>
                    <kind>
                        <source>
                            <langstring xml:lang="x-none">LOMv1.0</langstring>
                        </source>
                        <value>
                            <langstring xml:lang="x-none">IsBasisFor</langstring>
                        </value>
                    </kind>
                    <resource>
                        <identifier>
                            <xsl:value-of select="/elml:lesson/elml:metadata/elml:organisation/elml:creationPosition/elml:following"/>
                        </identifier>
                        <description>
                            <langstring xml:lang="en">
                                <xsl:text>This lessons is followed by lesson: </xsl:text>
                                <xsl:value-of select="/elml:lesson/elml:metadata/elml:organisation/elml:creationPosition/elml:following"/>
                            </langstring>
                        </description>
                        <catalogentry>
                            <catalog>eLML lesson</catalog>
                            <entry>
                                <langstring xml:lang="en">
                                    <xsl:value-of select="/elml:lesson/elml:metadata/elml:organisation/elml:creationPosition/elml:following"/>
                                </langstring>
                            </entry>
                        </catalogentry>
                    </resource>
                </relation>
            </xsl:if>
            <xsl:for-each select="/elml:lesson/elml:metadata/elml:prerequisites/elml:preReqItem">
                <xsl:if test="not(@label='none')">
                    <relation>
                        <kind>
                            <source>
                                <langstring xml:lang="x-none">LOMv1.0</langstring>
                            </source>
                            <value>
                                <langstring xml:lang="x-none">Requires</langstring>
                            </value>
                        </kind>
                        <resource>
                            <identifier>
                                <xsl:value-of select="@label"/>
                            </identifier>
                            <description>
                                <langstring xml:lang="en">
                                    <xsl:text>This lessons requires lesson: </xsl:text>
                                    <xsl:value-of select="@label"/>
                                    <xsl:if test="@priority"> (<xsl:value-of select="@priority"/>) </xsl:if>
                                    <xsl:value-of select="."/>
                                </langstring>
                            </description>
                            <catalogentry>
                                <catalog>eLML lesson</catalog>
                                <entry>
                                    <langstring xml:lang="en">
                                        <xsl:value-of select="@label"/>
                                    </langstring>
                                </entry>
                            </catalogentry>
                        </resource>
                    </relation>
                </xsl:if>
            </xsl:for-each>
            <classification>
                <purpose>
                    <source>
                        <langstring xml:lang="x-none">LOMv1.0</langstring>
                    </source>
                    <value>
                        <langstring xml:lang="x-none">Discipline</langstring>
                    </value>
                </purpose>
                <taxonpath>
                    <source>
                        <langstring xml:lang="x-none">eLML</langstring>
                    </source>
                    <taxon>
                        <entry>
                            <langstring xml:lang="x-none">
                                <xsl:value-of select="/elml:lesson/elml:metadata/elml:organisation/@level"/>
                                <xsl:value-of>
                                    <xsl:text> </xsl:text>
                                </xsl:value-of>
                                <xsl:value-of select="/elml:lesson/elml:metadata/elml:organisation/@module"/>
                                <xsl:value-of>
                                    <xsl:text> </xsl:text>
                                </xsl:value-of>
                                <xsl:value-of select="/elml:lesson/@label"/>
                            </langstring>
                        </entry>
                    </taxon>
                </taxonpath>
            </classification>
        </lom>
    </xsl:template>
    <!-- ***** Create a sitemap for searcheninges like Google etc. *****-->
    <xsl:template name="elml:sitemap">
        <xsl:param name="pathRoot">
            <xsl:choose>
                <xsl:when test="contains(base-uri(), '\')">
                    <xsl:value-of select="substring-before(base-uri(), concat('\', /elml:lesson/@label))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring-before(base-uri(), concat('/', /elml:lesson/@label))"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="contains(base-uri(), '\')">
                <xsl:result-document href="{$pathRoot}\sitemap.xml" format="manifest">
                    <xsl:call-template name="elml:sitemap_content"/>
                </xsl:result-document>
            </xsl:when>
            <xsl:otherwise>
                <xsl:result-document href="{$pathRoot}/sitemap.xml" format="manifest">
                    <xsl:call-template name="elml:sitemap_content"/>
                </xsl:result-document>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:sitemap_content">
        <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <xsl:attribute name="xsi:schemaLocation">http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd</xsl:attribute>
            <xsl:choose>
                <xsl:when test="$multiple='on'">
                    <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                        <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson" mode="sitemap"/>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="/elml:lesson" mode="sitemap"/>
                </xsl:otherwise>
            </xsl:choose>
        </urlset>
    </xsl:template>
    <xsl:template match="elml:lesson | elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="sitemap">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:param name="filename">
            <xsl:call-template name="elml:Label_param_withfilename"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <url xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
                <loc>
                    <xsl:value-of select="$server"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="/elml:lesson/@label"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$lang"/>
                    <xsl:text>/html/</xsl:text>
                    <xsl:choose>
                        <xsl:when test="contains($filename, '#')">
                            <xsl:choose>
                                <xsl:when test="contains(substring-before($filename, '#'), 'index')">
                                    <xsl:choose>
                                        <xsl:when test="substring-before($filename, '#') eq concat('index', $filename_suffix)">
                                            <xsl:value-of select="substring-before($filename, '#')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="concat(substring-before(substring-before($filename, '#'), 'index.'), $filename_suffix)"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="substring-before($filename, '#')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$filename"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </loc>
                <lastmod>
                    <xsl:value-of select="current-dateTime()"/>
                </lastmod>
                <changefreq>
                    <xsl:choose>
                        <xsl:when test="name()='lesson'">
                            <xsl:text>daily</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>weekly</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </changefreq>
                <priority>
                    <xsl:choose>
                        <xsl:when test="name()='lesson'">
                            <xsl:text>1.0</xsl:text>
                        </xsl:when>
                        <xsl:when test="@label='news'">
                            <xsl:text>0.9</xsl:text>
                        </xsl:when>
                        <xsl:when test="@label='download'">
                            <xsl:text>0.8</xsl:text>
                        </xsl:when>
                        <xsl:when test="@label='contact'">
                            <xsl:text>0.8</xsl:text>
                        </xsl:when>
                        <xsl:when test="@label='about'">
                            <xsl:text>0.7</xsl:text>
                        </xsl:when>
                        <xsl:when test="@label='archive'">
                            <xsl:text>0.1</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>0.5</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </priority>
            </url>
            <xsl:apply-templates select="elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="sitemap"/>
        </xsl:if>
    </xsl:template>
    <!-- ***** Navigation *****-->
    <xsl:template name="elml:navigation">
        <xsl:if test="$use_navigation='yes'">
            <a id="navigation_link" name="navigation_link"/>
            <!-- Skiplink-Anchor: Navigation -->
            <ul class="navigation">
                <xsl:attribute name="id">
                    <xsl:choose>
                        <xsl:when test="$css_framework='yaml'">
                            <xsl:text>submenu</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>nav_lesson</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:call-template name="elml:navigation_start"/>
            </ul>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:navigation_start">
        <xsl:param name="filename">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:param name="actual_lesson">
            <xsl:value-of select="/elml:lesson/@label"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$multiple='on'">
                <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                    <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson" mode="navigation_lesson">
                        <xsl:with-param name="filename" select="$filename"/>
                        <xsl:with-param name="actual_lesson" select="$actual_lesson"/>
                    </xsl:apply-templates>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="/elml:lesson" mode="navigation_lesson">
                    <xsl:with-param name="filename" select="$filename"/>
                    <xsl:with-param name="actual_lesson" select="$actual_lesson"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:lesson" mode="navigation_lesson">
        <xsl:param name="filename"/>
        <xsl:param name="actual_lesson"/>
        <xsl:param name="navact">
            <xsl:if test="($actual_lesson=/elml:lesson/@label) and ($filename = concat('index', $filename_suffix))">
                <xsl:text>_act</xsl:text>
            </xsl:if>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$css_framework='yaml'">
                <li id="title">
                    <xsl:call-template name="elml:nav_item_link">
                        <xsl:with-param name="filename" select="$filename"/>
                        <xsl:with-param name="navact" select="$navact"/>
                        <xsl:with-param name="isnavigation">yes</xsl:with-param>
                    </xsl:call-template>
                </li>
                <xsl:if test="(document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/@subnavigation='yes') or ($actual_lesson=/elml:lesson/@label)">
                    <xsl:apply-templates select="elml:unit | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="navigation_unit">
                        <xsl:with-param name="filename" select="$filename"/>
                    </xsl:apply-templates>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <li class="{elml:get_linkcssclass($navact)}">
                    <xsl:call-template name="elml:nav_item_link">
                        <xsl:with-param name="filename" select="$filename"/>
                        <xsl:with-param name="navact" select="$navact"/>
                        <xsl:with-param name="isnavigation">yes</xsl:with-param>
                    </xsl:call-template>
                    <xsl:if test="(document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/@subnavigation='yes') or ($actual_lesson=/elml:lesson/@label)">
                        <ul class="navigation" id="nav_unit">
                            <xsl:apply-templates select="elml:unit | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="navigation_unit">
                                <xsl:with-param name="filename" select="$filename"/>
                            </xsl:apply-templates>
                        </ul>
                    </xsl:if>
                </li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:unit | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="navigation_unit">
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
                <xsl:when test="(name(.)='entry') and ($filename = concat('index', $filename_suffix))">
                    <xsl:text>_act</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <li class="{elml:get_linkcssclass($navact)}">
                <xsl:call-template name="elml:nav_item_link">
                    <xsl:with-param name="filename" select="$filename"/>
                    <xsl:with-param name="navact" select="$navact"/>
                    <xsl:with-param name="isnavigation">yes</xsl:with-param>
                </xsl:call-template>
                <xsl:if test="(name(.)='unit') and (($pagebreak_level='unit') or ($pagebreak_level='lo')) and (($filename = $filenameactual) or contains($filename,@label))">
                    <ul class="navigation" id="nav_lo">
                        <xsl:apply-templates select="elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading " mode="navigation_lo">
                            <xsl:with-param name="filename" select="$filename"/>
                        </xsl:apply-templates>
                    </ul>
                </xsl:if>
            </li>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:entry | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading" mode="navigation_lo">
        <xsl:param name="filename"/>
        <xsl:param name="filenameactual">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:param name="navact">
            <xsl:choose>
                <xsl:when test="$filename = $filenameactual">
                    <xsl:text>_act</xsl:text>
                </xsl:when>
                <xsl:when test="(name(.)='entry') and ($filename = concat('unit_',parent::elml:unit/@label,$filename_suffix)) and ($pagebreak_level='lo')">
                    <xsl:text>_act</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <li class="{elml:get_linkcssclass($navact)}">
            <xsl:call-template name="elml:nav_item_link">
                <xsl:with-param name="filename" select="$filename"/>
                <xsl:with-param name="navact" select="$navact"/>
                <xsl:with-param name="isnavigation">yes</xsl:with-param>
            </xsl:call-template>
        </li>
    </xsl:template>
    <!-- ***** Navigation Top Level (lessons if $multiple='on', else unit titles as list) *****-->
    <xsl:template name="elml:navigation_top">
        <xsl:param name="filename">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:param name="actual_lesson">
            <xsl:value-of select="/elml:lesson/@label"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$multiple='on'">
                <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                    <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson" mode="navigation_top">
                        <xsl:with-param name="filename" select="$filename"/>
                        <xsl:with-param name="actual_lesson" select="$actual_lesson"/>
                    </xsl:apply-templates>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="/elml:lesson/elml:*" mode="navigation_top">
                    <xsl:with-param name="filename" select="$filename"/>
                    <xsl:with-param name="actual_lesson" select="$actual_lesson"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:lesson" mode="navigation_top">
        <xsl:param name="filename"/>
        <xsl:param name="actual_lesson"/>
        <xsl:param name="navact">
            <xsl:if test="($actual_lesson=/elml:lesson/@label) and ($filename = concat('index', $filename_suffix))">
                <xsl:text>_act</xsl:text>
            </xsl:if>
        </xsl:param>
        <li class="{elml:get_linkcssclass($navact)}">
            <xsl:call-template name="elml:nav_item_link">
                <xsl:with-param name="filename" select="$filename"/>
                <xsl:with-param name="navact" select="$navact"/>
                <xsl:with-param name="actual_lesson" select="$actual_lesson"/>
                <xsl:with-param name="isnavigation">path_full</xsl:with-param>
            </xsl:call-template>
        </li>
    </xsl:template>
    <xsl:template match="elml:entry | elml:goals | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="navigation_top"/>
    <xsl:template match="elml:unit" mode="navigation_top">
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
                <xsl:when test="(name(.)='entry') and ($filename = concat('index', $filename_suffix))">
                    <xsl:text>_act</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <li class="{elml:get_linkcssclass($navact)}">
                <xsl:call-template name="elml:nav_item_link">
                    <xsl:with-param name="filename" select="$filename"/>
                    <xsl:with-param name="navact" select="$navact"/>
                    <xsl:with-param name="isnavigation">path_full</xsl:with-param>
                </xsl:call-template>
            </li>
        </xsl:if>
    </xsl:template>
    <!-- Templates needed for all kind of navigation -->
    <xsl:template name="elml:nav_item_link">
        <xsl:param name="navact"/>
        <xsl:param name="filename"/>
        <xsl:param name="isnavigation"/>
        <xsl:param name="actual_lesson"/>
        <xsl:param name="filenameactual">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$navact='_act' and (not($css_framework='yaml') or ($css_framework='yaml' and $isnavigation='yes'))">
                <strong>
                    <xsl:call-template name="elml:Kapitel">
                        <xsl:with-param name="isnavigation" select="$isnavigation"/>
                    </xsl:call-template>
                    <xsl:if test="contains($filenameactual, 'unit_') and contains($optional_units, substring-after(substring-before($filenameactual, $filename_suffix), 'unit_'))">
                        <xsl:value-of select="$name_optionalunits_symbol"/>
                    </xsl:if>
                </strong>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="$navact='_act' or (name='learningObject' and contains($filename, @label)) or ($multiple='on' and $actual_lesson=/elml:lesson/@label)">
                    <xsl:attribute name="id">
                        <xsl:text>current</xsl:text>
                    </xsl:attribute>
                </xsl:if>
                <a>
                    <xsl:attribute name="href">
                        <xsl:if test="$multiple='on'">
                            <xsl:text>../../../</xsl:text>
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:text>/</xsl:text>
                            <xsl:value-of select="$lang"/>
                            <xsl:text>/html/</xsl:text>
                        </xsl:if>
                        <xsl:if test="$isnavigation='toc' and $pagebreak_level='lo' and (name()='clarify' or name()='look' or name()='act')">
                            <xsl:value-of select="../../@label"/>
                            <xsl:text>_</xsl:text>
                            <xsl:choose>
                                <xsl:when test="../@label">
                                    <xsl:value-of select="../@label"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="name(..)"/>
                                    <xsl:if test="name(..)='learningObject'">
                                        <xsl:number level="single" count="elml:learningObject"/>
                                    </xsl:if>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:if>
                        <xsl:call-template name="elml:Label_param_withfilename"/>
                    </xsl:attribute>
                    <xsl:call-template name="elml:Kapitel">
                        <xsl:with-param name="isnavigation" select="$isnavigation"/>
                    </xsl:call-template>
                    <xsl:if test="contains($filenameactual, 'unit_') and contains($optional_units, substring-after(substring-before($filenameactual, $filename_suffix), 'unit_'))">
                        <xsl:value-of select="$name_optionalunits_symbol"/>
                    </xsl:if>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:Kapitel">
        <xsl:param name="isnavigation"/>
        <xsl:call-template name="elml:Kapitel_Number">
            <xsl:with-param name="isnavigation" select="$isnavigation"/>
        </xsl:call-template>
        <xsl:call-template name="elml:Kapitel_Title">
            <xsl:with-param name="isnavigation" select="$isnavigation"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="elml:Kapitel_Number">
        <xsl:param name="isnavigation"/>
        <xsl:param name="actual_lesson">
            <xsl:value-of select="/elml:lesson/@label"/>
        </xsl:param>
        <xsl:if test="not($isnavigation='path_full') and ($chapter_numeration='yes') and (not(name(.)='goals')) and (not(name(.)='clarify')) and (not(name(.)='look')) and (not(name(.)='act')) and not(name(.)='entry')">
            <xsl:choose>
                <xsl:when test="$multiple='on'">
                    <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                        <xsl:if test="text()=$actual_lesson">
                            <xsl:value-of select="position()"/>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:text>.</xsl:text>
                    <xsl:number level="multiple" count="elml:unit[(@role eq 'student') or (@role eq $role) or (not (@role))] | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary[not(@visible eq 'online') and not(@visible eq 'none')] | elml:listOfFigures[not(@visible eq 'online') and not(@visible eq 'none')] | elml:listOfTables[not(@visible eq 'online') and not(@visible eq 'none')] | elml:index[not(@visible eq 'online') and not(@visible eq 'none')] | elml:bibliography[not(@visible eq 'online') and not(@visible eq 'none')] | elml:metadata[not(@visible eq 'online') and not(@visible eq 'none')] | elml:learningObject"/>
                    <xsl:if test="name()='entry'">
                        <xsl:text>.0</xsl:text>
                    </xsl:if>
                    <xsl:text> </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:number level="multiple" count="elml:lesson | elml:unit[(@role eq 'student') or (@role eq $role) or (not (@role))] | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary[not(@visible eq 'online') and not(@visible eq 'none')] | elml:listOfFigures[not(@visible eq 'online') and not(@visible eq 'none')] | elml:listOfTables[not(@visible eq 'online') and not(@visible eq 'none')] | elml:index[not(@visible eq 'online') and not(@visible eq 'none')] | elml:bibliography[not(@visible eq 'online') and not(@visible eq 'none')] | elml:metadata[not(@visible eq 'online') and not(@visible eq 'none')] | elml:learningObject"/>
                    <xsl:if test="name()='entry'">
                        <xsl:text>.0</xsl:text>
                    </xsl:if>
                    <xsl:text>. </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:Kapitel_Title">
        <xsl:param name="isnavigation"/>
        <xsl:choose>
            <xsl:when test="(($isnavigation='yes') or ($isnavigation='path_full')) and (@navTitle)">
                <xsl:value-of select="@navTitle"/>
            </xsl:when>
            <xsl:when test="name()='entry' and $isnavigation='yes'">
                <xsl:value-of select="$name_entry"/>
            </xsl:when>
            <xsl:when test="@title">
                <xsl:value-of select="@title"/>
            </xsl:when>
            <xsl:when test="name()='glossary'">
                <xsl:value-of select="$name_glossary"/>
            </xsl:when>
            <xsl:when test="name()='listOfFigures'">
                <xsl:value-of select="$name_figures"/>
            </xsl:when>
            <xsl:when test="name()='listOfTables'">
                <xsl:value-of select="$name_tables"/>
            </xsl:when>
            <xsl:when test="name()='index'">
                <xsl:value-of select="$name_index"/>
            </xsl:when>
            <xsl:when test="name()='entry'">
                <xsl:value-of select="$name_entry"/>
            </xsl:when>
            <xsl:when test="name()='goals'">
                <xsl:value-of select="$name_lObjectives"/>
            </xsl:when>
            <xsl:when test="name()='summary'">
                <xsl:value-of select="$name_summary"/>
            </xsl:when>
            <xsl:when test="name()='selfAssessment'">
                <xsl:value-of select="$name_selfAssessment"/>
            </xsl:when>
            <xsl:when test="name()='bibliography'">
                <xsl:value-of select="$name_bibliography"/>
            </xsl:when>
            <xsl:when test="name()='furtherReading'">
                <xsl:value-of select="$name_furtherReading"/>
            </xsl:when>
            <xsl:when test="name()='metadata' and $isnavigation='yes'">
                <xsl:value-of select="$name_metadata"/>
            </xsl:when>
            <xsl:when test="name()='metadata'">
                <xsl:value-of select="$name_metadata"/>
                <xsl:text> "</xsl:text>
                <xsl:value-of select="/elml:lesson/@title"/>
                <xsl:text>"</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>An ERROR occurred, please contact the webmaster! </xsl:text>
                <xsl:value-of select="$contact"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:path_full">
        <a>
            <xsl:attribute name="href">
                <xsl:text>index</xsl:text>
                <xsl:value-of select="$filename_suffix"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="/elml:lesson/@navTitle">
                    <xsl:value-of select="/elml:lesson/@navTitle"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="/elml:lesson/@title"/>
                </xsl:otherwise>
            </xsl:choose>
        </a>
        <xsl:if test="name(parent::*)='unit'">
            <xsl:text>&#xE003;</xsl:text>
            <a>
                <xsl:attribute name="href">
                    <xsl:text>unit_</xsl:text>
                    <xsl:value-of select="parent::node()/@label"/>
                    <xsl:value-of select="$filename_suffix"/>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="parent::node()/@navTitle">
                        <xsl:value-of select="parent::node()/@navTitle"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="parent::node()/@title"/>
                    </xsl:otherwise>
                </xsl:choose>
            </a>
        </xsl:if>
        <xsl:if test="not(name()='lesson')">
            <xsl:text>&#xE003;</xsl:text>
            <a href="#top">
                <xsl:call-template name="elml:Kapitel">
                    <xsl:with-param name="isnavigation">path_full</xsl:with-param>
                </xsl:call-template>
            </a>
        </xsl:if>
    </xsl:template>
    <!-- ***** Footer (Please adapt the footer to your needs!) *****-->
    <xsl:template name="elml:footer">
        <p class="footer">
            <xsl:text> Update: </xsl:text>
            <xsl:value-of select="day-from-date(current-date())"/>
            <xsl:text>.</xsl:text>
            <xsl:value-of select="month-from-date(current-date())"/>
            <xsl:text>.</xsl:text>
            <xsl:value-of select="year-from-date(current-date())"/>
            <xsl:text> (</xsl:text>
            <a href="http://www.elml.org/" target="_blank">created with eLML</a>
            <xsl:text>) </xsl:text>
            <xsl:if test="not($bugtracker='')">
                <xsl:text> - </xsl:text>
                <a target="_blank">
                    <xsl:attribute name="href">
                        <xsl:value-of select="$bugtracker"/>
                    </xsl:attribute>
                    <xsl:value-of select="$name_bugtracker"/>
                </a>
            </xsl:if>
            <xsl:if test="not($contact='')">
                <xsl:text> - </xsl:text>
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>mailto:</xsl:text>
                        <xsl:value-of select="$contact"/>
                    </xsl:attribute>
                    <xsl:value-of select="$name_contact"/>
                </a>
            </xsl:if>
            <xsl:text> - </xsl:text>
            <a target="_blank">
                <xsl:attribute name="href">
                    <xsl:text>../text/</xsl:text>
                    <xsl:value-of select="/elml:lesson/@label"/>
                    <xsl:text>.pdf</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="$name_print"/>
                <xsl:text> (PDF)</xsl:text>
            </a>
            <xsl:text> - </xsl:text>
            <a>
                <xsl:attribute name="href">
                    <xsl:choose>
                        <xsl:when test="starts-with(/elml:lesson/elml:metadata/elml:rights/elml:copyrightURL, 'http')">
                            <xsl:value-of select="/elml:lesson/elml:metadata/elml:rights/elml:copyrightURL"/>
                        </xsl:when>
                        <xsl:when test="/elml:lesson/elml:metadata/elml:rights/elml:copyrightURL">
                            <xsl:value-of select="$server"/>
                            <xsl:text>/</xsl:text>
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:text>/</xsl:text>
                            <xsl:value-of select="$lang"/>
                            <xsl:text>/html/</xsl:text>
                            <xsl:value-of select="/elml:lesson/elml:metadata/elml:rights/elml:copyrightURL"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$server"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:text disable-output-escaping="no"> ©</xsl:text>
                <xsl:value-of select="/elml:lesson/elml:metadata/elml:rights/elml:copyright"/>
            </a>
        </p>
    </xsl:template>
</xsl:stylesheet>
