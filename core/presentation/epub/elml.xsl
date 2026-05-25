<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" xmlns="http://www.w3.org/1999/xhtml" xmlns:xhtml="http://www.w3.org/1999/xhtml" version="2.0" xmlns:functx="http://www.functx.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    <!--DO NOT TOUCH ANYTHING IN THIS FILE! THESE ARE DEFAULT VALUES! -->
    <!--To personalize use the config and templates file of your project. See documentation. -->
    <!--The name of the file with the default titles (and other) names -->
    <xsl:import href="../online/elml.xsl"/>
    <!--Should columns be shown as columns? Not recommended in eBooks because not wide enough. -->
    <xsl:param name="display_columns" select="'no'"/>
    <xsl:param name="html_version" select="'5'"/>
    <xsl:param name="multiple" select="'off'"/>
    <xsl:param name="css_framework" select="'none'"/>
    <xsl:param name="use_embed" select="'no'"/>
    <xsl:param name="manifest_type" select="'ims'"/>
    <xsl:param name="use_labelReferences" select="'no'"/>
    <xsl:param name="lightwindow" select="'no'"/>
    <xsl:param name="use_navigation" select="'no'"/>
    <xsl:template name="elml:LayoutBody">
        <body>
            <xsl:call-template name="elml:navigation"/>
            <xsl:call-template name="elml:LayoutBodyContent"/>
        </body>
    </xsl:template>
    <xsl:template match="/">
        <xsl:apply-templates/>
        <xsl:call-template name="elml:LayoutHeadDefaultCSS"/>
        <xsl:call-template name="elml:metainf"/>
        <xsl:call-template name="elml:container"/>
        <xsl:call-template name="elml:epub_toc"/>
        <xsl:call-template name="elml:content"/>
        <xsl:call-template name="elml:toc"/>
        <xsl:call-template name="elml:cover"/>
    </xsl:template>
    <xsl:template name="elml:metainf">
        <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}../mimetype" format="script">
            <xsl:text>application/epub+zip</xsl:text>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="elml:container">
        <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}../META-INF/container.xml" format="manifest">
            <container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
                <rootfiles>
                    <rootfile full-path="content.opf" media-type="application/oebps-package+xml"/>
                </rootfiles>
            </container>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="elml:epub_toc">
        <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}../toc.ncx" format="manifest">
            <ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1" xml:lang="{$lang}">
                <head>
                    <meta name="dtb:uid">
                        <xsl:attribute name="content">
                            <xsl:value-of select="$server"/>
                            <xsl:text>/</xsl:text>
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:text>/</xsl:text>
                            <xsl:value-of select="$lang"/>
                            <xsl:text>#</xsl:text>
                            <xsl:value-of select="generate-id()"/>
                        </xsl:attribute>
                    </meta>
                    <meta name="dtb:depth" content="3"/>
                    <meta name="dtb:totalPageCount">
                        <xsl:attribute name="content">
                            <xsl:value-of select="count(/elml:lesson | /elml:lesson/elml:unit[(@role eq 'student') or (@role eq $role) or (not (@role))] | /elml:lesson/elml:selfAssessment | /elml:lesson/elml:summary | /elml:lesson/elml:furtherReading | /elml:lesson/elml:glossary[not(@visible eq 'online') and not(@visible eq 'none')] | /elml:lesson/elml:listOfFigures[not(@visible eq 'online') and not(@visible eq 'none')] | /elml:lesson/elml:listOfTables[not(@visible eq 'online') and not(@visible eq 'none')] | /elml:lesson/elml:index[not(@visible eq 'online') and not(@visible eq 'none')] | /elml:lesson/elml:bibliography[not(@visible eq 'online') and not(@visible eq 'none')] | /elml:lesson/elml:metadata[not(@visible eq 'online') and not(@visible eq 'none')] | /elml:lesson/elml:unit/elml:learningObject |  /elml:lesson/elml:unit/elml:selfAssessment | /elml:lesson/elml:unit//elml:summary | /elml:lesson/elml:unit//elml:furtherReading)"/>
                        </xsl:attribute>
                    </meta>
                    <meta name="dtb:maxPageNumber">
                        <xsl:attribute name="content">
                            <xsl:value-of select="count(/elml:lesson | /elml:lesson/elml:unit[(@role eq 'student') or (@role eq $role) or (not (@role))] | /elml:lesson/elml:selfAssessment | /elml:lesson/elml:summary | /elml:lesson/elml:furtherReading | /elml:lesson/elml:glossary[not(@visible eq 'online') and not(@visible eq 'none')] | /elml:lesson/elml:listOfFigures[not(@visible eq 'online') and not(@visible eq 'none')] | /elml:lesson/elml:listOfTables[not(@visible eq 'online') and not(@visible eq 'none')] | /elml:lesson/elml:index[not(@visible eq 'online') and not(@visible eq 'none')] | /elml:lesson/elml:bibliography[not(@visible eq 'online') and not(@visible eq 'none')] | /elml:lesson/elml:metadata[not(@visible eq 'online') and not(@visible eq 'none')] | /elml:lesson/elml:unit/elml:learningObject |  /elml:lesson/elml:unit/elml:selfAssessment | /elml:lesson/elml:unit//elml:summary | /elml:lesson/elml:unit//elml:furtherReading)"/>
                        </xsl:attribute>
                    </meta>
                </head>
                <docTitle>
                    <text>
                        <xsl:value-of select="/elml:lesson/@title"/>
                    </text>
                </docTitle>
                <navMap>
                    <xsl:choose>
                        <xsl:when test="$multiple='on'">
                            <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                                <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson" mode="navmap"/>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="/elml:lesson" mode="navmap"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </navMap>
            </ncx>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="elml:lesson | elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="navmap">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:param name="manifest_filename">
            <xsl:call-template name="elml:Label_param_withfilename"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <navPoint xmlns="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id()"/>
                </xsl:attribute>
                <xsl:attribute name="playOrder">
                    <xsl:number level="any" count="elml:lesson | elml:unit[(@role eq 'student') or (@role eq $role) or (not (@role))] | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary[not(@visible eq 'online') and not(@visible eq 'none')] | elml:listOfFigures[not(@visible eq 'online') and not(@visible eq 'none')] | elml:listOfTables[not(@visible eq 'online') and not(@visible eq 'none')] | elml:index[not(@visible eq 'online') and not(@visible eq 'none')] | elml:bibliography[not(@visible eq 'online') and not(@visible eq 'none')] | elml:metadata[not(@visible eq 'online') and not(@visible eq 'none')] | elml:learningObject"/>
                </xsl:attribute>
                <navLabel>
                    <text>
                        <xsl:call-template name="elml:Kapitel">
                            <xsl:with-param name="isnavigation">yes</xsl:with-param>
                        </xsl:call-template>
                    </text>
                </navLabel>
                <content>
                    <xsl:attribute name="src">
                        <xsl:text>html/</xsl:text>
                        <xsl:choose>
                            <xsl:when test="contains($manifest_filename, '#')">
                                <xsl:value-of select="substring-before($manifest_filename, '#')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$manifest_filename"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </content>
                <xsl:apply-templates select="elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="navmap"/>
            </navPoint>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:content">
        <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}../content.opf" format="manifest">
            <package version="2.0" xmlns="http://www.idpf.org/2007/opf" unique-identifier="{/elml:lesson/@label}">
                <metadata xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:opf="http://www.idpf.org/2007/opf" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                    <dc:title>
                        <xsl:value-of select="/elml:lesson/@title"/>
                    </dc:title>
                    <dc:language xsi:type="dcterms:RFC3066">
                        <xsl:value-of select="$lang"/>
                    </dc:language>
                    <dc:identifier id="{/elml:lesson/@label}" opf:scheme="URI">
                        <xsl:value-of select="$server"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="/elml:lesson/@label"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$lang"/>
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="generate-id()"/>
                    </dc:identifier>
                    <dc:subject>
                        <xsl:value-of select="/elml:lesson/@title"/>
                        <xsl:text>, </xsl:text>
                        <xsl:for-each select="/elml:lesson/elml:metadata/elml:keywords/elml:keywordItem">
                            <xsl:value-of select="."/>
                            <xsl:text>, </xsl:text>
                        </xsl:for-each>
                        <xsl:for-each select="/elml:lesson/elml:glossary/elml:definition">
                            <xsl:value-of select="@term"/>
                            <xsl:text>, </xsl:text>
                        </xsl:for-each>
                        <xsl:text>eLML</xsl:text>
                    </dc:subject>
                    <dc:description>
                        <xsl:text>An eBook/ePub-version of the eLearning lesson "</xsl:text>
                        <xsl:value-of select="/elml:lesson/@title"/>
                        <xsl:text>". This eBook has been created using the ePub-Converter of eLML (eLesson Markup Language). See www.eLML.org for more details about creating platform-independent online content.</xsl:text>
                    </dc:description>
                    <dc:relation>http://www.eLML.org/</dc:relation>
                    <xsl:if test="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:contribute/elml:person[1]">
                        <dc:creator>
                            <xsl:attribute name="opf:file-as">
                                <xsl:value-of select="substring-after(/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:contribute/elml:person[1]/@name, ' ')"/>
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="substring-before(/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:contribute/elml:person[1]/@name, ' ')"/>
                            </xsl:attribute>
                            <xsl:value-of select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:contribute/elml:person[1]/@name"/>
                        </dc:creator>
                    </xsl:if>
                    <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:contribute/elml:person">
                        <dc:contributor>
                            <xsl:attribute name="opf:role">
                                <xsl:choose>
                                    <xsl:when test="@responsible='Overall'">
                                        <xsl:text>pdr</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@responsible='Content'">
                                        <xsl:text>aut</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@responsible='Concept'">
                                        <xsl:text>ccp</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@responsible='Translation'">
                                        <xsl:text>trl</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@responsible='Contact'">
                                        <xsl:text>prc</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@responsible='Revision'">
                                        <xsl:text>crr</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@responsible='Specials'">
                                        <xsl:text>csl</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>oth</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                            <xsl:attribute name="opf:file-as">
                                <xsl:value-of select="substring-after(@name, ' ')"/>
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="substring-before(@name, ' ')"/>
                            </xsl:attribute>
                            <xsl:value-of select="@name"/>
                            <xsl:if test="@institute">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="@institute"/>
                            </xsl:if>
                            <xsl:if test="@departement">
                                <xsl:text> (</xsl:text>
                                <xsl:value-of select="@departement"/>
                                <xsl:text>)</xsl:text>
                            </xsl:if>
                            <xsl:if test="@email">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="@email"/>
                            </xsl:if>
                        </dc:contributor>
                    </xsl:for-each>
                    <dc:publisher opf:role="prg">eLesson Markup Language (eLML)</dc:publisher>
                    <xsl:if test="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:version/@creationDate">
                        <dc:date opf:event="creation">
                            <xsl:value-of select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:version/@creationDate"/>
                        </dc:date>
                    </xsl:if>
                    <xsl:if test="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:version/@modificationDate">
                        <dc:date opf:event="modification">
                            <xsl:value-of select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:version/@modificationDate"/>
                        </dc:date>
                    </xsl:if>
                    <dc:date opf:event="publication">
                        <xsl:value-of select="year-from-date(current-date())"/>
                        <xsl:text>-</xsl:text>
                        <xsl:if test="month-from-date(current-date())&lt;10">
                            <xsl:text>0</xsl:text>
                        </xsl:if>
                        <xsl:value-of select="month-from-date(current-date())"/>
                        <xsl:text>-</xsl:text>
                        <xsl:if test="day-from-date(current-date())&lt;10">
                            <xsl:text>0</xsl:text>
                        </xsl:if>
                        <xsl:value-of select="day-from-date(current-date())"/>
                    </dc:date>
                    <dc:rights>
                        <xsl:value-of select="/elml:lesson/elml:metadata/elml:rights/elml:copyright"/>
                        <xsl:if test="/elml:lesson/elml:metadata/elml:rights/elml:copyrightURL">
                            <xsl:text> (see </xsl:text>
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
                            </xsl:choose>
                            <xsl:text>)</xsl:text>
                        </xsl:if>
                    </dc:rights>
                    <dc:format>application/epub+zip</dc:format>
                    <dc:type>eLearning lesson</dc:type>
                </metadata>
                <manifest>
                    <item id="ncx" href="toc.ncx" media-type="application/x-dtbncx+xml"/>
                    <item id="style" href="html/stylesheet.css" media-type="text/css"/>
                    <item id="cover" href="html/cover.html" media-type="application/xhtml+xml"/>
                    <item id="toc" href="html/toc.html" media-type="application/xhtml+xml"/>
                    <xsl:choose>
                        <xsl:when test="$multiple='on'">
                            <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                                <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson" mode="manifest_items"/>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="/elml:lesson" mode="manifest_items"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:for-each-group select="//elml:multimedia" group-by="@src">
                        <xsl:sort select="." order="ascending" case-order="lower-first"/>
                        <xsl:if test="@thumbnail and not(@thumbnail=@src)">
                            <item>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="substring-after(@thumbnail, '../')"/>
                                </xsl:attribute>
                                <xsl:attribute name="id">
                                    <xsl:call-template name="elml:Label"/>
                                    <xsl:text>thumb</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="media-type">
                                    <xsl:choose>
                                        <xsl:when test="contains(@thumbnail, '.gif')">
                                            <xsl:text>image/gif</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="contains(@thumbnail, '.png')">
                                            <xsl:text>image/png</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>image/jpeg</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                            </item>
                        </xsl:if>
                        <xsl:if test="(@type='gif' or @type='jpeg' or @type='png' or (@type='svg' and @src)) and not(contains(@src, '.pdf')) and not(contains(@src, '.html'))">
                            <item>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="substring-after(@src, '../')"/>
                                </xsl:attribute>
                                <xsl:attribute name="id">
                                    <xsl:call-template name="elml:Label"/>
                                </xsl:attribute>
                                <xsl:attribute name="media-type">
                                    <xsl:choose>
                                        <xsl:when test="@type='gif'">
                                            <xsl:text>image/gif</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type='png'">
                                            <xsl:text>image/png</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type='svg'">
                                            <xsl:text>image/svg+xml</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>image/jpeg</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                            </item>
                        </xsl:if>
                    </xsl:for-each-group>
                </manifest>
                <spine toc="ncx">
                    <itemref idref="cover"/>
                    <itemref idref="toc"/>
                    <xsl:choose>
                        <xsl:when test="$multiple='on'">
                            <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                                <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson" mode="manifest_spine"/>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="/elml:lesson" mode="manifest_spine"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </spine>
                <guide>
                    <reference type="title-page" title="{/elml:lesson/@title}" href="html/cover.html"/>
                    <reference type="toc" title="{$name_content}" href="html/toc.html"/>
                    <xsl:if test="/elml:lesson/elml:index">
                        <reference type="index" title="{$name_index}" href="html/{/elml:lesson/@label}_index.html"/>
                    </xsl:if>
                    <xsl:if test="/elml:lesson/elml:glossary">
                        <reference type="glossary" title="{$name_glossary}" href="html/{/elml:lesson/@label}_glossary.html"/>
                    </xsl:if>
                    <xsl:if test="/elml:lesson/elml:bibliography">
                        <reference type="bibliography" title="{$name_bibliography}" href="html/{/elml:lesson/@label}_bibliography.html"/>
                    </xsl:if>
                    <xsl:if test="/elml:lesson/elml:metadata">
                        <reference type="copyright-page" title="{$name_metadata}" href="html/{/elml:lesson/@label}_metadata.html"/>
                    </xsl:if>
                    <xsl:if test="/elml:lesson/elml:listOfFigures">
                        <reference type="loi" title="{$name_figures}" href="html/{/elml:lesson/@label}_listoffigures.html"/>
                    </xsl:if>
                    <xsl:if test="/elml:lesson/elml:listOfTables">
                        <reference type="lot" title="{$name_tables}" href="html/{/elml:lesson/@label}_listoftables.html"/>
                    </xsl:if>
                    <reference type="text" title="{$name_entry}" href="html/index.html"/>
                </guide>
            </package>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="elml:toc">
        <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}toc.html" format="xhtml11">
            <html xml:lang="{$lang}">
                <xsl:call-template name="elml:LayoutHead"/>
                <body>
                    <h1>
                        <xsl:value-of select="$name_content"/>
                    </h1>
                    <ul class="navigation" id="nav_lesson">
                        <li>
                            <a href="cover.html">Cover</a>
                        </li>
                        <li>
                            <a href="toc.html">
                                <xsl:value-of select="$name_content"/>
                            </a>
                        </li>
                        <xsl:call-template name="elml:navigation_start"/>
                    </ul>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="elml:cover">
        <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}cover.html" format="xhtml11">
            <html xml:lang="{$lang}">
                <xsl:call-template name="elml:LayoutHead"/>
                <body style="margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px; font-family: verdana, arial, helvetica, sans-serif; color: #ccc; background-color: #333; text-align: center;">
                    <div style="width: 70%; padding: 10px; margin-top: 20px; margin-bottom: 20px; margin-right: auto; margin-left: auto; 	 background: #666; border: 5px solid #ccc; text-align:left;">
                        <h1>
                            <xsl:value-of select="/elml:lesson/@title"/>
                        </h1>
                        <xsl:value-of select="$name_printed"/>
                        <xsl:value-of select="day-from-date(current-date())"/>
                        <xsl:text>.</xsl:text>
                        <xsl:value-of select="month-from-date(current-date())"/>
                        <xsl:text>.</xsl:text>
                        <xsl:value-of select="year-from-date(current-date())"/>
                        <xsl:if test="/elml:lesson/elml:metadata/elml:rights/elml:copyright">
                            <xsl:text>. Copyright: </xsl:text>
                            <xsl:value-of select="/elml:lesson/elml:metadata/elml:rights/elml:copyright"/>
                            <xsl:text>. </xsl:text>
                        </xsl:if>
                        <h2>
                            <xsl:value-of select="$name_responsible"/>
                        </h2>
                        <ul>
                            <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:contribute/elml:person">
                                <li>
                                    <xsl:if test="@responsible">
                                        <xsl:value-of select="@responsible"/>
                                        <xsl:text>: </xsl:text>
                                    </xsl:if>
                                    <xsl:choose>
                                        <xsl:when test="@email">
                                            <a href="mailto:{@email}">
                                                <xsl:value-of select="@name"/>
                                            </a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="@name"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test="@institute">
                                        <xsl:text>, </xsl:text>
                                        <xsl:value-of select="@institute"/>
                                    </xsl:if>
                                    <xsl:if test="@departement">
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="@departement"/>
                                        <xsl:text>)</xsl:text>
                                    </xsl:if>
                                </li>
                            </xsl:for-each>
                        </ul>
                        <p>This eBook has been created using the ePub-Converter of eLML (eLesson Markup Language). See <a href="http://www.elml.org">www.eLML.org</a> for more details about creating platform-independent online content.</p>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="elml:lesson" mode="navigation_lesson">
        <xsl:param name="filename"/>
        <xsl:param name="actual_lesson"/>
        <li>
            <xsl:call-template name="elml:nav_item_link">
                <xsl:with-param name="filename" select="'toc.html'"/>
                <xsl:with-param name="isnavigation">no</xsl:with-param>
            </xsl:call-template>
            <ul class="navigation nav_unit">
                <xsl:apply-templates select="elml:unit | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="navigation_unit">
                    <xsl:with-param name="filename" select="'toc.html'"/>
                </xsl:apply-templates>
            </ul>
        </li>
    </xsl:template>
    <xsl:template match="elml:unit | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="navigation_unit">
        <xsl:param name="filename"/>
        <xsl:param name="filenameactual">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <li>
                <xsl:call-template name="elml:nav_item_link">
                    <xsl:with-param name="filename" select="$filename"/>
                    <xsl:with-param name="isnavigation">no</xsl:with-param>
                </xsl:call-template>
                <xsl:if test="elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading">
                    <ul class="navigation nav_lo">
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
        <li>
            <xsl:call-template name="elml:nav_item_link">
                <xsl:with-param name="filename" select="$filename"/>
                <xsl:with-param name="isnavigation">no</xsl:with-param>
            </xsl:call-template>
        </li>
    </xsl:template>
    <xsl:template match="elml:lesson | elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="manifest_items">
        <xsl:param name="manifest_filename">
            <xsl:call-template name="elml:Label_param_withfilename"/>
        </xsl:param>
        <item xmlns="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id">
                <xsl:value-of select="generate-id()"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>html/</xsl:text>
                <xsl:choose>
                    <xsl:when test="contains($manifest_filename, '#')">
                        <xsl:value-of select="substring-before($manifest_filename, '#')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$manifest_filename"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="media-type">
                <xsl:text>application/xhtml+xml</xsl:text>
            </xsl:attribute>
        </item>
        <xsl:apply-templates select="elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="manifest_items"/>
    </xsl:template>
    <xsl:template match="elml:lesson | elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="manifest_spine">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <itemref xmlns="http://www.idpf.org/2007/opf">
                <xsl:attribute name="idref">
                    <xsl:value-of select="generate-id()"/>
                </xsl:attribute>
            </itemref>
            <xsl:apply-templates select="elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listOfFigures | elml:listOfTables | elml:index | elml:bibliography | elml:metadata" mode="manifest_spine"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:MultimediaShow">
        <xsl:param name="pathMultimedia">
            <xsl:choose>
                <xsl:when test="contains(@src, '.gif') or contains(@src, '.jpg') or contains(@src, '.jpeg') or contains(@src, '.png')">
                    <xsl:value-of select="@src"/>
                </xsl:when>
                <xsl:when test="@thumbnail">
                    <xsl:value-of select="@thumbnail"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@src"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="pathMultimediaSource">
            <xsl:choose>
                <xsl:when test="contains(@src, '.gif') or contains(@src, '.jpg') or contains(@src, '.jpeg') or contains(@src, '.png')">
                    <xsl:value-of select="@src"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$server"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="/elml:lesson/@label"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$lang"/>
                    <xsl:text>/html/</xsl:text>
                    <xsl:value-of select="@src"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="@thumbnail and (contains(@src, '.gif') or contains(@src, '.jpg') or contains(@src, '.jpeg') or contains(@src, '.png'))">
                <xsl:call-template name="elml:Image">
                    <xsl:with-param name="pathMultimedia">
                        <xsl:value-of select="$pathMultimedia"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="@thumbnail">
                <a href="{$pathMultimediaSource}">
                    <xsl:if test="not($html_version='1.1')">
                        <xsl:attribute name="target">
                            <xsl:text>_blank</xsl:text>
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
            <xsl:when test="@type='gif' or @type='jpeg' or @type='png'">
                <xsl:call-template name="elml:Image">
                    <xsl:with-param name="pathMultimedia">
                        <xsl:value-of select="$pathMultimedia"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="(@type='mathml' or @type='svg') and @src">
                <xsl:choose>
                    <xsl:when test="starts-with(@src, 'http')">
                        <xsl:copy-of select="document(@src)/*"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="document(concat(elml:get_pathHTML(base-uri(),/elml:lesson/@label),@src))/*"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="@type='mathml' or @type='svg'">
                <xsl:copy-of select="child::*"/>
            </xsl:when>
            <xsl:otherwise>
                <span style="font-weight: bold; color:red;">
                    <xsl:value-of select="$name_notanimage"/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:tooltipAttribute">
        <xsl:param name="termid"/>
    </xsl:template>
    <xsl:template name="elml:display">
        <xsl:choose>
            <xsl:when test="name()='multimedia' and @type='div'">no</xsl:when>
            <xsl:when test="((@role='student') or (@role=$role) or (not (@role))) and not(@visible='none')">
                <xsl:text>yes</xsl:text>
            </xsl:when>
            <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:selfCheck">
        <xsl:call-template name="elml:Title"/>
        <table>
            <xsl:call-template name="elml:Label"/>
            <tbody>
                <xsl:apply-templates/>
            </tbody>
        </table>
    </xsl:template>
    <xsl:template match="elml:multipleChoice">
        <xsl:apply-templates select="elml:question|elml:answer"/>
        <xsl:apply-templates select="elml:solution"/>
    </xsl:template>
    <xsl:template match="elml:fillInBlanks">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="elml:question">
        <tr>
            <td colspan="2">
                <strong>
                    <xsl:apply-templates/>
                </strong>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="elml:answer">
        <tr>
            <td>
                <xsl:choose>
                    <xsl:when test="($role='tutor') and (@correct='yes')"> &#10003; </xsl:when>
                    <xsl:when test="$role='tutor'"> &#10007; </xsl:when>
                    <xsl:when test="count(../elml:answer[@correct='yes'])=1"> &#10061; </xsl:when>
                    <xsl:otherwise> &#10063; </xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <xsl:apply-templates/>
                <xsl:if test="@feedback!='' and $role='tutor'">
                    <xsl:text> </xsl:text> &#10142; <xsl:value-of select="$name_hint"/>
                    <xsl:text>: </xsl:text>
                    <xsl:value-of select="@feedback"/>
                </xsl:if>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="elml:gapText">
        <tr>
            <td colspan="2">
                <xsl:apply-templates/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="elml:gap">
        <xsl:choose>
            <xsl:when test="$role='tutor'">
                <em>
                    <xsl:apply-templates/>
                </em>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> ___________ </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:solution">
        <xsl:if test="$role='tutor'">
            <tr>
                <td colspan="2"> &#9758; <xsl:apply-templates/>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:LayoutSelfCheckScript"/>
    <xsl:template name="elml:LayoutSelfCheckCSS"/>
    <xsl:template name="elml:LayoutTooltip"/>
    <xsl:template match="elml:lesson">
        <xsl:param name="filename">
            <xsl:call-template name="elml:Label_param"/>
        </xsl:param>
        <xsl:choose> 
            <xsl:when test="$html_version='5' and (($pagebreak_level='lesson') or ($pagebreak_level='unit') or ($pagebreak_level='lo'))">
                <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}{$filename}" format="html5">
                    <html lang="{$lang}" xml:lang="{$lang}">
                        <xsl:call-template name="elml:LayoutHead"/>
                        <xsl:call-template name="elml:LayoutBody"/>
                    </html>
                </xsl:result-document>
            </xsl:when>
            <xsl:when test="$html_version='1.1' and (($pagebreak_level='lesson') or ($pagebreak_level='unit') or ($pagebreak_level='lo'))">
                <xsl:result-document href="{elml:get_pathHTML(base-uri(),/elml:lesson/@label)}{$filename}" format="xhtml11">
                    <html xml:lang="{$lang}">
                        <xsl:call-template name="elml:LayoutHead"/>
                        <xsl:call-template name="elml:LayoutBody"/>
                    </html>
                </xsl:result-document>
            </xsl:when>
            <xsl:otherwise>
                <html>
                    <xsl:call-template name="elml:LayoutHead"/>
                    <xsl:call-template name="elml:LayoutBody"/>
                </html>
            </xsl:otherwise>
        </xsl:choose>
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
            <p id="{$varname}" class="popupTitle">
                <xsl:if test="@icon and not($layout='none')">
                    <xsl:call-template name="Icon">
                        <xsl:with-param name="icon" select="@icon"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:value-of select="@title"/>
            </p>
            <div id="{$varname}text">
                <xsl:call-template name="elml:CSS_Class"/>
                <xsl:if test="@title">
                    <xsl:attribute name="title">
                        <xsl:value-of select="@title"/>
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
    <xsl:template match="elml:organisation">
        <p> Please note that the Metadata-chapter is only available in English!</p>
        <h3 id="Organisation">Organisation</h3>
        <table class="metadata_table">
            <tr>
                <td valign="top">Level</td>
                <td>
                    <xsl:value-of select="@level"/>
                </td>
            </tr>
            <tr>
                <td valign="top">Module:</td>
                <td>
                    <xsl:value-of select="@module"/>
                </td>
            </tr>
            <tr>
                <td valign="top">Lesson:</td>
                <td>
                    <xsl:apply-templates/>
                </td>
            </tr>
        </table>
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
                            <xsl:value-of select="elml:previous"/>
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
                            <xsl:value-of select="elml:following"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </i>
            </xsl:otherwise>
        </xsl:choose>
        <br/>
    </xsl:template>
    <xsl:template match="elml:lessonInfo">
        <h3 id="Information">Lesson Information </h3>
        <table class="metadata_table">
            <tr>
                <td valign="top">Language: </td>
                <td>
                    <p>
                        <xsl:choose>
                            <xsl:when test="elml:language/@language='en'">English (EN) </xsl:when>
                            <xsl:when test="elml:language/@language='de'">German (DE) </xsl:when>
                            <xsl:when test="elml:language/@language='fr'">French (FR) </xsl:when>
                            <xsl:when test="elml:language/@language='if'">Italian (IT) </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="elml:language/@language"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </p>
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
    </xsl:template>
    <xsl:template match="elml:educational">
        <xsl:if test="elml:difficulty">
            <tr>
                <td valign="top">Difficulty Level: </td>
                <td>
                    <xsl:value-of select="elml:difficulty"/>
                </td>
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
    <xsl:template name="elml:text_download">
        <xsl:if test="text()">
            <span class="bibCommentSource">
                <xsl:text> [</xsl:text>
                <xsl:value-of select="text()"/>
                <xsl:text>]</xsl:text>
            </span>
        </xsl:if>
        <xsl:if test="@downloadUrl">
            <xsl:text> (</xsl:text>
            <a class="bibLink">
                <xsl:attribute name="href">
                    <xsl:value-of select="$server"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="/elml:lesson/@label"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$lang"/>
                    <xsl:value-of select="substring-after(@downloadUrl, '..')"/>
                </xsl:attribute>
                <xsl:value-of select="$name_download"/>
            </a>
            <xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:template>
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
        <xsl:if test="$display='yes'">
            <xsl:choose>
                <xsl:when test="$display_columns='no'">
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
                        <xsl:apply-templates mode="yaml">
                            <xsl:with-param name="columnleftwidth" select="$columnleftwidth"/>
                        </xsl:apply-templates>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <table>
                        <xsl:call-template name="elml:CSS_Class"/>
                        <xsl:call-template name="elml:Label"/>
                        <tr valign="top">
                            <xsl:apply-templates/>
                        </tr>
                    </table>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
