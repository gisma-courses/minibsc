<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
    xmlns:config="urn:oasis:names:tc:opendocument:xmlns:config:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
    xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
    xmlns:presentation="urn:oasis:names:tc:opendocument:xmlns:presentation:1.0"
    xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0"
    xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0"
    xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
    xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
    xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
    xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
    xmlns:anim="urn:oasis:names:tc:opendocument:xmlns:animation:1.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:xforms="http://www.w3.org/2002/xforms"
    xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
    xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
    xmlns:smil="urn:oasis:names:tc:opendocument:xmlns:smil-compatible:1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.elml.ch"
    exclude-result-prefixes="xsl office meta config text table draw presentation dr3d chart form
    script style number anim dc xlink math xforms fo svg smil">
    <xsl:import href="attributes.xsl"/>
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <xsl:apply-templates
            select="office:document/office:body/office:text/text:section/text:h[@text:style-name='ElmlLesson']"
        />
    </xsl:template>

    <!-- LESSON -->
    <xsl:template match="text:h[@text:style-name='ElmlLesson']">
        <lesson xsi:schemaLocation="http://www.elml.ch ../../../_config/validate.xsd" 
            xmlns="http://www.elml.ch">
            <xsl:attribute name="title">
                <xsl:value-of select="text()"/>
            </xsl:attribute>

            <xsl:call-template name="label">
                <xsl:with-param name="labelNode" select="parent::text:section"/>
            </xsl:call-template>

            <xsl:call-template name="navTitle">
                <xsl:with-param name="navTitleNode"
                    select="descendant::text:variable-set[@text:name='navTitle']"/>
            </xsl:call-template>

            <xsl:call-template name="entry">
                <xsl:with-param name="entryNode"
                    select="../following-sibling::text:section[1][text:p[@text:style-name='ElmlEntry'][1]]"
                />
            </xsl:call-template>

            <xsl:call-template name="goals">
                <xsl:with-param name="goalNode"
                    select="../following-sibling::text:section[2][text:p[@text:style-name='ElmlGoals'][1]]"
                />
            </xsl:call-template>

            <xsl:if
                test="../following-sibling::text:section[3]/text:h[@text:style-name = 'ElmlUnit']">
                <xsl:call-template name="unit">
                    <xsl:with-param name="unitNode"
                        select="../following-sibling::text:section[3][text:h[@text:style-name = 'ElmlUnit']]"
                    />
                </xsl:call-template>
            </xsl:if>

            <xsl:if
                test="../following-sibling::text:section/text:p[@text:style-name = 'ElmlSummary']">
                <xsl:call-template name="summary">
                    <xsl:with-param name="summaryNode"
                        select="../following-sibling::text:section[text:p[@text:style-name='ElmlSummary']]"
                    />
                </xsl:call-template>
            </xsl:if>

            <xsl:call-template name="glossary">
                <xsl:with-param name="glossaryNode"
                    select="../following-sibling::text:section[@text:name='glossary']"/>
            </xsl:call-template>

            <xsl:call-template name="bibliography">
                <xsl:with-param name="bibliographyNode"
                    select="../following-sibling::text:section[@text:name='bibliography']"/>
            </xsl:call-template>

        </lesson>
    </xsl:template>

    <!-- ENTRY -->
    <xsl:template name="entry">
        <xsl:param name="entryNode"/>
        <xsl:if test="$entryNode/text:p[@text:style-name = 'ElmlEntry']">
            <xsl:choose>
                <xsl:when test="$entryNode=''">
                    <entry> </entry>
                </xsl:when>
                <xsl:otherwise>
                    <entry title="{$entryNode}">
                        <xsl:call-template name="content">
                            <xsl:with-param name="contentContext"
                                select="$entryNode/following-sibling::*[1]"/>
                        </xsl:call-template>
                    </entry>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- GOALS -->
    <xsl:template name="goals">
        <xsl:param name="goalNode"/>
        <xsl:if test="$goalNode/text:p[@text:style-name = 'ElmlGoals']">
            <goals> </goals>
        </xsl:if>
    </xsl:template>

    <!-- UNIT -->
    <xsl:template name="unit">
        <xsl:param name="unitNode"/>
        <xsl:if test="$unitNode/text:h[@text:style-name = 'ElmlUnit']">
            <unit>
                <xsl:attribute name="title">
                    <xsl:value-of select="$unitNode/text:h/text()"/>
                </xsl:attribute>

                <xsl:call-template name="label">
                    <xsl:with-param name="labelNode" select="$unitNode"/>
                </xsl:call-template>

                <xsl:call-template name="navTitle">
                    <xsl:with-param name="navTitleNode"
                        select="$unitNode/descendant::text:variable-set[@text:name='navTitle']"/>
                </xsl:call-template>

                <xsl:call-template name="entry">
                    <xsl:with-param name="entryNode"
                        select="$unitNode/following-sibling::text:section[1][text:p[@text:style-name='ElmlEntry']]"
                    />
                </xsl:call-template>

                <xsl:call-template name="goals">
                    <xsl:with-param name="goalNode"
                        select="$unitNode/following-sibling::text:section[2][text:p[1][@text:style-name='ElmlGoals']]"
                    />
                </xsl:call-template>

                <xsl:call-template name="learningObj">
                    <xsl:with-param name="loNode"
                        select="$unitNode/following-sibling::text:section[text:h[@text:style-name='ElmlLearningObject']][1]"
                    />
                    <xsl:with-param name="unitParent" select="$unitNode/@text:name"/>
                </xsl:call-template>

            </unit>

            <xsl:if
                test="$unitNode/following-sibling::text:section/text:h[@text:style-name='ElmlUnit']">
                <xsl:call-template name="unit">
                    <xsl:with-param name="unitNode"
                        select="$unitNode/following-sibling::text:section[text:h[@text:style-name =
                        'ElmlUnit']][1]"
                    />
                </xsl:call-template>
            </xsl:if>

        </xsl:if>
    </xsl:template>

    <!-- LEARNINGOBJECT -->
    <xsl:template name="learningObj">
        <xsl:param name="loNode"/>
        <xsl:param name="unitParent"/>
        <xsl:variable name="currentParent">
            <xsl:value-of
                select="$loNode/preceding-sibling::text:section[text:h[@text:style-name='ElmlUnit']][1]/@text:name"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$loNode/text:h[@text:style-name = 'ElmlUnit']"> </xsl:when>
            <xsl:when test="($loNode/text:h[@text:style-name = 'ElmlLearningObject']) and
                ($unitParent=$currentParent)">
                <learningObject>
                    <xsl:attribute name="title">
                        <xsl:value-of select="$loNode/text:h/text()"/>
                    </xsl:attribute>

                    <xsl:call-template name="label">
                        <xsl:with-param name="labelNode" select="$loNode"/>
                    </xsl:call-template>

                    <xsl:call-template name="navTitle">
                        <xsl:with-param name="navTitleNode"
                            select="$loNode/descendant::text:variable-set[@text:name='navTitle']"/>
                    </xsl:call-template>

                    <xsl:call-template name="contentElements">
                        <xsl:with-param name="contentNode"
                            select="$loNode/following-sibling::text:section[text:h[@text:style-name='ElmlClarify'
                            or @text:style-name='ElmlLook' or @text:style-name='ElmlAct']][1]"
                        />
                    </xsl:call-template>

                </learningObject>

                <xsl:if
                    test="$loNode/following-sibling::text:section[text:h[@text:style-name='ElmlLearningObject']]">
                    <xsl:call-template name="learningObj">
                        <xsl:with-param name="loNode"
                            select="$loNode/following-sibling::text:section[text:h][1]"/>
                        <xsl:with-param name="unitParent" select="$unitParent"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>
            <xsl:when
                test="$loNode/text:h[@text:style-name = 'ElmlClarify' or
            @text:style-name='ElmlLook' or @text:style-name='ElmlAct']">
                <xsl:if
                    test="$loNode/following-sibling::text:section[text:h[@text:style-name='ElmlLearningObject']]">
                    <xsl:call-template name="learningObj">
                        <xsl:with-param name="loNode"
                            select="$loNode/following-sibling::text:section[text:h][1]"/>
                        <xsl:with-param name="unitParent" select="$unitParent"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- CONTENT ELEMENTs -->
    <xsl:template name="contentElements">
        <xsl:param name="contentNode"/>
        <xsl:choose>
            <xsl:when test="$contentNode/text:h[@text:style-name = 'ElmlClarify']">
                <xsl:call-template name="clarify">
                    <xsl:with-param name="clarifyNode" select="$contentNode"/>
                </xsl:call-template>
                <xsl:if
                    test="$contentNode/following-sibling::text:section[1][text:h[@text:style-name='ElmlClarify' or
                    @text:style-name='ElmlLook' or @text:style-name='ElmlAct']]">
                    <xsl:call-template name="contentElements">
                        <xsl:with-param name="contentNode"
                            select="$contentNode/following-sibling::text:section[1][text:h]"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$contentNode/text:h[@text:style-name = 'ElmlLook']">
                <xsl:call-template name="look">
                    <xsl:with-param name="lookNode" select="$contentNode"/>
                </xsl:call-template>

                <xsl:if
                    test="$contentNode/following-sibling::text:section[text:h[1][@text:style-name='ElmlClarify' or
                    @text:style-name='ElmlLook' or @text:style-name='ElmlAct']]">
                    <xsl:call-template name="contentElements">
                        <xsl:with-param name="contentNode"
                            select="$contentNode/following-sibling::text:section[1][text:h]"/>
                    </xsl:call-template>
                </xsl:if>

            </xsl:when>
            <xsl:when test="$contentNode/text:h[@text:style-name = 'ElmlAct']">
                <xsl:call-template name="act">
                    <xsl:with-param name="actNode" select="$contentNode"/>
                </xsl:call-template>

                <xsl:if
                    test="$contentNode/following-sibling::text:section[text:h[1][@text:style-name='ElmlClarify' or
                    @text:style-name='ElmlLook' or @text:style-name='ElmlAct']]">
                    <xsl:call-template name="contentElements">
                        <xsl:with-param name="contentNode"
                            select="$contentNode/following-sibling::text:section[1][text:h]"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- CLARIFY -->
    <xsl:template name="clarify">
        <xsl:param name="clarifyNode"/>
        <xsl:choose>
            <xsl:when test="$clarifyNode/text:h[@text:style-name = 'ElmlClarify']">
                <clarify>
                    <xsl:if test="$clarifyNode/text:h!=''">
                        <xsl:attribute name="title">
                            <xsl:value-of select="$clarifyNode"/>
                        </xsl:attribute>
                    </xsl:if>

                    <xsl:call-template name="content">
                        <xsl:with-param name="contentContext"
                            select="$clarifyNode/following-sibling::node()[1]"/>
                    </xsl:call-template>
                </clarify>
            </xsl:when>
            <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- LOOK -->
    <xsl:template name="look">
        <xsl:param name="lookNode"/>
        <xsl:choose>
            <xsl:when test="$lookNode/text:h[@text:style-name = 'ElmlLook']">
                <look>
                    <xsl:if test="$lookNode/text:h!=''">
                        <xsl:attribute name="title">
                            <xsl:value-of select="$lookNode"/>
                        </xsl:attribute>
                    </xsl:if>

                    <xsl:call-template name="content">
                        <xsl:with-param name="contentContext"
                            select="$lookNode/following-sibling::*[1]"/>
                    </xsl:call-template>
                </look>
            </xsl:when>
            <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- ACT -->
    <xsl:template name="act">
        <xsl:param name="actNode"/>
        <xsl:choose>
            <xsl:when test="$actNode/text:h[@text:style-name = 'ElmlAct']">
                <act>
                    <xsl:if test="$actNode/text:h!=''">
                        <xsl:attribute name="title">
                            <xsl:value-of select="$actNode"/>
                        </xsl:attribute>
                    </xsl:if>

                    <xsl:call-template name="content">
                        <xsl:with-param name="contentContext" select="$actNode/following-sibling::*[1]"
                        />
                    </xsl:call-template>
                </act>
            </xsl:when>
            <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- SUMMARY -->
    <xsl:template name="summary">
        <xsl:param name="summaryNode"/>
        <xsl:if test="$summaryNode/text:p[@text:style-name = 'ElmlSummary']">
            <xsl:choose>
                <xsl:when test="$summaryNode=''">
                    <summary>
                        <xsl:call-template name="label">
                            <xsl:with-param name="labelNode" select="$summaryNode"/>
                        </xsl:call-template>

                        <xsl:call-template name="navTitle">
                            <xsl:with-param name="navTitleNode"
                                select="$summaryNode/descendant::text:variable-set[@text:name='navTitle']"
                            />
                        </xsl:call-template>
                    </summary>
                </xsl:when>
                <xsl:otherwise>
                    <summary title="{$summaryNode}">
                        <xsl:call-template name="label">
                            <xsl:with-param name="labelNode" select="$summaryNode"/>
                        </xsl:call-template>

                        <xsl:call-template name="navTitle">
                            <xsl:with-param name="navTitleNode"
                                select="$summaryNode/descendant::text:variable-set[@text:name='navTitle']"
                            />
                        </xsl:call-template>

                        <xsl:call-template name="content">
                            <xsl:with-param name="contentContext"
                                select="$summaryNode/following-sibling::*[1]"/>
                        </xsl:call-template>
                    </summary>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- GLOSSARY -->
    <xsl:template name="glossary">
        <xsl:param name="glossaryNode"/>
        <xsl:if
            test="$glossaryNode/following-sibling::text:section[1]/text:p[@text:style-name='ElmlDefinition']">
            <glossary>

                <xsl:call-template name="visible">
                    <xsl:with-param name="visibleNode"
                        select="$glossaryNode/descendant::text:variable-set[@text:name='visible']"/>
                </xsl:call-template>

                <xsl:call-template name="definition">
                    <xsl:with-param name="definitionNode"
                        select="$glossaryNode/following-sibling::*[1]"/>
                </xsl:call-template>

            </glossary>
        </xsl:if>
    </xsl:template>

    <!-- DEFINITION -->
    <xsl:template name="definition">
        <xsl:param name="definitionNode"/>
        <xsl:if test="$definitionNode[text:p/@text:style-name='ElmlDefinition']">
            <definition>
                <xsl:if test="$definitionNode[@text:name]">
                    <xsl:attribute name="term">
                        <xsl:value-of select="$definitionNode/@text:name"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of
                    select="substring-after($definitionNode/text:p[@text:style-name='ElmlDefinition'], ':')"
                />
            </definition>

            <xsl:call-template name="definition">
                <xsl:with-param name="definitionNode"
                    select="$definitionNode/following-sibling::*[1]"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <!-- BIBLIOGRAPHY -->
    <xsl:template name="bibliography">
        <xsl:param name="bibliographyNode"/>
        <xsl:if test="$bibliographyNode/following-sibling::text:section[1]/text:p">
            <bibliography>

                <xsl:call-template name="visible">
                    <xsl:with-param name="visibleNode"
                        select="$bibliographyNode/descendant::text:variable-set[@text:name='visible']"/>
                </xsl:call-template>

                <xsl:call-template name="sorting">
                    <xsl:with-param name="sortingNode"
