<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" version="2.0" xmlns:functx="http://www.functx.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    <!--Definition of parameters (if available values are taken from projects config file -->
    <!-- Automatically defined parameters -->
    <xsl:function name="functx:escape-for-regex" as="xs:string" xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:sequence select=" 
            replace($arg,
            '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
            "/>
    </xsl:function>
    <xsl:function name="functx:substring-before-last" as="xs:string" xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="delim" as="xs:string"/>
        <xsl:sequence select=" 
            if (matches($arg, functx:escape-for-regex($delim)))
            then replace($arg,
            concat('^(.*)', functx:escape-for-regex($delim),'.*'),
            '$1')
            else ''
            "/>
    </xsl:function>
    <xsl:param name="transformlesson_label" select="/elml:lesson/@label"/>
    <xsl:param name="config_file_default">
        <xsl:value-of select="'default_parameters.xml'"/>
    </xsl:param>
    <xsl:param name="config_file">
        <xsl:choose>
            <xsl:when test="doc-available(concat(substring-before(base-uri(), concat('/', /elml:lesson/@label)),'/_config/config.xml'))">
                <xsl:value-of select="concat(substring-before(base-uri(), concat('/', /elml:lesson/@label)),'/_config/config.xml')"/>
            </xsl:when>
            <xsl:when test="doc-available(concat(substring-before(base-uri(), concat('/', /elml:lesson/@label)),'/', /elml:lesson/@label,'/_config/config.xml'))">
                <xsl:value-of select="concat(substring-before(base-uri(), concat('/', /elml:lesson/@label)),'/', /elml:lesson/@label,'/_config/config.xml')"/>
            </xsl:when>
            <xsl:when test="doc-available(concat(substring-before(base-uri(), concat('\', /elml:lesson/@label)),'\_config\config.xml'))">
                <xsl:value-of select="concat(substring-before(base-uri(), concat('\', /elml:lesson/@label)),'\_config\config.xml')"/>
            </xsl:when>
            <xsl:when test="doc-available(concat(substring-before(base-uri(), concat('\', /elml:lesson/@label)),'\', /elml:lesson/@label,'\_config\config.xml'))">
                <xsl:value-of select="concat(substring-before(base-uri(), concat('\', /elml:lesson/@label)),'\', /elml:lesson/@label,'\_config\config.xml')"/>
            </xsl:when>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="pathRoot">
        <xsl:choose>
            <xsl:when test="contains(base-uri(), '\')">
                <xsl:value-of select="functx:substring-before-last(base-uri(), concat('\', /elml:lesson/@label,'\'))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="functx:substring-before-last(base-uri(), concat('/', /elml:lesson/@label,'/'))"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="lang">
        <xsl:choose>
            <xsl:when test="contains(base-uri(), '\')">
                <xsl:value-of select="substring-before( substring-after(base-uri(), concat($pathRoot,'\', /elml:lesson/@label,'\')), '\text')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="substring-before( substring-after(base-uri(), concat($pathRoot,'/', /elml:lesson/@label,'/')), '/text')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="layout">
        <xsl:choose>
            <xsl:when test="document($config_file)/config/general/layout">
                <xsl:value-of select="document($config_file)/config/general/layout"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>none</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="multiple">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:modules/elml:course/elml:labelname=/elml:lesson/@label">
                <xsl:text>on</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>off</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <!-- General paramaters -->
    <xsl:param name="contact">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:general/elml:contact">
                <xsl:value-of select="document($config_file)/elml:config/elml:general/elml:contact"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/general/contact">
                <xsl:value-of select="document($config_file)/config/general/contact"/>
            </xsl:when>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="server">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:general/elml:server">
                <xsl:value-of select="document($config_file)/elml:config/elml:general/elml:server"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/general/server">
                <xsl:value-of select="document($config_file)/config/general/server"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:general/elml:server"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="role">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:general/elml:role">
                <xsl:value-of select="document($config_file)/elml:config/elml:general/elml:role"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/general/role">
                <xsl:value-of select="document($config_file)/config/general/role"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:general/elml:role"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="pagebreak_level">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:general/elml:pagebreak_level">
                <xsl:value-of select="document($config_file)/elml:config/elml:general/elml:pagebreak_level"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/general/pagebreak_level">
                <xsl:value-of select="document($config_file)/config/general/pagebreak_level"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:general/elml:pagebreak_level"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="chapter_numeration">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:general/elml:chapter_numeration">
                <xsl:value-of select="document($config_file)/elml:config/elml:general/elml:chapter_numeration"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/general/chapter_numeration">
                <xsl:value-of select="document($config_file)/config/general/chapter_numeration"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:general/elml:chapter_numeration"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="manifest_type">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:general/elml:manifest_type">
                <xsl:value-of select="document($config_file)/elml:config/elml:general/elml:manifest_type"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/general/manifest_type">
                <xsl:value-of select="document($config_file)/config/general/manifest_type"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:general/elml:manifest_type"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="optional_units">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:general/elml:optional_units/elml:labelname">
                <xsl:value-of select="document($config_file)/elml:config/elml:general/elml:optional_units/elml:labelname"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/general/optional_units/labelname">
                <xsl:value-of select="document($config_file)/config/general/optional_units/labelname"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:general/elml:optional_units/elml:labelname"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <!-- Online parameters -->
    <xsl:param name="bugtracker">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:online/elml:bugtracker">
                <xsl:value-of select="document($config_file)/elml:config/elml:online/elml:bugtracker"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/online/bugtracker">
                <xsl:value-of select="document($config_file)/config/online/bugtracker"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:online/elml:bugtracker"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="use_embed">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:online/elml:use_embed">
                <xsl:value-of select="document($config_file)/elml:config/elml:online/elml:use_embed"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:online/elml:use_embed"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="html_version">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:online/elml:html_version">
                <xsl:value-of select="document($config_file)/elml:config/elml:online/elml:html_version"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:online/elml:html_version"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="use_labelReferences">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:online/elml:use_labelReferences">
                <xsl:value-of select="document($config_file)/elml:config/elml:online/elml:use_labelReferences"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/online/use_labelReferences">
                <xsl:value-of select="document($config_file)/config/online/use_labelReferences"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:online/elml:use_labelReferences"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="use_navigation">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:online/elml:use_navigation">
                <xsl:value-of select="document($config_file)/elml:config/elml:online/elml:use_navigation"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/online/use_navigation">
                <xsl:value-of select="document($config_file)/config/online/use_navigation"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:online/elml:use_navigation"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="css_framework">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:online/elml:css_framework">
                <xsl:value-of select="document($config_file)/elml:config/elml:online/elml:css_framework"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/online/css_framework">
                <xsl:value-of select="document($config_file)/config/online/css_framework"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:online/elml:css_framework"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="icon_filetype">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:online/elml:icon_filetype">
                <xsl:value-of select="document($config_file)/elml:config/elml:online/elml:icon_filetype"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/online/icon_filetype">
                <xsl:value-of select="document($config_file)/config/online/icon_filetype"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:online/elml:icon_filetype"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="glossaryMousoverWithHTML">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:online/elml:glossaryMousoverWithHTML">
                <xsl:value-of select="document($config_file)/elml:config/elml:online/elml:glossaryMousoverWithHTML"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/online/glossaryMousoverWithHTML">
                <xsl:value-of select="document($config_file)/config/online/glossaryMousoverWithHTML"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:online/elml:glossaryMousoverWithHTML"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="lightwindow">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:online/elml:lightwindow">
                <xsl:value-of select="document($config_file)/elml:config/elml:online/elml:lightwindow"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/online/lightwindow">
                <xsl:value-of select="document($config_file)/config/online/lightwindow"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:online/elml:lightwindow"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <!-- print parameters -->
    <xsl:param name="display_links">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:print/elml:display_links">
                <xsl:value-of select="document($config_file)/elml:config/elml:print/elml:display_links"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/print/display_links">
                <xsl:value-of select="document($config_file)/config/print/display_links"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:print/elml:display_links"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="hyphenation">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:print/elml:hyphenation">
                <xsl:value-of select="document($config_file)/elml:config/elml:print/elml:hyphenation"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/print/hyphenation">
                <xsl:value-of select="document($config_file)/config/print/hyphenation"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:print/elml:hyphenation"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="fop_version">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:print/elml:fop_version">
                <xsl:value-of select="document($config_file)/elml:config/elml:print/elml:fop_version"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/print/fop_version">
                <xsl:value-of select="document($config_file)/config/print/fop_version"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:print/elml:fop_version"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="pageheight">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:print/elml:pageheight">
                <xsl:value-of select="document($config_file)/elml:config/elml:print/elml:pageheight"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/print/pageheight">
                <xsl:value-of select="document($config_file)/config/print/pageheight"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:print/elml:pageheight"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="pagewidth">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:print/elml:pagewidth">
                <xsl:value-of select="document($config_file)/elml:config/elml:print/elml:pagewidth"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/print/pagewidth">
                <xsl:value-of select="document($config_file)/config/print/pagewidth"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:print/elml:pagewidth"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="fontsize">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:print/elml:fontsize">
                <xsl:value-of select="document($config_file)/elml:config/elml:print/elml:fontsize"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/print/fontsize">
                <xsl:value-of select="document($config_file)/config/print/fontsize"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:print/elml:fontsize"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="lineheight">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:print/elml:lineheight">
                <xsl:value-of select="document($config_file)/elml:config/elml:print/elml:lineheight"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/print/lineheight">
                <xsl:value-of select="document($config_file)/config/print/lineheight"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:print/elml:lineheight"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="fontweighttitle">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:print/elml:fontweighttitle">
                <xsl:value-of select="document($config_file)/elml:config/elml:print/elml:fontweighttitle"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/print/fontweighttitle">
                <xsl:value-of select="document($config_file)/config/print/fontweighttitle"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:print/elml:fontweighttitle"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="converter_pixel_mm">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:print/elml:converter_pixel_mm">
                <xsl:value-of select="document($config_file)/elml:config/elml:print/elml:converter_pixel_mm"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/print/converter_pixel_mm">
                <xsl:value-of select="document($config_file)/config/print/converter_pixel_mm"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:print/elml:converter_pixel_mm"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <!-- Latex parameters -->
    <xsl:param name="documentclass">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:latex/elml:documentclass">
                <xsl:value-of select="document($config_file)/elml:config/elml:latex/elml:documentclass"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/latex/documentclass">
                <xsl:value-of select="document($config_file)/config/latex/documentclass"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($config_file_default)/elml:config/elml:latex/elml:documentclass"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
</xsl:stylesheet>
