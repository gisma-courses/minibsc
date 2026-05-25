<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2004/07/xpath-functions" xmlns:xdt="http://www.w3.org/2004/07/xpath-datatypes">
    <!-- ***** Bibliography Elements for APA style *****-->
    <xsl:template name="elml:BibliographyRef">
        <!--Same as main template in elml.xsl but with a comma between author and year-->
        <xsl:if test="@bibIDRef">
            <fo:inline>
                <xsl:attribute name="hyphenate" select="'false'"/>
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
                <fo:basic-link>
                    <xsl:attribute name="internal-destination">
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
                </fo:basic-link>
                <xsl:if test="/elml:lesson/elml:bibliography/*[@bibID=$id]/@publicationYear or @pageNr">
                    <xsl:choose>
                        <xsl:when test="@yearOnly='yes'">
                            <xsl:text> (</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>, </xsl:text>
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
            </fo:inline>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:furtherReading">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:call-template name="elml:generate_Title"/>
            <fo:block hyphenate="false">
                <xsl:choose>
                    <xsl:when test="@sorting='off'">
                        <xsl:for-each select="elml:resItem">
                            <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]">
                                <xsl:with-param name="comment" select="text()"/>
                                <xsl:with-param name="furtherReading" select="@bibIDRef"/>
                                <xsl:with-param name="pageNr" select="@pageNr"/>
                            </xsl:apply-templates>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="@sorting='byYear'">
                        <xsl:for-each select="elml:resItem">
                            <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@publicationYear" order="descending" lang="{$lang}"/>
                            <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]">
                                <xsl:with-param name="comment" select="text()"/>
                                <xsl:with-param name="furtherReading" select="@bibIDRef"/>
                                <xsl:with-param name="pageNr" select="@pageNr"/>
                            </xsl:apply-templates>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="@sorting='groupByType'">
                        <xsl:for-each-group select="elml:resItem/@bibIDRef" group-by="/elml:lesson/elml:bibliography/*[@bibID=current()]/name()">
                            <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/name()" order="ascending" lang="{$lang}"/>
                            <fo:block font-size="{$fontsize}*1.5" line-height="{$lineheight}*1.5" space-before.optimum="{$lineheight}*0.5" font-weight="{$fontweighttitle}" keep-with-next.within-page="always" text-align="left">
                                <xsl:call-template name="elml:name_biblio">
                                    <xsl:with-param name="itemname" select="name(/elml:lesson/elml:bibliography/*[@bibID=current()])"/>
                                </xsl:call-template>
                            </fo:block>
                            <fo:block>
                                <xsl:for-each select="current-group()">
                                    <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@author" order="ascending" lang="{$lang}"/>
                                    <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()]">
                                        <xsl:with-param name="comment" select="../text()"/>
                                        <xsl:with-param name="furtherReading" select="current()"/>
                                        <xsl:with-param name="pageNr" select="../@pageNr"/>
                                    </xsl:apply-templates>
                                </xsl:for-each>
                            </fo:block>
                        </xsl:for-each-group>
                    </xsl:when>
                    <xsl:when test="@sorting='groupByYear'">
                        <xsl:for-each-group select="elml:resItem/@bibIDRef" group-by="/elml:lesson/elml:bibliography/*[@bibID=current()]/@publicationYear">
                            <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@publicationYear" order="descending" lang="{$lang}"/>
                            <fo:block font-size="{$fontsize}*1.5" line-height="{$lineheight}*1.5" space-before.optimum="{$lineheight}*0.5" font-weight="{$fontweighttitle}" keep-with-next.within-page="always" text-align="left">
                                <xsl:value-of select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@publicationYear"/>
                            </fo:block>
                            <fo:block>
                                <xsl:for-each select="current-group()">
                                    <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@author"/>
                                    <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()]">
                                        <xsl:with-param name="comment" select="../text()"/>
                                        <xsl:with-param name="furtherReading" select="current()"/>
                                        <xsl:with-param name="pageNr" select="../@pageNr"/>
                                    </xsl:apply-templates>
                                </xsl:for-each>
                            </fo:block>
                        </xsl:for-each-group>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="elml:resItem">
                            <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@author" order="ascending" lang="{$lang}"/>
                            <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]">
                                <xsl:with-param name="comment" select="text()"/>
                                <xsl:with-param name="furtherReading" select="@bibIDRef"/>
                                <xsl:with-param name="pageNr" select="@pageNr"/>
                            </xsl:apply-templates>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:block>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:bibliography">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:call-template name="elml:generate_Title"/>
            <fo:block hyphenate="false">
                <xsl:choose>
                    <xsl:when test="@sorting='off'">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="@sorting='byYear'">
                        <xsl:apply-templates>
                            <xsl:sort select="@publicationYear" order="descending" lang="{$lang}"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:when test="@sorting='groupByType'">
                        <xsl:for-each-group select="node()" group-by="name()">
                            <xsl:sort select="name()" order="ascending" lang="{$lang}"/>
                            <fo:block font-size="{$fontsize}*1.5" line-height="{$lineheight}*1.5" space-before.optimum="{$lineheight}*0.5" font-weight="{$fontweighttitle}" keep-with-next.within-page="always" text-align="left">
                                <xsl:call-template name="elml:name_biblio">
                                    <xsl:with-param name="itemname" select="name()"/>
                                </xsl:call-template>
                            </fo:block>
                            <fo:block>
                                <xsl:apply-templates select="current-group()">
                                    <xsl:sort select="@author" order="ascending" lang="{$lang}"/>
                                </xsl:apply-templates>
                            </fo:block>
                        </xsl:for-each-group>
                    </xsl:when>
                    <xsl:when test="@sorting='groupByYear'">
                        <xsl:for-each-group select="node()" group-by="@publicationYear">
                            <xsl:sort select="@publicationYear" order="descending" lang="{$lang}"/>
                            <fo:block font-size="{$fontsize}*1.5" line-height="{$lineheight}*1.5" space-before.optimum="{$lineheight}*0.5" font-weight="{$fontweighttitle}" keep-with-next.within-page="always" text-align="left">
                                <xsl:value-of select="@publicationYear"/>
                            </fo:block>
                            <fo:block>
                                <xsl:apply-templates select="current-group()">
                                    <xsl:sort select="@author" order="ascending" lang="{$lang}"/>
                                </xsl:apply-templates>
                            </fo:block>
                        </xsl:for-each-group>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates>
                            <xsl:sort select="@author" order="ascending" lang="{$lang}"/>
                        </xsl:apply-templates>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:block>
        </xsl:if>
    </xsl:template>
    <!-- ******* Bibliography Elements *********** -->
    <xsl:template name="author_year">
        <fo:inline font-weight="bold" font-variant="small-caps">
            <xsl:choose>
                <xsl:when test="@author">
                    <xsl:value-of select="@author"/>
                    <xsl:if test="not(ends-with(@author,'.'))">
                        <xsl:text>. </xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$name_anon"/>
                    <xsl:text>. </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </fo:inline>
        <xsl:choose>
            <xsl:when test="@publicationYear | @dayMonthYear">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="@publicationYear"/>
                <xsl:value-of select="@dayMonthYear"/>
                <xsl:text>). </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>. </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="text_download">
        <xsl:if test="@downloadUrl">
            <xsl:text> (</xsl:text>
            <fo:basic-link>
                <xsl:attribute name="external-destination">
                    <xsl:value-of select="@downloadUrl"/>
                </xsl:attribute>
                <xsl:value-of select="$name_download"/>
            </fo:basic-link>
            <xsl:text>)</xsl:text>
        </xsl:if>
        <xsl:if test="text()">
            <fo:inline font-stretch="narrower">
                <xsl:text> [</xsl:text>
                <xsl:value-of select="text()"/>
                <xsl:text>]</xsl:text>
            </fo:inline>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:book">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@title">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@title"/>
                </fo:inline>
            </xsl:if>
            <xsl:if test="@edition">
                <xsl:text> </xsl:text>
                <xsl:value-of select="@edition"/>
            </xsl:if>
            <xsl:if test="@title | @edition">
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@publicationPlace">
                <xsl:value-of select="@publicationPlace"/>
            </xsl:if>
            <xsl:if test="@publisher">
                <xsl:if test="@publicationPlace">
                    <xsl:text>: </xsl:text>
                </xsl:if>
                <xsl:value-of select="@publisher"/>
            </xsl:if>
            <xsl:if test="$pageNr">
                <xsl:if test="@publicationPlace or @publisher">
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:value-of select="$pageNr"/>
            </xsl:if>
            <xsl:if test="@publisher or @publicationPlace or $pageNr">
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:contributionInBook">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@titleOfContribution">
                <xsl:value-of select="@titleOfContribution"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@editor">
                <xsl:text>In </xsl:text>
                <xsl:value-of select="@editor"/>
                <!-- language -->
                <xsl:choose>
                    <xsl:when test="$lang='de'">
                        <xsl:text> (Hrsg.), </xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(@editor, ',') or contains(@editor, '&amp;')">
                        <xsl:text> (Eds.), </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> (Ed.), </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="@title">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@title"/>
                </fo:inline>
            </xsl:if>
            <xsl:if test="@pageNr or $pageNr">
                <!-- language -->
                <xsl:choose>
                    <xsl:when test="$lang='de'">
                        <xsl:text> (S. </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> (p. </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="$pageNr">
                        <xsl:value-of select="$pageNr"/>
                    </xsl:when>
                    <xsl:when test="@pageNr">
                        <xsl:value-of select="@pageNr"/>
                    </xsl:when>
                </xsl:choose>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="@title or @pageNr or @editor or $pageNr">
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@publicationPlace">
                <xsl:value-of select="@publicationPlace"/>
            </xsl:if>
            <xsl:if test="@publisher">
                <xsl:if test="@publicationPlace">
                    <xsl:text>: </xsl:text>
                </xsl:if>
                <xsl:value-of select="@publisher"/>
            </xsl:if>
            <xsl:if test="@publicationPlace | @publisher">
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:journalArticle">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@title">
                <xsl:value-of select="@title"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@journalTitle">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@journalTitle"/>
                </fo:inline>
                <xsl:if test="@volumeNr or @pageNr or $pageNr">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:if>
            <xsl:if test="@volumeNr">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@volumeNr"/>
                    <xsl:text>, </xsl:text>
                </fo:inline>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="$pageNr">
                    <xsl:value-of select="$pageNr"/>
                </xsl:when>
                <xsl:when test="@pageNr">
                    <xsl:value-of select="@pageNr"/>
                </xsl:when>
            </xsl:choose>
            <xsl:text>. </xsl:text>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:newspaperArticle">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@title">
                <xsl:value-of select="@title"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@newspaperTitle">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@newspaperTitle"/>
                </fo:inline>
                <xsl:if test="@dayMonth or @pageNr or $pageNr">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:if>
            <xsl:if test="@dayMonth">
                <xsl:value-of select="@dayMonth"/>
                <xsl:if test="@pageNr or $pageNr">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="$pageNr">
                    <xsl:value-of select="$pageNr"/>
                </xsl:when>
                <xsl:when test="@pageNr">
                    <xsl:value-of select="@pageNr"/>
                </xsl:when>
            </xsl:choose>
            <xsl:if test="@newspaperTitle or @dayMonth or @pageNr or $pageNr">
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:map">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@title">
                <xsl:value-of select="@title"/>
            </xsl:if>
            <xsl:if test="@scale">
                <xsl:if test="@title">
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:value-of select="@scale"/>
            </xsl:if>
            <xsl:text>. </xsl:text>
            <xsl:if test="@publicationPlace">
                <xsl:value-of select="@publicationPlace"/>
            </xsl:if>
            <xsl:if test="@publisher">
                <xsl:if test="@publicationPlace">
                    <xsl:text>: </xsl:text>
                </xsl:if>
                <xsl:value-of select="@publisher"/>
            </xsl:if>
            <xsl:if test="@publisher or @publicationPlace">
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:conferencePaper">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@titleOfContribution">
                <xsl:value-of select="@titleOfContribution"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <fo:inline font-style="italic">
                <xsl:text>In: </xsl:text>
            </fo:inline>
            <xsl:if test="@editor">
                <fo:inline font-weight="bold" font-variant="small-caps">
                    <xsl:value-of select="@editor"/>
                </fo:inline>
                <xsl:choose>
                    <xsl:when test="$lang='de'">
                        <xsl:text> (Hrsg.), </xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(@editor, ',') or contains(@editor, '&amp;')">
                        <xsl:text> (Eds.), </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> (Ed.), </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="@proceedingsTitle">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@proceedingsTitle"/>
                    <xsl:if test="@datePlace">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="@datePlace"/>
                    </xsl:if>
                    <xsl:text>. </xsl:text>
                </fo:inline>
            </xsl:if>
            <xsl:if test="@publicationPlace">
                <xsl:value-of select="@publicationPlace"/>
            </xsl:if>
            <xsl:if test="@publisher">
                <xsl:if test="@publicationPlace">
                    <xsl:text>: </xsl:text>
                </xsl:if>
                <xsl:value-of select="@publisher"/>
            </xsl:if>
            <xsl:if test="@pageNr or $pageNr">
                <xsl:if test="@publicationPlace or @publisher">
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="$pageNr">
                        <xsl:value-of select="$pageNr"/>
                    </xsl:when>
                    <xsl:when test="@pageNr">
                        <xsl:value-of select="@pageNr"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="@publisher or @publicationPlace or @pageNr or $pageNr">
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:publicationCorporateBody">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@title">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@title"/>
                </fo:inline>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@publicationPlace">
                <xsl:value-of select="@publicationPlace"/>
            </xsl:if>
            <xsl:if test="@publisher">
                <xsl:if test="@publicationPlace">
                    <xsl:text>: </xsl:text>
                </xsl:if>
                <xsl:value-of select="@publisher"/>
            </xsl:if>
            <xsl:if test="@reportNr">
                <xsl:if test="@publicationPlace or @publisher">
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:value-of select="@reportNr"/>
            </xsl:if>
            <xsl:if test="@publisher or @publicationPlace or @reportNr">
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:thesis">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@title">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@title"/>
                </fo:inline>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="@published='yes'">
                    <xsl:text> Published </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text> Unpublished </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="@designation"/>
            <xsl:if test="@type">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="@type"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:text>. </xsl:text>
            <xsl:if test="@insitution">
                <xsl:value-of select="@insitution"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="$pageNr">
                <xsl:value-of select="$name_page"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$pageNr"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:patent">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@title">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@title"/>
                </fo:inline>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@designation">
                <xsl:value-of select="@designation"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:videoFilmBroadcast">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@title">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@title"/>
                </fo:inline>
                <xsl:text> [Motion Picture]. </xsl:text>
            </xsl:if>
            <xsl:if test="@designation">
                <xsl:value-of select="@designation"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@productionPlace">
                <xsl:value-of select="@productionPlace"/>
            </xsl:if>
            <xsl:if test="@productionOrganisation">
                <xsl:if test="@productionPlace">
                    <xsl:text>: </xsl:text>
                </xsl:if>
                <xsl:value-of select="@productionOrganisation"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:websites">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@title">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@title"/>
                </fo:inline>
            </xsl:if>
            <xsl:if test="@edition">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="@edition"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="@title | @edition">
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@publicationPlace">
                <xsl:value-of select="@publicationPlace"/>
            </xsl:if>
            <xsl:if test="@publisher">
                <xsl:if test="@publicationPlace">
                    <xsl:text>: </xsl:text>
                </xsl:if>
                <xsl:value-of select="@publisher"/>
            </xsl:if>
            <xsl:if test="@publicationPlace | @publisher">
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@url">
                <xsl:if test="@accessedDate">
                    <xsl:text> Retrieved </xsl:text>
                    <xsl:value-of select="@accessedDate"/>
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:text> from </xsl:text>
                <fo:basic-link color="black">
                    <xsl:attribute name="external-destination">
                        <xsl:value-of select="@url"/>
                    </xsl:attribute>
                    <xsl:value-of select="@url"/>
                </fo:basic-link>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:eJournals">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@title">
                <xsl:value-of select="@title"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@journalTitle">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@journalTitle"/>
                </fo:inline>
                <xsl:if test="@volumeNr">
                    <xsl:text>, </xsl:text>
                    <fo:inline font-style="italic">
                        <xsl:value-of select="@volumeNr"/>
                    </fo:inline>
                </xsl:if>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@url">
                <xsl:text>Available from: </xsl:text>
                <fo:basic-link color="black">
                    <xsl:attribute name="external-destination">
                        <xsl:value-of select="@url"/>
                    </xsl:attribute>
                    <xsl:value-of select="@url"/>
                </fo:basic-link>
                <xsl:if test="@accessedDate">
                    <xsl:text> [Accessed </xsl:text>
                    <xsl:value-of select="@accessedDate"/>
                    <xsl:text>]</xsl:text>
                </xsl:if>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:mailLists">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@subject">
                <xsl:value-of select="@subject"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@discussionList">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@discussionList"/>
                </fo:inline>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@url">
                <xsl:text>Available from: </xsl:text>
                <fo:basic-link color="black">
                    <xsl:attribute name="external-destination">
                        <xsl:value-of select="@url"/>
                    </xsl:attribute>
                    <xsl:value-of select="@url"/>
                </fo:basic-link>
                <xsl:if test="@accessedDate">
                    <xsl:text> [Accessed </xsl:text>
                    <xsl:value-of select="@accessedDate"/>
                    <xsl:text>]</xsl:text>
                </xsl:if>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:personalMail">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@emailSender">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="@emailSender"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:text>. </xsl:text>
            <xsl:if test="@subject">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@subject"/>
                </fo:inline>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@recipient">
                <xsl:text> e-Mail to </xsl:text>
                <xsl:value-of select="@recipient"/>
                <xsl:if test="@emailRecipient">
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="@emailRecipient"/>
                    <xsl:text>)</xsl:text>
                </xsl:if>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@published='yes'">
                <xsl:text> Published.</xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
    <xsl:template match="elml:cdRom">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <fo:block text-indent="-{$lineheight}" start-indent="{$lineheight}">
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="author_year"/>
            <xsl:if test="@title">
                <fo:inline font-style="italic">
                    <xsl:value-of select="@title"/>
                </fo:inline>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:text> [CD-ROM]. </xsl:text>
            <xsl:if test="@edition">
                <xsl:value-of select="@edition"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@publicationPlace">
                <xsl:value-of select="@publicationPlace"/>
            </xsl:if>
            <xsl:if test="@publisher">
                <xsl:if test="@publicationPlace">
                    <xsl:text>: </xsl:text>
                </xsl:if>
                <xsl:value-of select="@publisher"/>
            </xsl:if>
            <xsl:if test="@publisher or @publicationPlace">
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@supplier">
                <xsl:text>Available from: </xsl:text>
                <xsl:value-of select="@supplier"/>
                <xsl:if test="@accessedDate">
                    <xsl:text> [Accessed </xsl:text>
                    <xsl:value-of select="@accessedDate"/>
                    <xsl:text>]</xsl:text>
                </xsl:if>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="text_download"/>
            <xsl:if test="$comment">
                <fo:block font-size="{$fontsize}*0.8">
                    <xsl:value-of select="$comment"/>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>
