<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" xmlns="http://www.w3.org/1999/xhtml" version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all">
    <xsl:template name="elml:BibliographyRef">
        <!--Same as main template in elml.xsl but with a comma between author and year-->
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
        </xsl:if>
    </xsl:template>
    <!-- ******* Bibliography Elements *********** -->
    <xsl:template name="elml:author_year">
        <b class="bibAuthor">
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
        </b>
        <xsl:if test="@publicationYear | @dayMonthYear">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="@publicationYear"/>
            <xsl:value-of select="@dayMonthYear"/>
            <xsl:text>). </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:text_download">
        <xsl:if test="@downloadUrl">
            <xsl:text> (</xsl:text>
            <a class="bibLink">
                <xsl:attribute name="href">
                    <xsl:value-of select="@downloadUrl"/>
                </xsl:attribute>
                <xsl:value-of select="$name_download"/>
            </a>
            <xsl:text>)</xsl:text>
        </xsl:if>
        <xsl:if test="text()">
            <span class="bibCommentSource">
                <xsl:text> [</xsl:text>
                <xsl:value-of select="text()"/>
                <xsl:text>]</xsl:text>
            </span>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:text_url">
        <xsl:if test="@accessedDate">
            <xsl:text> Retrieved </xsl:text>
            <xsl:value-of select="@accessedDate"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:text> from </xsl:text>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="@url"/>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:text>bibLink</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="@url"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="elml:book">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@title">
                <i class="bibTitle">
                    <xsl:value-of select="@title"/>
                </i>
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
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:contributionInBook">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
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
                <i class="bibTitle">
                    <xsl:value-of select="@title"/>
                </i>
            </xsl:if>
            <xsl:if test="@pageNr">
                <!-- language -->
                <xsl:choose>
                    <xsl:when test="$lang='de'">
                        <xsl:text> (S. </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> (p. </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="@pageNr"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="@title | @pageNr | @editor">
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
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:journalArticle">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@title">
                <xsl:value-of select="@title"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@journalTitle">
                <i class="bibTitle">
                    <xsl:value-of select="@journalTitle"/>
                </i>
                <xsl:if test="@volumeNr or @pageNr or $pageNr">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:if>
            <xsl:if test="@volumeNr">
                <i>
                    <xsl:value-of select="@volumeNr"/>
                    <xsl:text>, </xsl:text>
                </i>
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
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:newspaperArticle">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@title">
                <xsl:value-of select="@title"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@newspaperTitle">
                <i class="bibTitle">
                    <xsl:value-of select="@newspaperTitle"/>
                </i>
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
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:map">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
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
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:conferencePaper">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@titleOfContribution">
                <xsl:value-of select="@titleOfContribution"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <i class="bibTitle">
                <xsl:text>In: </xsl:text>
            </i>
            <xsl:if test="@editor">
                <b class="bibAuthor">
                    <xsl:value-of select="@editor"/>
                </b>
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
                <i class="bibTitle">
                    <xsl:value-of select="@proceedingsTitle"/>
                    <xsl:if test="@datePlace">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="@datePlace"/>
                    </xsl:if>
                    <xsl:text>. </xsl:text>
                </i>
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
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:publicationCorporateBody">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@title">
                <i class="bibTitle">
                    <xsl:value-of select="@title"/>
                </i>
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
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:thesis">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@title">
                <i class="bibTitle">
                    <xsl:value-of select="@title"/>
                </i>
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
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:patent">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@title">
                <i class="bibTitle">
                    <xsl:value-of select="@title"/>
                </i>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@designation">
                <xsl:value-of select="@designation"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:videoFilmBroadcast">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@title">
                <i class="bibTitle">
                    <xsl:value-of select="@title"/>
                </i>
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
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:websites">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@title">
                <i class="bibTitle">
                    <xsl:value-of select="@title"/>
                </i>
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
                <xsl:call-template name="elml:text_url"/>
            </xsl:if>
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:eJournals">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@title">
                <xsl:value-of select="@title"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@journalTitle">
                <i class="bibTitle">
                    <xsl:value-of select="@journalTitle"/>
                </i>
                <xsl:if test="@volumeNr">
                    <xsl:text>, </xsl:text>
                    <i>
                        <xsl:value-of select="@volumeNr"/>
                    </i>
                </xsl:if>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@url">
                <xsl:call-template name="elml:text_url"/>
            </xsl:if>
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:mailLists">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@subject">
                <xsl:value-of select="@subject"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@discussionList">
                <i class="bibTitle">
                    <xsl:value-of select="@discussionList"/>
                </i>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@url">
                <xsl:call-template name="elml:text_url"/>
            </xsl:if>
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:personalMail">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@emailSender">
                <xsl:text> (</xsl:text>
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:text>mailto:</xsl:text>
                        <xsl:value-of select="@emailSender"/>
                    </xsl:attribute>
                    <xsl:value-of select="@emailSender"/>
                </xsl:element>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:text>. </xsl:text>
            <xsl:if test="@subject">
                <i class="bibTitle">
                    <xsl:value-of select="@subject"/>
                </i>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@recipient">
                <xsl:text> e-Mail to </xsl:text>
                <xsl:value-of select="@recipient"/>
                <xsl:if test="@emailRecipient">
                    <xsl:text> (</xsl:text>
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:text>mailto:</xsl:text>
                            <xsl:value-of select="@emailRecipient"/>
                        </xsl:attribute>
                        <xsl:value-of select="@emailRecipient"/>
                    </xsl:element>
                    <xsl:text>)</xsl:text>
                </xsl:if>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@published='yes'">
                <xsl:text> Published.</xsl:text>
            </xsl:if>
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="elml:cdRom">
        <xsl:param name="comment"/>
        <xsl:param name="furtherReading"/>
        <xsl:param name="pageNr"/>
        <li>
            <xsl:if test="not($furtherReading)">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="elml:author_year"/>
            <xsl:if test="@title">
                <i class="bibTitle">
                    <xsl:value-of select="@title"/>
                </i>
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
            <xsl:call-template name="elml:text_download"/>
            <xsl:if test="$comment">
                <span class="bibCommentFurther">
                    <br/>
                    <xsl:value-of select="$comment"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>
</xsl:stylesheet>