select="$bibliographyNode/descendant::text:variable-set[@text:name='sorting']"/>
                </xsl:call-template>
                
                <xsl:call-template name="bibEntry">
                    <xsl:with-param name="bibEntryNode"
                        select="$bibliographyNode/following-sibling::*[1]"/>
                </xsl:call-template>
                
            </bibliography>
        </xsl:if>
    </xsl:template>
    
    <!-- BIBENTRY -->
    <xsl:template name="bibEntry">
        <xsl:param name="bibEntryNode"/>
        <xsl:if test="$bibEntryNode[text:p/@text:style-name='ElmlBibEntry']">
            <xsl:variable name="type">
                <xsl:value-of select="$bibEntryNode/text:p/text:variable-set/@office:string-value"/>
            </xsl:variable>
            
            <xsl:choose>
                <xsl:when test="$type='Buch'">
                    <book>
                        <xsl:call-template name="bibID">
                            <xsl:with-param name="bibID" select="$bibEntryNode/@text:name"/>
                        </xsl:call-template>
                        <xsl:call-template name="author">
                            <xsl:with-param name="author"
                            select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibAuthor']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="publicationYear">
                            <xsl:with-param name="publicationYear"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibYear']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="bibTitle">
                            <xsl:with-param name="bibTitle"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibTitle']/text()"/>
                        </xsl:call-template>         
                        <xsl:call-template name="publisher">
                            <xsl:with-param name="publisher"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibPublisher']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="publicationPlace">
                            <xsl:with-param name="publicationPlace"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibPublicationPlace']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="edition">
                            <xsl:with-param name="edition"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibEdition']/text()"/>
                        </xsl:call-template>
                    </book>
                </xsl:when>
                <xsl:when test="$type='Buchauszug'">
                    <contributionInBook>
                        <xsl:call-template name="bibID">
                            <xsl:with-param name="bibID" select="$bibEntryNode/@text:name"/>
                        </xsl:call-template>
                        <xsl:call-template name="author">
                            <xsl:with-param name="author"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibAuthor']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="publicationYear">
                            <xsl:with-param name="publicationYear"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibYear']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="bibTitle">
                            <xsl:with-param name="bibTitle"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibTitle']/text()"/>
                        </xsl:call-template>  
                        <xsl:call-template name="contributionTitle">
                            <xsl:with-param name="contributionTitle"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibContributionTitle']/text()"/>
                        </xsl:call-template>        
                        <xsl:call-template name="publisher">
                            <xsl:with-param name="publisher"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibPublisher']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="publicationPlace">
                            <xsl:with-param name="publicationPlace"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibPublicationPlace']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="pageNr">
                            <xsl:with-param name="pageNr"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibPageNr']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="editor">
                            <xsl:with-param name="editor"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibEditor']/text()"/>
                        </xsl:call-template>
                    </contributionInBook>
                </xsl:when>
                <xsl:when test="$type='Artikel (Zeitschrift)'">
                    <journalArticle>
                        <xsl:call-template name="bibID">
                            <xsl:with-param name="bibID" select="$bibEntryNode/@text:name"/>
                        </xsl:call-template>
                        <xsl:call-template name="author">
                            <xsl:with-param name="author"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibAuthor']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="publicationYear">
                            <xsl:with-param name="publicationYear"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibYear']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="bibTitle">
                            <xsl:with-param name="bibTitle"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibContributionTitle']/text()"/>
                        </xsl:call-template>  
                        <xsl:call-template name="journalTitle">
                            <xsl:with-param name="journalTitle"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibTitle']/text()"/>
                        </xsl:call-template>    
                        <xsl:call-template name="volumeNr">
                            <xsl:with-param name="volumeNr"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibVolumeNr']/text()"/>
                        </xsl:call-template> 
                        <xsl:call-template name="pageNr">
                            <xsl:with-param name="pageNr"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibPageNr']/text()"/>
                        </xsl:call-template>    
                    </journalArticle>
                </xsl:when>
                <xsl:when test="$type='Webseite'">
                    <websites>
                        <xsl:call-template name="bibID">
                            <xsl:with-param name="bibID" select="$bibEntryNode/@text:name"/>
                        </xsl:call-template>
                        <xsl:call-template name="author">
                            <xsl:with-param name="author"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibAuthor']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="publicationYear">
                            <xsl:with-param name="publicationYear"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibYear']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="bibTitle">
                            <xsl:with-param name="bibTitle"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibTitle']/text()"/>
                        </xsl:call-template>  
                        <xsl:call-template name="publisher">
                            <xsl:with-param name="publisher"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibPublisher']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="publicationPlace">
                            <xsl:with-param name="publicationPlace"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibPublicationPlace']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="edition">
                            <xsl:with-param name="edition"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibEdition']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="url">
                            <xsl:with-param name="url"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibUrl']/text()"/>
                        </xsl:call-template>
                        <xsl:call-template name="accessedDate">
                            <xsl:with-param name="accessedDate"
                                select="$bibEntryNode/text:p/text:span[@text:style-name='ElmlBibAccessedDate']/text()"/>
                        </xsl:call-template>
                    </websites>
                </xsl:when>
            </xsl:choose>
            
            <xsl:call-template name="bibEntry">
                <xsl:with-param name="bibEntryNode"
                    select="$bibEntryNode/following-sibling::*[1]"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>


    <xsl:template name="content">
        <xsl:param name="contentContext"/>
        <xsl:if
            test="$contentContext[name() = 'text:p' or name() = 'text:list' or name() =
        'table:table' or name() = 'draw:frame']">

            <!--<xsl:text>HALLO</xsl:text>-->
            <xsl:apply-templates select="$contentContext"/>

            <xsl:if
                test="$contentContext/following-sibling::node()[1][name()='text:p' or
                name()='text:list' or name()='table:table' or name()='draw:frame']">

                <xsl:call-template name="content">
                    <xsl:with-param name="contentContext"
                        select="$contentContext/following-sibling::node()[1]"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="text:p[@text:style-name='ElmlParagraph']">
        <xsl:choose>
           <xsl:when test="descendant::node()[1][name()!='draw:frame']">
            <!--<xsl:when test="(descendant::node()[1][name()!='draw:frame']) or (descendant::node()[name()='draw:frame'] and
            descendant::text())">-->
                <paragraph>
                    <xsl:apply-templates/>
                </paragraph>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="draw:frame"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template
        match="text:p[@text:style-name!='ElmlParagraph' and parent::node()[name()!='table:table-cell']]">
        <xsl:variable name="style_old" select="@text:style-name"/>
        <xsl:variable name="style_new">
            <xsl:for-each select="//style:style[@style:name=$style_old]">
                <xsl:choose>
                    <xsl:when
                        test="@style:parent-style-name!='ElmlParagraph' and
                   @style:parent-style-name!='Standard'">
                        <xsl:value-of select="@style:parent-style-name"/>
                    </xsl:when>
                    <xsl:when
                        test="@style:parent-style-name!='ElmlParagraph' and
                       @style:parent-style-name='Standard'">
                        <xsl:value-of select="$style_old"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <paragraph>
            <xsl:call-template name="cssClass">
                <xsl:with-param name="cssClass" select="$style_new"/>
            </xsl:call-template>
            <xsl:apply-templates/>
        </paragraph>
    </xsl:template>

    <xsl:template match="text:list">
        <xsl:variable name="style_old" select="@text:style-name"/>
        <xsl:variable name="style_new">
            <xsl:for-each select="//text:list-style[@style:name=$style_old]">
                <xsl:choose>
                    <xsl:when test="./*[1][name()='text:list-level-style-number']">
                        <xsl:text>ordered</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="cssClass">
            <xsl:for-each select="//text:list-style[@style:name=$style_old]">
                <xsl:if test="parent::node()[name()='office:styles']">
                    <xsl:value-of select="@style:name"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <list>
            <xsl:call-template name="listStyle">
                <xsl:with-param name="listStyle" select="$style_new"/>
            </xsl:call-template>
            <xsl:call-template name="cssClass">
                <xsl:with-param name="cssClass" select="$cssClass"/>
            </xsl:call-template>
            <xsl:apply-templates/>
        </list>
    </xsl:template>

    <xsl:template match="text:list-item">
        <xsl:element name="item">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="text:line-break">
        <xsl:element name="newLine"/>
    </xsl:template>

    <xsl:template match="text:span">
        <xsl:choose>
            <xsl:when test="./@text:style-name='ElmlCitation'">
                <xsl:variable name="bibRef">
                    <xsl:value-of
                        select="following-sibling::text:span[2][@text:style-name='ElmlCitationRef']"/>
                </xsl:variable>
                <citation>
                    <xsl:attribute name="bibIDRef">
                        <xsl:value-of select="$bibRef"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </citation>
            </xsl:when>
            <xsl:when test="./@text:style-name='ElmlCitationRef'">
                
            </xsl:when>
            <xsl:when test="./@text:style-name='ElmlBlank'">
                
            </xsl:when>
            <xsl:when test="./@text:style-name='BoxTitle'">
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="style_old" select="@text:style-name"/>
                <xsl:variable name="style_new">
                    <xsl:for-each select="//style:style[@style:name=$style_old]">
                        <xsl:if test="parent::node()[name()='office:automatic-styles']">
                            <xsl:choose>
                                <xsl:when test="style:text-properties[@fo:font-weight]">
                                    <xsl:value-of select="style:text-properties/@fo:font-weight"/>
                                </xsl:when>
                                <xsl:when test="style:text-properties[@fo:font-style]">
                                    <xsl:value-of select="style:text-properties/@fo:font-style"/>
                                </xsl:when>
                                <xsl:when test="style:text-properties[@style:text-underline-style]">
                                    <xsl:text>underlined</xsl:text>
                                </xsl:when>
                                <xsl:when
                                    test="contains(style:text-properties/@style:text-position, 'sub')">
                                    <xsl:text>subscript</xsl:text>
                                </xsl:when>
                                <xsl:when
                                    test="contains(style:text-properties/@style:text-position, 'super')">
                                    <xsl:text>superscript</xsl:text>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:variable name="cssClass">
                    <xsl:for-each select="//style:style[@style:name=$style_old]">
                        <xsl:if test="parent::node()[name()='office:styles']">
                            <xsl:value-of select="@style:name"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="parent::text:h"/>
                    <xsl:when test="(string-length($style_new) > 0) or (string-length($cssClass) > 0)">
                        <formatted>
                            <xsl:call-template name="style">
                                <xsl:with-param name="style" select="$style_new"/>
                            </xsl:call-template>
                            <xsl:call-template name="cssClass">
                                <xsl:with-param name="cssClass" select="$cssClass"/>
                            </xsl:call-template>
                            <xsl:value-of select="."/>
                        </formatted>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="text:a">
        <xsl:choose>
            <xsl:when test="@office:name">
                <xsl:variable name="linkvar" select="substring-after(@xlink:href,'#')"/>
                <xsl:element name="term">
                    <xsl:attribute name="glossRef">
                        <xsl:value-of select="substring-before($linkvar,'|')"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="text()"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="contains(@xlink:href,'://')">
                <xsl:element name="link">
                    <xsl:attribute name="uri">
                        <xsl:value-of select="@xlink:href"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="text()"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="contains(@xlink:href,'mailto:')">
                <xsl:element name="link">
                    <xsl:attribute name="uri">
                        <xsl:value-of select="@xlink:href"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="text()"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="not(contains(@xlink:href,'#'))">
                <xsl:element name="link">
                    <xsl:attribute name="uri">
                        <xsl:value-of select="@xlink:href"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="text()"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="linkvar" select="substring-after(@xlink:href,'#')"/>
                <xsl:element name="link">
                    <xsl:attribute name="targetLabel">
                        <xsl:value-of select="substring-before($linkvar,'|')"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="text()"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="draw:frame">
        <xsl:choose>
            <xsl:when test="descendant::node()[1][name()='draw:image']">
                <xsl:variable name="uri" select="descendant::draw:image/@xlink:href"/>
                <xsl:variable name="style" select="@draw:style-name"/>
                <xsl:variable name="align">
                    <xsl:for-each select="//style:style[@style:name=$style]">
                        <xsl:value-of select="style:graphic-properties/@style:horizontal-pos"/>
                    </xsl:for-each>
                </xsl:variable>
                <multimedia>
                    <xsl:call-template name="simplelabel">
                        <xsl:with-param name="label" select="@draw:name"/>
                    </xsl:call-template>
                    <xsl:call-template name="alignment">
                        <xsl:with-param name="align" select="$align"/>
                    </xsl:call-template>
                    <xsl:call-template name="width">
                        <xsl:with-param name="width"
                            select="round((number(substring-before(@svg:width,'cm'))) div 0.02646)"
                        />
                    </xsl:call-template>
                    <xsl:call-template name="height">
                        <xsl:with-param name="height"
                            select="round((number(substring-before(@svg:height,'cm'))) div 0.02646)"
                        />
                    </xsl:call-template>
                    <xsl:attribute name="units">
                        <xsl:text>pixels</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="src">
                        <xsl:text>../image/</xsl:text>
                        <xsl:call-template name="fileName">
                            <xsl:with-param name="string" select="$uri"/>
                        </xsl:call-template>
                    </xsl:attribute>
                    <xsl:call-template name="type">
                        <xsl:with-param name="typeEnding">
                            <xsl:call-template name="fileEnding">
                                <xsl:with-param name="string" select="$uri"/>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </multimedia>
            </xsl:when>


            <xsl:when test="descendant::node()[1][name()='draw:plugin']">
                <xsl:variable name="uri" select="descendant::draw:plugin/@xlink:href"/>
                <xsl:variable name="style" select="@draw:style-name"/>
                <xsl:variable name="align">
                    <xsl:for-each select="//style:style[@style:name=$style]">
                        <xsl:value-of select="style:graphic-properties/@style:horizontal-pos"/>
                    </xsl:for-each>
                </xsl:variable>
                <multimedia>
                    <xsl:call-template name="simplelabel">
                        <xsl:with-param name="label" select="@draw:name"/>
                    </xsl:call-template>
                    <xsl:call-template name="alignment">
                        <xsl:with-param name="align" select="$align"/>
                    </xsl:call-template>
                    <xsl:call-template name="width">
                        <xsl:with-param name="width"
                            select="round((number(substring-before(@svg:width,'cm'))) div 0.02646)"
                        />
                    </xsl:call-template>
                    <xsl:call-template name="height">
                        <xsl:with-param name="height"
                            select="round((number(substring-before(@svg:height,'cm'))) div 0.02646)"
                        />
                    </xsl:call-template>
                    <xsl:attribute name="units">
                        <xsl:text>pixels</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="src">
                        <xsl:text>../multimedia/</xsl:text>
                        <xsl:call-template name="fileName">
                            <xsl:with-param name="string" select="$uri"/>
                        </xsl:call-template>
                    </xsl:attribute>
                    <xsl:call-template name="type">
                        <xsl:with-param name="typeEnding">
                            <xsl:call-template name="fileEnding">
                                <xsl:with-param name="string" select="$uri"/>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </multimedia>
            </xsl:when>


            <xsl:when
                test="descendant::node()[1][name()='draw:text-box'] and
            descendant::text:p[1][@text:style-name='Illustration']">
                <xsl:variable name="uri" select="descendant::draw:text-box[1]/text:p/draw:frame/draw:image/@xlink:href"/>
                <xsl:variable name="style" select="@draw:style-name"/>
                <xsl:variable name="align">
                    <xsl:for-each select="//style:style[@style:name=$style]">
                        <xsl:value-of select="style:graphic-properties/@style:horizontal-pos"/>
                    </xsl:for-each>
                </xsl:variable>
                <multimedia>
                    <xsl:call-template name="simplelabel">
                        <xsl:with-param name="label" select="descendant::draw:frame/@draw:name"/>
                    </xsl:call-template>
                    <xsl:call-template name="alignment">
                        <xsl:with-param name="align" select="$align"/>
                    </xsl:call-template>
                    <xsl:call-template name="width">
                        <xsl:with-param name="width"
                            select="round((number(substring-before(@svg:width,'cm'))) div 0.02646)"
                        />
                    </xsl:call-template>
                    <!--  
                    <xsl:call-template name="height">
                        <xsl:with-param name="height"
                            select="round((number(substring-before(@svg:height,'cm'))) div 0.02646)"
                        />
                    </xsl:call-template>
                    -->
                    <xsl:attribute name="units">
                        <xsl:text>pixels</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="src">
                        <xsl:text>../image/</xsl:text>
                        <xsl:call-template name="fileName">
                            <xsl:with-param name="string" select="$uri"/>
                        </xsl:call-template>
                    </xsl:attribute>
                    <xsl:call-template name="type">
                        <xsl:with-param name="typeEnding">
                            <xsl:call-template name="fileEnding">
                                <xsl:with-param name="string" select="$uri"/>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="legend">
                        <xsl:with-param name="legend">
                            <xsl:value-of select="descendant::text:p"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </multimedia>
            </xsl:when>

            <xsl:when
                test="descendant::node()[1][name()='draw:text-box'] and
                descendant::text:p[1][@text:style-name!='Illustration']">
                <xsl:variable name="style" select="@draw:style-name"/>
                <box>
                    <xsl:call-template name="simplelabel">
                        <xsl:with-param name="label" select="@draw:name"/>
                    </xsl:call-template>
                    <xsl:if test="./draw:text-box/text:p/text:span[@text:style-name='BoxTitle']">
                        <xsl:call-template name="boxTitle">
                            <xsl:with-param name="boxTitle"
                                select="./draw:text-box/text:p/text:span[@text:style-name='BoxTitle']/text()"
                            />
                        </xsl:call-template>
                    </xsl:if>
                    <xsl:apply-templates/>
                </box>
            </xsl:when>

            <xsl:otherwise> </xsl:otherwise>

        </xsl:choose>
    </xsl:template>

    <!-- get the filename -->
    <xsl:template name="fileName">
        <xsl:param name="string"/>
        <xsl:choose>
            <!-- if the string contains the character... -->
            <xsl:when test="contains($string, '/')">
                <!-- call the template recursively... -->
                <xsl:call-template name="fileName">
                    <!-- with the string being the string after the character
                    -->
                    <xsl:with-param name="string" select="substring-after($string, '/')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- otherwise, return the value of the string -->
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- get the file ending -->
    <xsl:template name="fileEnding">
        <xsl:param name="string"/>
        <xsl:choose>
            <!-- if the string contains the character... -->
            <xsl:when test="contains($string, '.')">
                <!-- call the template recursively... -->
                <xsl:call-template name="fileEnding">
                    <!-- with the string being the string after the character
                    -->
                    <xsl:with-param name="string" select="substring-after($string, '.')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- otherwise, return the value of the string -->
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="table:table">
        <xsl:variable name="style_old" select="./@table:style-name"/>
        <xsl:variable name="rel_width">
            <xsl:for-each select="//style:style[@style:name=$style_old]">
                <xsl:value-of select="./style:table-properties/@style:rel-width"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="width">
            <xsl:for-each select="//style:style[@style:name=$style_old]">
                <xsl:value-of select="./style:table-properties/@style:width"/>
            </xsl:for-each>
        </xsl:variable>
        <table>
            <xsl:call-template name="simplelabel">
                <xsl:with-param name="label" select="./@table:name"/>
            </xsl:call-template>
            <xsl:if test="$width!=''">
                <xsl:attribute name="width">
                    <xsl:value-of
                        select="round((number(substring-before($width,'cm'))) div 0.02646)"/>
                </xsl:attribute>
                <xsl:attribute name="units">
                    <xsl:text>pixels</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="$rel_width!=''">
                <xsl:attribute name="width">
                    <xsl:value-of select="substring-before($rel_width,'%')"/>
                </xsl:attribute>
                <xsl:attribute name="units">
                    <xsl:text>percent</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="table:table-row"/>
        </table>
    </xsl:template>

    <xsl:template match="table:table-row">
        <tablerow>
            <xsl:apply-templates select="table:table-cell"/>
        </tablerow>
    </xsl:template>

    <xsl:template match="table:table-cell">
        <xsl:variable name="style_old" select="./text:p/@text:style-name"/>
        <xsl:variable name="style_new">
            <xsl:for-each select="//style:style[@style:name=$style_old]">
                <xsl:value-of select="./style:paragraph-properties/@fo:text-align"/>
            </xsl:for-each>
        </xsl:variable>
        <tabledata>
            <xsl:if test="./@table:number-columns-spanned">
                <xsl:attribute name="colspan">
                    <xsl:value-of select="./@table:number-columns-spanned"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="$style_new='end'">
                <xsl:attribute name="align">right</xsl:attribute>
            </xsl:if>
            <xsl:if test="$style_new='center'">
                <xsl:attribute name="align">center</xsl:attribute>
            </xsl:if>
            <xsl:call-template name="simplelabel">
                <xsl:with-param name="label"
                    select="./text:p/text:variable-set[@text:name='label']/@office:string-value"/>
            </xsl:call-template>
            <xsl:call-template name="cssClass">
                <xsl:with-param name="cssClass"
                    select="./text:p/text:variable-set[@text:name='cssClass']/@office:string-value"
                />
            </xsl:call-template>
            <xsl:apply-templates/>
        </tabledata>
    </xsl:template>

</xsl:stylesheet>
