<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns="http://docbook.org/ns/docbook"   xmlns:db="http://docbook.org/ns/docbook" xmlns:elml="http://www.elml.ch" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink">
    <!--DO NOT TOUCH ANYTHING IN THIS FILE! THESE ARE DEFAULT VALUES! -->
    <!--To personalize use the config and templates file of your project. See documentation. -->
    <!-- ******** IMPORT STATEMENTS ******** -->
    <!--The name of the file with the default titles (and other) names -->
    <xsl:import href="../terms.xsl"/>
    <xsl:import href="../params.xsl"/>
    <!--The name of the default bibliography file. Do change it in your online.xsl if you want to use another one! -->
    <xsl:import href="biblio_harvard.xsl"/>
    <!--The name of the default metadata file. Do change it in your online.xsl if you want to use another one! -->
    <xsl:import href="metadata_elml.xsl"/>
    <xsl:variable name="filename_suffix">
        <xsl:choose>
            <xsl:when test="//elml:multimedia/@type='mathml'">
                <xsl:text>.xml</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>.xml</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- ******** PARAMETERS ******** -->
    <!-- ******** OUTPUT DECL ******** -->
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" media-type="text/xml" name="docbookxml"/>
    <xsl:output method="text" omit-xml-declaration="yes" encoding="UTF-8" media-type="text/text" name="plaintext"/>
    <xsl:strip-space elements="*"/>
    <!-- ******* FUNCTIONS ***** -->
    <!-- createPath-function -->
    <xsl:function name="elml:get_pathODF">
        <xsl:param name="baseURI" as="xs:string"/>
        <xsl:param name="lessonlabel" as="xs:string"/>
        <xsl:variable name="pathODF_temp">
            <xsl:choose>
                <xsl:when test="contains($baseURI, '\')">
                    <xsl:value-of select="functx:substring-before-last($baseURI, concat('\', $lessonlabel,'\'))"/>
                    <xsl:text>\</xsl:text>
                    <xsl:value-of select="$lessonlabel"/>
                    <xsl:text>\</xsl:text>
                    <xsl:value-of select="$lang"/>
                    <xsl:text>\docbook\</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="functx:substring-before-last($baseURI, concat('/', $lessonlabel,'/'))"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$lessonlabel"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$lang"/>
                    <xsl:text>/docbook/</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="string(concat($pathODF_temp[1],$pathODF_temp[2],$pathODF_temp[3],$pathODF_temp[4],$pathODF_temp[5],$pathODF_temp[6],$pathODF_temp[7],$pathODF_temp[8]))"/>
    </xsl:function>
    <!-- ***** ROOT *****-->
    <xsl:template match="/">
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}docbook.xml" format="docbookxml">
            <xsl:choose>
                <xsl:when test="$multiple='on'">
                    <db:book version="5.0">
                        <xsl:call-template name="elml:Label"/>
                        <db:title>
                            <xsl:value-of select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/attribute::title"/>
                        </db:title>
                        <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                            <db:part>
                                <xsl:call-template name="elml:Label"/>
                                <db:title>
                                    <xsl:value-of select="/elml:lesson/attribute::title"/>
                                </db:title>
                                <xsl:call-template name="elml:generate_Title"/>
                                <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson"/>
                            </db:part>
                        </xsl:for-each>
                    </db:book>
                </xsl:when>
                <xsl:otherwise>
                    <db:book version="5.0">
                        <xsl:call-template name="elml:Label"/>
                        <db:title>
                            <xsl:value-of select="/elml:lesson/attribute::title"/>
                        </db:title>
                        <xsl:apply-templates select="/elml:lesson"/>
                    </db:book>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="elml:lesson">
        <!-- generate a info (of the information hold by metadata) if necessary -->
        <xsl:if test="(not(/elml:lesson/elml:metadata[@visible = 'online'])) or (not(/elml:lesson/elml:metadata[@role = 'student']))">
            <db:info>
                <xsl:for-each select="/elml:lesson/elml:metadata/elml:organisation">
                    <db:abstract>
                        <db:para>
                            <xsl:value-of>Level: </xsl:value-of>
                            <xsl:value-of select="@level"/>
                            <xsl:value-of>, </xsl:value-of>
                            <xsl:value-of>Module: </xsl:value-of>
                            <xsl:value-of select="@module"/>
                            <xsl:for-each select="/elml:lesson/elml:metadata/elml:organisation/elml:posNumber">
                                <xsl:value-of>Positon-Number: </xsl:value-of>
                                <xsl:value-of select="text()"/>
                            </xsl:for-each>
                            <xsl:for-each select="/elml:lesson/elml:metadata/elml:organisation/elml:previous">
                                <xsl:value-of>Previous: </xsl:value-of>
                                <xsl:value-of select="text()"/>
                            </xsl:for-each>
                            <xsl:for-each select="/elml:lesson/elml:metadata/elml:organisation/elml:following">
                                <xsl:value-of>Following: </xsl:value-of>
                                <xsl:value-of select="text()"/>
                            </xsl:for-each>

                        </db:para>
                    </db:abstract>
                </xsl:for-each>
                <xsl:for-each select="/elml:lesson/elml:metadata/elml:prerequisites">
                    <db:abstract>
                        <xsl:for-each select="/elml:lesson/elml:metadata/elml:prerequisites/*">
                            <db:para>
                                <xsl:value-of>Label: </xsl:value-of>
                                <xsl:value-of select="@label"/>


                                <xsl:if test="@priority">
                                    <xsl:value-of>, </xsl:value-of>

                                    <xsl:value-of>Priority: </xsl:value-of>
                                    <xsl:value-of select="@priority"/>

                                </xsl:if>
                            </db:para>

                        </xsl:for-each>
                    </db:abstract>
                </xsl:for-each>
                <xsl:for-each select="/elml:lesson/elml:metadata/elml:keywords">
                    <db:keywordset>
                        <xsl:for-each select="/elml:lesson/elml:metadata/elml:keywords/*">
                            <db:keyword>
                                <xsl:value-of select="text()"/>
                            </db:keyword>
                        </xsl:for-each>
                    </db:keywordset>
                </xsl:for-each>
                <xsl:for-each select="/elml:lesson/elml:metadata/elml:technical">
                    <db:releaseinfo>
                        <xsl:for-each select="/elml:lesson/elml:metadata/elml:technical/*">
                            <db:phrase>
                                <xsl:value-of>Type: </xsl:value-of>
                                <xsl:value-of select="child::elml:type/text()"/>

                                <xsl:value-of>, </xsl:value-of>

                                <xsl:value-of>Name: </xsl:value-of>
                                <xsl:value-of select="child::elml:name/text()"/>

                                <xsl:value-of>, </xsl:value-of>

                                <xsl:value-of>Minimum-Version: </xsl:value-of>
                                <xsl:value-of select="child::elml:minimumVersion/text()"/>

                                <xsl:if test="child::elml:downloadURL or child::elml:installationRemarks">

                                    <xsl:value-of>, </xsl:value-of>

                                    <xsl:if test="child::elml:downloadURL">
                                        <xsl:value-of>Download-URL: </xsl:value-of>
                                        <xsl:value-of select="child::elml:downloadURL/text()"/>

                                    </xsl:if>
                                    <xsl:value-of>, </xsl:value-of>
                                    <xsl:if test="child::elml:installationRemarks">
                                        <xsl:value-of>Installation-Remarks: </xsl:value-of>
                                        <xsl:value-of select="child::elml:installationRemarks/text()"/>

                                    </xsl:if>

                                </xsl:if>
                            </db:phrase>
                        </xsl:for-each>
                    </db:releaseinfo>
                </xsl:for-each>
                <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessoninfo">
                    <db:abstract>
                        <db:para>

                            <xsl:value-of>Language: </xsl:value-of>
                            <xsl:value-of select="@level"/>
                            <xsl:value-of>, </xsl:value-of>
                            <xsl:value-of>Lanuage-Derived: </xsl:value-of>
                            <xsl:value-of select="@module"/>

                            <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:language">

                                <xsl:value-of>Language: </xsl:value-of>
                                <xsl:value-of select="@language"/>
                                <xsl:value-of>, </xsl:value-of>
                                <xsl:value-of>Lanuage-Derived: </xsl:value-of>
                                <xsl:value-of select="@derived"/>
                                <xsl:if test="@originalLanguage">
                                    <xsl:value-of>, </xsl:value-of>
                                    <xsl:value-of>Language-Original: </xsl:value-of>
                                    <xsl:value-of select="@originalLanguage"/>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:educational">
                                <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:educational/elml:typicalLearningTime">
                                    <xsl:value-of>, </xsl:value-of>
                                    <xsl:value-of>Typical-Learning-Time: </xsl:value-of>
                                    <xsl:value-of select="child::elml:time"/>
                                    <xsl:if test="child::elml:description/text()">
                                        <xsl:value-of>, </xsl:value-of>
                                        <xsl:value-of>Description: </xsl:value-of>
                                        <xsl:value-of select="child::elml:description/text()"/>
                                    </xsl:if>
                                </xsl:for-each>
                                <xsl:if test="@difficulty">
                                    <xsl:value-of>, </xsl:value-of>
                                    <xsl:value-of>Difficulty: </xsl:value-of>
                                    <xsl:value-of select="@difficulty"/>
                                </xsl:if>
                            </xsl:for-each>

                            <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle">
                                <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecyle/elml:version"> </xsl:for-each>
                                <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:contribute">
                                    <!-- -->
                                    <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:person">
                                        <xsl:value-of>, </xsl:value-of>
                                        <xsl:value-of>Responsible: </xsl:value-of>

                                        <xsl:value-of select="@responible"/>

                                        <xsl:value-of>, </xsl:value-of>
                                        <xsl:value-of>Person-Name: </xsl:value-of>

                                        <xsl:value-of select="@name"/>


                                        <xsl:value-of>, </xsl:value-of>
                                        <xsl:value-of>e-Mail: </xsl:value-of>

                                        <xsl:value-of select="@email"/>

                                        <xsl:value-of>, </xsl:value-of>
                                        <xsl:value-of>Institute: </xsl:value-of>

                                        <xsl:value-of select="@institute"/>

                                        <xsl:value-of>, </xsl:value-of>
                                        <xsl:value-of>Departement: </xsl:value-of>

                                        <xsl:value-of select="@departement"/>
                                    </xsl:for-each>
                                    <!-- -->
                                </xsl:for-each>
                                <xsl:if test="child::elml:commentsNextVersion">
                                    <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:commentsNextVersion">

                                        <xsl:value-of>, </xsl:value-of>
                                        <xsl:value-of>Comments-For-Next-Versio: </xsl:value-of>
                                        <xsl:value-of select="child::elml:commentsNextVersion/text()"/>

                                    </xsl:for-each>
                                </xsl:if>
                            </xsl:for-each>

                        </db:para>
                    </db:abstract>
                </xsl:for-each>
                <xsl:for-each select="/elml:lesson/elml:metadata/elml:rights">
                    <db:legalnotice>
                        <db:para>
                            <xsl:value-of>Cost: </xsl:value-of>
                            <xsl:value-of select="child::elml:cost"/>

                            <xsl:value-of>, </xsl:value-of>

                            <xsl:value-of>Copyright: </xsl:value-of>
                            <xsl:value-of select="child::elml:copyright"/>


                            <xsl:if test="@copyrightURL or @description">

                                <xsl:value-of>, </xsl:value-of>

                                <xsl:if test="@copyrightURL">
                                    <xsl:value-of>Copyright-URL: </xsl:value-of>
                                    <xsl:value-of select="@copyrightURL"/>

                                </xsl:if>
                                <xsl:value-of>, </xsl:value-of>
                                <xsl:if test="@description">
                                    <xsl:value-of>Description: </xsl:value-of>
                                    <xsl:value-of select="@description"/>

                                </xsl:if>

                            </xsl:if>
                        </db:para>
                    </db:legalnotice>
                </xsl:for-each>
            </db:info>


        </xsl:if>

        <xsl:apply-templates/>

        <!-- generate a glossary if necessary -->
        <xsl:if test="not(/elml:lesson/elml:glossary[@visible = 'online'])">
            <db:glossary>
                <xsl:for-each select="/elml:lesson/elml:glossary/elml:definition">
                    <db:glossentry>
                        <xsl:element name="db:glossterm">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="/elml:lesson/@label"/>
                                <xsl:value-of>_</xsl:value-of>
                                <xsl:value-of select="translate(@term,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                            </xsl:attribute>
                            <xsl:value-of select="@term"/>
                        </xsl:element>
                        <db:glossdef>
                            <db:para>
                                <xsl:apply-templates mode="inline"/>
                            </db:para>
                        </db:glossdef>
                    </db:glossentry>
                </xsl:for-each>
            </db:glossary>
        </xsl:if>
       
    </xsl:template>
    <xsl:template match="elml:bibliography">
        <xsl:if test="not(/elml:lesson/elml:bibliography[@visible = 'online'])">
        <!-- generate a bibliography if necessary -->
        <db:bibliography>
            <db:title>Bibliography</db:title>
        <xsl:choose>
            <xsl:when test="@sorting='off'">
                <db:bibliomixed>
                
                    <xsl:apply-templates/>
                
                </db:bibliomixed></xsl:when>
            <xsl:when test="@sorting='byYear'">
                <db:bibliomixed>
                
                    <xsl:apply-templates>
                        <xsl:sort select="@publicationYear" order="descending" lang="{$lang}"/>
                    </xsl:apply-templates>
            
                </db:bibliomixed></xsl:when>
            <xsl:when test="@sorting='groupByType'">
               
                <xsl:for-each-group select="node()" group-by="name()">
                    <xsl:sort select="name()" order="ascending" lang="{$lang}"/>
                    <db:bibliodiv>
                    <db:title>
                        <xsl:call-template name="elml:name_biblio">
                            <xsl:with-param name="itemname" select="name()"/>
                        </xsl:call-template>
                    </db:title>
                    <db:bibliomixed>
                   
                        <xsl:apply-templates select="current-group()">
                            <xsl:sort select="@author" order="ascending" lang="{$lang}"/>
                        </xsl:apply-templates>
                    </db:bibliomixed></db:bibliodiv></xsl:for-each-group>
                    
                
            </xsl:when>
            <xsl:when test="@sorting='groupByYear'">
               
                <xsl:for-each-group select="node()" group-by="@publicationYear">
                    <xsl:sort select="@publicationYear" order="descending" lang="{$lang}"/>
                    <db:bibliodiv>
                    <db:title>
                        <xsl:value-of select="@publicationYear"/>
                    </db:title>
                    <db:bibliomixed>
                    
                        <xsl:apply-templates select="current-group()">
                            <xsl:sort select="@author" order="ascending" lang="{$lang}"/>
                        </xsl:apply-templates>
                    </db:bibliomixed></db:bibliodiv></xsl:for-each-group>
                   
                
            </xsl:when>
            <xsl:otherwise>
                <db:bibliomixed>
              
                    <xsl:apply-templates>
                        <xsl:sort select="@author" order="ascending" lang="{$lang}"/>
                    </xsl:apply-templates>
        
                </db:bibliomixed></xsl:otherwise>
        </xsl:choose>
        </db:bibliography>
            </xsl:if>
    </xsl:template>
   <xsl:template name="bibliographyWithMoreSemanticsButNotUsedAtTheMoment">
        <!-- generate a bibliography if necessary -->
        <xsl:if test="not(/elml:lesson/elml:bibliography[@visible = 'online'])">
            <db:bibliography>
                <xsl:for-each select="/elml:lesson/elml:bibliography/*">
                    <db:biblioentry>
                        <xsl:attribute name="xreflabel">
                            <xsl:value-of select="@bibID"/>
                        </xsl:attribute>
                        <!-- id -->
                        <db:biblioid>
                            <xsl:value-of select="@bibID"/>
                        </db:biblioid>
                        <!-- title -->
                        <xsl:choose>
                            <xsl:when test="name()='mailLists' or name()='personalMail'">
                                <xsl:if test="@subject">
                                    <db:title>
                                        <xsl:value-of select="@subject"/>
                                    </db:title>
                                </xsl:if>
                            </xsl:when>
                            <xsl:when test="name()='contributionInBook' or name()='conferencePaper'">
                                <xsl:if test="@titleOfContribution">
                                    <db:title>
                                        <xsl:value-of select="@titleOfContribution"/>
                                    </db:title>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="@title">
                                    <db:title>
                                        <xsl:value-of select="@title"/>
                                    </db:title>
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                        <!-- date -->
                        <xsl:choose>
                            <xsl:when test="name()='mailLists' or name()='personalMail'">
                                <xsl:if test="@dayMonthYear">
                                    <db:pubdate>
                                        <xsl:value-of select="@dayMonthYear"/>
                                    </db:pubdate>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="@publicationYear">
                                    <db:pubdate>
                                        <xsl:value-of select="@publicationYear"/>
                                    </db:pubdate>
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                        <!-- author -->
                        <xsl:if test="@author">
                            <db:author>
                                <xsl:choose>
                                    <xsl:when test="name()='publicationCorporateBody'">
                                        <db:orgname>
                                            <xsl:value-of select="@author"/>
                                        </db:orgname>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <db:personname>
                                            <xsl:value-of select="@author"/>
                                        </db:personname>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:author>
                        </xsl:if>
                        <xsl:if test="@publisher">
                            <db:publisher>
                                <db:publishername>
                                    <xsl:value-of select="@publisher"/>
                                </db:publishername>
                                <xsl:if test="@publicationPlace">
                                    <db:address>
                                        <xsl:value-of select="@publicationPlace"/>
                                    </db:address>
                                </xsl:if>
                            </db:publisher>
                        </xsl:if>
                        <xsl:if test="@edition">
                            <db:edition>
                                <xsl:value-of select="@edition"/>
                            </db:edition>
                        </xsl:if>
                        <xsl:if test="@editor">
                            <db:editor>
                                <db:personname>
                                    <xsl:value-of select="@editor"/>
                                </db:personname>
                            </db:editor>
                        </xsl:if>
                        <xsl:if test="@downloadURL">
                            <db:extendedlink>
                                <xsl:element name="db:arc">
                                    <xsl:attribute name="xlink:to">
                                        <xsl:value-of select="@edition"/>
                                    </xsl:attribute>
                                </xsl:element>
                            </db:extendedlink>
                        </xsl:if>
                        <xsl:if test="@pageNr">
                            <db:pagenums>
                                <xsl:value-of select="@pageNr"/>
                            </db:pagenums>
                        </xsl:if>
                        <xsl:if test="@volumeNr">
                            <db:volumenum>
                                <xsl:value-of select="@volumeNr"/>
                            </db:volumenum>
                        </xsl:if>
                        <xsl:if test="@dayMonth">
                            <db:date>
                                <xsl:value-of select="@dayMonth"/>
                            </db:date>
                        </xsl:if>
                    </db:biblioentry>
                </xsl:for-each>
            </db:bibliography>
        </xsl:if></xsl:template>
    <xsl:template match="elml:furtherReading">
        
       
            <db:bibliography>
                <db:title>Further Reading</db:title>
        <xsl:choose>
        <xsl:when test="@sorting='off'">
            <db:bibliomixed>
                <xsl:for-each select="elml:resItem">
                    <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]">
                        <xsl:with-param name="comment" select="text()"/>
                        <xsl:with-param name="furtherReading" select="@bibIDRef"/>
                        <xsl:with-param name="pageNr" select="@pageNr"/>
                    </xsl:apply-templates>
                </xsl:for-each>
                </db:bibliomixed>
        </xsl:when>
        <xsl:when test="@sorting='byYear'">
            <db:bibliomixed>
                <xsl:for-each select="elml:resItem">
                    <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@publicationYear" order="descending" lang="{$lang}"/>
                    <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]">
                        <xsl:with-param name="comment" select="text()"/>
                        <xsl:with-param name="furtherReading" select="@bibIDRef"/>
                        <xsl:with-param name="pageNr" select="@pageNr"/>
                    </xsl:apply-templates>
                </xsl:for-each>
                </db:bibliomixed>
        </xsl:when>
        <xsl:when test="@sorting='groupByType'">
            
            <xsl:for-each-group select="elml:resItem/@bibIDRef" group-by="/elml:lesson/elml:bibliography/*[@bibID=current()]/name()">
                
                <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/name()" order="ascending" lang="{$lang}"/>
                    <db:bibliodiv>
                    <db:title>
                    <xsl:call-template name="elml:name_biblio">
                        <xsl:with-param name="itemname" select="name(/elml:lesson/elml:bibliography/*[@bibID=current()])"/>
                    </xsl:call-template>
                </db:title>
                <db:bibliomixed>
                    <xsl:for-each select="current-group()">
                        <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@author" order="ascending" lang="{$lang}"/>
                        <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()]">
                            <xsl:with-param name="comment" select="../text()"/>
                            <xsl:with-param name="furtherReading" select="current()"/>
                            <xsl:with-param name="pageNr" select="../@pageNr"/>
                        </xsl:apply-templates>
                    </xsl:for-each>
                </db:bibliomixed>
            </db:bibliodiv>
            </xsl:for-each-group>
            </xsl:when>
        <xsl:when test="@sorting='groupByYear'">
        
            <xsl:for-each-group select="elml:resItem/@bibIDRef" group-by="/elml:lesson/elml:bibliography/*[@bibID=current()]/@publicationYear">
                <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@publicationYear" order="descending" lang="{$lang}"/>
                <db:bibliodiv>
                <db:title>
                    <xsl:value-of select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@publicationYear"/>
                </db:title>
                <db:bibliomixed>
                    <xsl:for-each select="current-group()">
                        <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@author"/>
                        <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()]">
                            <xsl:with-param name="comment" select="../text()"/>
                            <xsl:with-param name="furtherReading" select="current()"/>
                            <xsl:with-param name="pageNr" select="../@pageNr"/>
                        </xsl:apply-templates>
                    </xsl:for-each>
                </db:bibliomixed>
                </db:bibliodiv>
            </xsl:for-each-group>
        </xsl:when>
        <xsl:otherwise>
        <db:bibliomixed>
                <xsl:for-each select="elml:resItem">
                    <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@author" order="ascending" lang="{$lang}"/>
                    <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]">
                        <xsl:with-param name="comment" select="text()"/>
                        <xsl:with-param name="furtherReading" select="@bibIDRef"/>
                        <xsl:with-param name="pageNr" select="@pageNr"/>
                    </xsl:apply-templates>
                </xsl:for-each>
        </db:bibliomixed>
        </xsl:otherwise>
        </xsl:choose>
            </db:bibliography>
       
    </xsl:template>
    <xsl:template match="elml:furtherReadingWithMoreSemanticsButNotUsedAtTheMoment">
        <xsl:param name="display">
            
            <xsl:call-template name="elml:display"/>
            
        </xsl:param>
        <xsl:if test="$display='yes'">
            <db:bibliography>
                <xsl:apply-templates/>
            </db:bibliography>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:resItemWithMoreSemanticsButNotUsedAtTheMoment">
        <xsl:param name="bibIDRef">
            <xsl:value-of select="@bibIDRef"/>
        </xsl:param>
        <db:biblioentry>
            <!-- same as elml:citation -->
            <xsl:if test="/elml:lesson/elml:bibliography/*[@bibID=$bibIDRef]">
                <xsl:choose>
                    <xsl:when test="not(@yearOnly='yes')">
                        <xsl:for-each select="/elml:lesson/elml:bibliography/*[@bibID=$bibIDRef]">
                            <xsl:if test="@author or @publicationyear">
                                <db:author>
                                    <db:personname>
                                        <xsl:if test="@author">
                                            <xsl:value-of select="@author"/>
                                        </xsl:if>
                                        <xsl:if test="@author and @publicationYear">
                                            <xsl:value-of select="' '"/>
                                        </xsl:if>
                                        <xsl:if test="@publicationYear">
                                            <xsl:value-of select="@publicationYear"/>
                                        </xsl:if>
                                    </db:personname>
                                </db:author>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="@publicationYear">
                            <db:author>
                                <db:personname>
                                    <xsl:value-of select="@publicationYear"/>
                                </db:personname>
                            </db:author>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <!-- end of same as elml:citation -->
            <xsl:apply-templates mode="inline"/>
        </db:biblioentry>
    </xsl:template>
    <xsl:template match="elml:unit">
        <xsl:choose>
            <xsl:when test="$multiple='on'">
                <db:chapter>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:call-template name="elml:generate_Title"/>
                    <xsl:apply-templates/>
                </db:chapter>
            </xsl:when>
            <xsl:otherwise>
                <db:part>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:call-template name="elml:generate_Title"/>
                    <xsl:apply-templates/>
                </db:part>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:learningObject">
        <xsl:choose>
            <xsl:when test="$multiple='on'">
                <db:section>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:call-template name="elml:generate_Title"/>
                    <xsl:apply-templates/>
                </db:section>
            </xsl:when>
            <xsl:otherwise>
                <db:chapter>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:call-template name="elml:generate_Title"/>
                    <xsl:apply-templates/>
                </db:chapter>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:entry">
        <xsl:choose>
            <xsl:when test="name(parent::*)='lesson'">
                <db:preface>
                    <xsl:call-template name="elml:Label"/>
                    <db:title>
                        <xsl:choose>
                            <xsl:when test="$lang = 'en'">
                                <xsl:value-of>
                                    <xsl:call-template name="elml:generate_Title"/>
                                </xsl:value-of>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of>
                                    <xsl:call-template name="elml:generate_Title"/>
                                </xsl:value-of>
                            </xsl:otherwise>
                        </xsl:choose>
                    </db:title>
                    <xsl:apply-templates/>
                    <xsl:call-template name="elml:setDefaultPara"/>
                </db:preface>
            </xsl:when>
            <xsl:when test="name(parent::*)='unit'">
                <xsl:choose>
                    <xsl:when test="$multiple='on'">
                        <db:section>
                            <xsl:call-template name="elml:Label"/>
                            <db:title>
                                <xsl:choose>
                                    <xsl:when test="$lang = 'en'">
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:title>
                            <xsl:apply-templates/>
                            <xsl:call-template name="elml:setDefaultPara"/>
                        </db:section>
                    </xsl:when>
                    <xsl:otherwise>
                        <db:partintro>
                            <xsl:call-template name="elml:Label"/>
                            <db:title>
                                <xsl:choose>
                                    <xsl:when test="$lang = 'en'">
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:title>
                            <xsl:apply-templates/>
                            <xsl:call-template name="elml:setDefaultPara"/>
                        </db:partintro>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="elml:goals">

        <xsl:choose>

            <xsl:when test="name(parent::*)='lesson'">
                <db:preface>
                    <db:title>
                        <xsl:choose>
                            <xsl:when test="$lang = 'en'">
                                <xsl:value-of>
                                    <xsl:call-template name="elml:generate_Title"/>
                                </xsl:value-of>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of>
                                    <xsl:call-template name="elml:generate_Title"/>
                                </xsl:value-of>
                            </xsl:otherwise>
                        </xsl:choose>
                    </db:title>
                    <xsl:for-each select="elml:lObjective">
                        <db:para>
                            <xsl:apply-templates mode="inline"/>
                        </db:para>
                    </xsl:for-each>
                </db:preface>
            </xsl:when>

            <xsl:when test="name(parent::*)='unit'">
                <xsl:choose>
                    <xsl:when test="$multiple='on'">
                        <db:section>
                            <db:title>
                                <xsl:choose>
                                    <xsl:when test="$lang = 'en'">
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:title>
                            <xsl:apply-templates/>
                            <xsl:for-each select="elml:lObjective">
                                <db:para>
                                    <xsl:apply-templates mode="inline"/>
                                </db:para>
                            </xsl:for-each>
                        </db:section>
                    </xsl:when>

                    <xsl:otherwise>
                        <db:chapter>
                            <db:title>
                                <xsl:choose>
                                    <xsl:when test="$lang = 'en'">
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:title>
                            <xsl:apply-templates/>
                            <xsl:for-each select="elml:lObjective">
                                <db:para>
                                    <xsl:apply-templates mode="inline"/>
                                </db:para>
                            </xsl:for-each>
                        </db:chapter>
                    </xsl:otherwise>

                </xsl:choose>

            </xsl:when>

        </xsl:choose>

    </xsl:template>

    <xsl:template match="elml:lObjective">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>

        <xsl:if test="$display='yes'">
            <xsl:apply-templates/>
        </xsl:if>

    </xsl:template>

    <xsl:template match="elml:summary">
        <xsl:choose>
            <xsl:when test="name(parent::*)='lesson'">
                <xsl:choose>
                    <xsl:when test="$multiple='on'">
                        <db:chapter>
                            <xsl:call-template name="elml:Label"/>
                            <db:title>
                                <xsl:choose>
                                    <xsl:when test="$lang = 'en'">
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:title>
                            <db:section>
                                <xsl:call-template name="elml:Label"/>
                                <xsl:choose>
                                    <xsl:when test="@title">
                                        <xsl:call-template name="elml:generate_Title"/>
                                        <xsl:apply-templates/>
                                        <xsl:call-template name="elml:setDefaultPara"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <db:title> </db:title>
                                        <xsl:apply-templates/>
                                        <xsl:call-template name="elml:setDefaultPara"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:section>
                        </db:chapter>
                    </xsl:when>
                    <xsl:otherwise>
                        <db:part>
                            <xsl:call-template name="elml:Label"/>
                            <db:title>
                                <xsl:choose>
                                    <xsl:when test="$lang = 'en'">
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:title>
                            <db:chapter>
                                <xsl:call-template name="elml:Label"/>
                                <xsl:choose>
                                    <xsl:when test="@title">
                                        <xsl:call-template name="elml:generate_Title"/>
                                        <xsl:apply-templates/>
                                        <xsl:call-template name="elml:setDefaultPara"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <db:title>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </db:title>
                                        <xsl:apply-templates/>
                                        <xsl:call-template name="elml:setDefaultPara"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:chapter>
                        </db:part>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="name(parent::*)='unit'">
                <xsl:choose>
                    <xsl:when test="$multiple='on'">
                        <db:section>
                            <xsl:call-template name="elml:Label"/>
                            <db:title>
                                <xsl:choose>
                                    <xsl:when test="$lang = 'en'">
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:title>
                            <xsl:apply-templates/>
                            <xsl:call-template name="elml:setDefaultPara"/>
                        </db:section>
                    </xsl:when>
                    <xsl:otherwise>
                        <db:chapter>
                            <xsl:call-template name="elml:Label"/>
                            <!-- 3 -->
                            <db:title>
                                <xsl:choose>
                                    <xsl:when test="$lang = 'en'">
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:title>
                            <xsl:apply-templates/>
                            <xsl:call-template name="elml:setDefaultPara"/>
                        </db:chapter>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:clarify">
        <xsl:choose>
            <xsl:when test="name(parent::*)='learningObject'">
                <db:section>
                    <xsl:call-template name="elml:Label"/>
                    <db:title>
                        <xsl:choose>
                            <xsl:when test="$lang = 'en'">
                                <xsl:value-of>
                                    <xsl:call-template name="elml:generate_Title"/>
                                </xsl:value-of>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of>
                                    <xsl:call-template name="elml:generate_Title"/>
                                </xsl:value-of>
                            </xsl:otherwise>
                        </xsl:choose>
                    </db:title>
                    <xsl:apply-templates/>
                    <xsl:call-template name="elml:setDefaultPara"/>
                </db:section>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:look">
        <xsl:choose>
            <xsl:when test="name(parent::*)='learningObject'">
                <db:section>
                    <xsl:call-template name="elml:Label"/>
                    <!-- 4 -->
                    <db:title>
                        <xsl:choose>
                            <xsl:when test="$lang = 'en'">
                                <xsl:value-of>
                                    <xsl:call-template name="elml:generate_Title"/>
                                </xsl:value-of>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of>
                                    <xsl:call-template name="elml:generate_Title"/>
                                </xsl:value-of>
                            </xsl:otherwise>
                        </xsl:choose>
                    </db:title>
                    <xsl:apply-templates/>
                    <xsl:call-template name="elml:setDefaultPara"/>
                </db:section>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:act">
        <xsl:choose>
            <xsl:when test="name(parent::*)='learningObject'">
                <db:section>
                    <xsl:call-template name="elml:Label"/>
                    <db:title>
                        <xsl:choose>
                            <xsl:when test="$lang = 'en'">
                                <xsl:value-of>
                                    <xsl:call-template name="elml:generate_Title"/>
                                </xsl:value-of>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of>
                                    <xsl:call-template name="elml:generate_Title"/>
                                </xsl:value-of>
                            </xsl:otherwise>
                        </xsl:choose>
                    </db:title>
                    <xsl:apply-templates/>
                    <xsl:call-template name="elml:setDefaultPara"/>
                </db:section>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:selfAssessment">
        <xsl:choose>
            <xsl:when test="name(parent::*)='lesson'">
                <xsl:choose>
                    <xsl:when test="$multiple='on'">
                        <db:chapter>
                            <xsl:call-template name="elml:Label"/>
                            <db:title>
                                <xsl:choose>
                                    <xsl:when test="$lang = 'en'">
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:title>
                            <db:section>
                                <xsl:call-template name="elml:Label"/>
                                <xsl:choose>
                                    <xsl:when test="@title">
                                        <xsl:call-template name="elml:generate_Title"/>
                                        <xsl:apply-templates/>
                                        <xsl:call-template name="elml:setDefaultPara"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <db:title> </db:title>
                                        <xsl:apply-templates/>
                                        <xsl:call-template name="elml:setDefaultPara"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:section>
                        </db:chapter>
                    </xsl:when>
                    <xsl:otherwise>
                        <db:part>
                            <xsl:call-template name="elml:Label"/>
                            <db:title>
                                <xsl:choose>
                                    <xsl:when test="$lang = 'en'">
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:title>
                            <db:chapter>
                                <xsl:call-template name="elml:Label"/>
                                <xsl:choose>
                                    <xsl:when test="@title">
                                        <xsl:call-template name="elml:generate_Title"/>
                                        <xsl:apply-templates/>
                                        <xsl:call-template name="elml:setDefaultPara"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <db:title>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </db:title>
                                        <xsl:apply-templates/>
                                        <xsl:call-template name="elml:setDefaultPara"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:chapter>
                        </db:part>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="name(parent::*)='unit'">
                <xsl:choose>
                    <xsl:when test="$multiple='on'">
                        <db:section>
                            <xsl:call-template name="elml:Label"/>
                            <db:title>
                                <xsl:choose>
                                    <xsl:when test="$lang = 'en'">
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:title>
                            <xsl:apply-templates/>
                            <xsl:call-template name="elml:setDefaultPara"/>
                        </db:section>
                    </xsl:when>
                    <xsl:otherwise>
                        <db:chapter>
                            <xsl:call-template name="elml:Label"/>
                            <!-- 3 -->
                            <db:title>
                                <xsl:choose>
                                    <xsl:when test="$lang = 'en'">
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>
                                            <xsl:call-template name="elml:generate_Title"/>
                                            <xsl:call-template name="elml:generate_Title"/>
                                        </xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:title>
                            <xsl:apply-templates/>
                            <xsl:call-template name="elml:setDefaultPara"/>
                        </db:chapter>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:selfCheck">
        <db:qandaset>
            <db:qandadiv>
                <xsl:call-template name="elml:Label"/>
                <xsl:call-template name="elml:generate_Title"/>
                <xsl:apply-templates/>
            </db:qandadiv>
        </db:qandaset>
    </xsl:template>
    <xsl:template match="elml:fillInBlanks">
        <db:para>
            <xsl:value-of select="child::elml:gapText"/>
        </db:para>
        <db:qandaentry>
            <db:question>
                <db:para>
                    <xsl:value-of select="child::elml:question"/>
                </db:para>
            </db:question>
        </db:qandaentry>
    </xsl:template>
    <xsl:template match="elml:multipleChoice">
        <db:qandaentry>
            <xsl:apply-templates/>
        </db:qandaentry>
    </xsl:template>
    <xsl:template match="elml:question">
        <db:question>
            <db:label>
                <xsl:value-of>Q: </xsl:value-of>
            </db:label>
            <db:para>
                <xsl:apply-templates mode="inline"/>
            </db:para>
        </db:question>
    </xsl:template>
    <xsl:template match="elml:answer">
        <xsl:choose>
            <xsl:when test="@correct='yes'">
                <db:answer>
                    <db:label>
                        <xsl:value-of>S: </xsl:value-of>
                    </db:label>
                    <db:para>
                        <xsl:apply-templates mode="inline"/>
                    </db:para>
                </db:answer>
            </xsl:when>
            <xsl:otherwise>
                <db:answer>
                    <db:label>
                        <xsl:value-of>A: </xsl:value-of>
                    </db:label>
                    <db:para>
                        <xsl:apply-templates mode="inline"/>
                    </db:para>
                </db:answer>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:solution">
        <db:answer>
            <db:label>
                <xsl:value-of>H: </xsl:value-of>
            </db:label>
            <db:para>
                <xsl:apply-templates mode="inline"/>
            </db:para>
        </db:answer>
    </xsl:template>
    <!-- ******** CONTENT ELEMENTS ******** -->
    <xsl:template match="text()" mode="inline">
        <xsl:param name="parent">
            <xsl:value-of select="node-name(parent::*)"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="parent::elml:term or parent::elml:definition or parent::elml:citation or parent::elml:answer or parent::elml:question or parent::elml:solution or parent::elml:indexItem or parent::elml:span">
                <xsl:value-of select="."/>
            </xsl:when>
            <xsl:when test="parent::elml:item or parent::elml:formatted">
                <db:phrase>
                    <xsl:value-of select="."/>
                </db:phrase>
            </xsl:when>
            <xsl:when test="parent::elml:paragraph">
                <!-- <xsl:processing-instruction name="breakLine"/> -->
                <db:phrase>
                    <xsl:if test="not(preceding-sibling::text())">
                        <xsl:call-template name="elml:Label"/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </db:phrase>
            </xsl:when>
        </xsl:choose>
        <!-- <xsl:choose>
            <xsl:when test="not(parent::elml:paragraph or parent::elml:formatted or parent::elml:indexTerm or parent::elml:citation or parent::elml:term or parent::elml:indexItem or parent::elml:link or parent::elml:option or parent::elml:gap or parent::elml:answer or parent::elml:item)">
            
            <xsl:comment><xsl:value-of select="$parent"/> ACHTUNG TEXT FEHLT!</xsl:comment>
            </xsl:when>
            <xsl:otherwise>
            <xsl:value-of select="."/>
            </xsl:otherwise>
            </xsl:choose> -->
    </xsl:template>
    <xsl:template match="text()">
        <xsl:param name="parent">
            <xsl:value-of select="node-name(parent::*)"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="parent::elml:columnLeft |parent::elml:columnMiddle | parent::elml:columnRight | parent::elml:tabledata | parent::elml:tableheading | parent::elml:item | parent::elml:box | parent::elmlpopup | parent::elml:annotation">
                <db:para>
                    <xsl:value-of select="."/>
                </db:para>
            </xsl:when>
            <xsl:when test="parent::elml:paragraph">
                <db:phrase>
                    <xsl:if test="not(preceding-sibling::text())">
                        <xsl:call-template name="elml:Label"/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </db:phrase>
            </xsl:when>
            <xsl:when test="parent::elml:lObjective">
                <db:phrase>
                    <xsl:value-of select="."/>
                </db:phrase>
            </xsl:when>
        </xsl:choose>
        <!-- <xsl:choose>
            <xsl:when test="not(parent::elml:paragraph or parent::elml:formatted or parent::elml:indexTerm or parent::elml:citation or parent::elml:term or parent::elml:indexItem or parent::elml:link or parent::elml:option or parent::elml:gap or parent::elml:answer or parent::elml:item)">
            
            <xsl:comment><xsl:value-of select="$parent"/> ACHTUNG TEXT FEHLT!</xsl:comment>
            </xsl:when>
            <xsl:otherwise>
            <xsl:value-of select="."/>
            </xsl:otherwise>
            </xsl:choose> -->
    </xsl:template>
    <xsl:template match="elml:list" mode="inline">
        <db:simplelist>
            <xsl:apply-templates mode="simplelist"/>
        </db:simplelist>
        <xsl:if test="@legend">
            <db:simpara>
                <xsl:call-template name="elml:caption_inline"></xsl:call-template>
            </db:simpara>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:list">
        <xsl:param name="listStyle">
            <xsl:choose>
                <xsl:when test="@listStyle">
                    <xsl:value-of select="@listStyle"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of>unordered</xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="ordered">
                <db:orderedlist>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:call-template name="elml:generate_Title"/>
                    <xsl:call-template name="elml:BibliographyRef"/>
                    <xsl:call-template name="elml:icon_block"/>
                    <xsl:choose>
                        <xsl:when test="child::elml:item/child::elml:list or child::elml:item/child::elml:box">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates mode="inline"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </db:orderedlist>
                <xsl:if test="@legend">
                    <db:simpara>
                        <xsl:call-template name="elml:caption_inline"></xsl:call-template>
                    </db:simpara>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <db:itemizedlist>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:call-template name="elml:generate_Title"/>
                    <xsl:call-template name="elml:BibliographyRef"/>
                    <xsl:call-template name="elml:icon_block"/>
                    <xsl:choose>
                        <xsl:when test="child::elml:item/child::elml:list or child::elml:item/child::elml:box">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates mode="inline"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </db:itemizedlist>
                <xsl:if test="@legend">
                    <db:simpara>
                        <xsl:call-template name="elml:caption_inline"></xsl:call-template>
                    </db:simpara>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:item" mode="simplelist">
        <db:member>
            
                <xsl:value-of select="descendant::text()"></xsl:value-of>
           
        </db:member>
    </xsl:template>
    <xsl:template match="elml:item" mode="inline">
        <db:listitem>
            <db:para>
                <xsl:apply-templates mode="#current"/>
            </db:para>
        </db:listitem>
    </xsl:template>
    <xsl:template match="elml:item">
        <db:listitem>
            <xsl:apply-templates mode="#current"/>
        </db:listitem>
    </xsl:template>
    <xsl:template match="elml:paragraph" mode="inline">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:choose>
                <xsl:when test="@title">
                    <db:emphasis>
                        <xsl:value-of select="@title"/>
                    </db:emphasis>
                    <xsl:call-template name="elml:icon_inline"/>
                    <xsl:processing-instruction name="breakLine"/>
                    <xsl:apply-templates mode="#current"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="elml:icon_inline"/>
                    <xsl:apply-templates mode="#current"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:paragraph">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:choose>
                <xsl:when test="@title">
                    <db:formalpara>
                        <xsl:call-template name="elml:Label"/>
                        <db:title>
                            <xsl:value-of select="@title"/>
                        </db:title>
                        <db:para>
                            <xsl:call-template name="elml:icon_inline"/>
                            <xsl:apply-templates mode="inline"/>
                        </db:para>
                    </db:formalpara>
                </xsl:when>
                <xsl:otherwise>
                    <db:para>
                        <xsl:call-template name="elml:Label"/>
                        <xsl:call-template name="elml:icon_inline"/>
                        <xsl:apply-templates mode="inline"/>
                    </db:para>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:table">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:choose>
                <xsl:when test="@icon">
                    <db:informaltable>
                        <!-- <xsl:call-template name="elml:Height"/> -->
                        <xsl:call-template name="elml:Width"/>
                        <xsl:call-template name="elml:BibliographyRef"/>
                        <db:tr>
                            <db:td>
                                <xsl:value-of>
                                    <xsl:call-template name="elml:icon_block"/>
                                </xsl:value-of>
                            </db:td>
                            <db:td>
                                <xsl:choose>
                                    <xsl:when test="@title">
                                        <db:table>
                                            <!-- <xsl:call-template name="elml:CSS_Class"/> -->
                                            <xsl:call-template name="elml:Label"/>
                                            <xsl:call-template name="elml:generate_Title"/>
                                            <xsl:for-each select="elml:tablerow">
                                                <db:tr>
                                                    <!-- <xsl:call-template name="elml:CSS_Class"/> -->
                                                    <xsl:apply-templates/>
                                                </db:tr>
                                            </xsl:for-each>
                                        </db:table>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <db:informaltable>
                                            <!-- <xsl:call-template name="elml:CSS_Class"/>  -->
                                            <!-- <xsl:call-template name="elml:Label"/> -->
                                            <xsl:for-each select="elml:tablerow">
                                                <db:tr>
                                                    <!-- <xsl:call-template name="elml:CSS_Class"/> -->
                                                    <xsl:apply-templates/>
                                                </db:tr>
                                            </xsl:for-each>
                                        </db:informaltable>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:td>
                        </db:tr>
                    </db:informaltable>
                    <xsl:if test="@legend">
                        <db:simpara>
                            <xsl:call-template name="elml:caption_inline"></xsl:call-template>
                        </db:simpara>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="@title">
                            <db:table>
                                <!-- <xsl:call-template name="elml:CSS_Class"/> -->
                                <!-- <xsl:call-template name="elml:Height"/> -->
                                <xsl:call-template name="elml:Width"/>
                                <xsl:call-template name="elml:Label"/>
                                <xsl:call-template name="elml:BibliographyRef"/>
                                <xsl:call-template name="elml:generate_Title"/>
                                <xsl:for-each select="elml:tablerow">
                                    <db:tr>
                                        <!-- <xsl:call-template name="elml:CSS_Class"/> -->
                                        <xsl:apply-templates/>
                                    </db:tr>
                                </xsl:for-each>
                            </db:table>
                            <xsl:if test="@legend">
                                <db:simpara>
                                    <xsl:call-template name="elml:caption_inline"></xsl:call-template>
                                </db:simpara>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <db:informaltable>
                                <!-- <xsl:call-template name="elml:CSS_Class"/>  -->
                                <!-- <xsl:call-template name="elml:Height"/> -->
                                <xsl:call-template name="elml:Width"/>
                                <xsl:call-template name="elml:Label"/>
                                <xsl:call-template name="elml:BibliographyRef"/>
                                <xsl:for-each select="elml:tablerow">
                                    <db:tr>
                                        <!-- <xsl:call-template name="elml:CSS_Class"/> -->
                                        <xsl:apply-templates/>
                                    </db:tr>
                                </xsl:for-each>
                            </db:informaltable>
                            <xsl:if test="@legend">
                                <db:simpara>
                                    <xsl:call-template name="elml:caption_inline"></xsl:call-template>
                                </db:simpara>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:tableheading">
        <db:th>
            <!--  <xsl:call-template name="elml:CSS_Class"/> -->
            <xsl:call-template name="elml:Label"/>
            <!-- <xsl:call-template name="elml:WidthHeight"/> -->
            <!-- <xsl:call-template name="elml:WidthHeight"/> -->
            <xsl:call-template name="elml:Align"/>
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
        </db:th>
    </xsl:template>
    <xsl:template match="elml:tabledata">
        <db:td>
            <!-- <xsl:call-template name="elml:CSS_Class"/> -->
            <xsl:call-template name="elml:Label"/>
            <!-- <xsl:call-template name="elml:WidthHeight"/> -->
            <xsl:call-template name="elml:Align"/>
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
        </db:td>
    </xsl:template>
    <xsl:template match="elml:column">
        <!--Template that matches the "column" paragraph type.-->
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
        <db:informaltable>
            <xsl:call-template name="elml:Label"/>
            <!--<xsl:call-template name="elml:CSS_Class"/> -->
            <!--<xsl:call-template name="elml:Label"/> -->
            <!-- <xsl:call-template name="elml:Width"/> -->
            <db:tr valign="top">
                <xsl:apply-templates/>
            </db:tr>
        </db:informaltable>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:columnLeft | elml:columnMiddle | elml:columnRight">
        <db:td>
            <!-- <xsl:call-template name="elml:CSS_Class"/> -->
            <!-- <xsl:call-template name="elml:Height"/> -->
            <xsl:call-template name="elml:Align"/>
            <xsl:apply-templates/>
        </db:td>
    </xsl:template>
    <xsl:template match="elml:box">
        <xsl:choose>
            <xsl:when test="icon">
                <db:informaltable>
                    <db:tr>
                        <db:td>
                            <xsl:call-template name="elml:icon_block"/>
                        </db:td>
                        <db:td>
                            <xsl:choose>
                                <xsl:when test="@title">
                                    <db:table>
                                        <xsl:call-template name="elml:Label"/>
                                        <xsl:call-template name="elml:generate_Title"/>
                                        <db:tr>
                                            <db:td>
                                                <xsl:apply-templates/>
                                            </db:td>
                                        </db:tr>
                                    </db:table>
                                </xsl:when>
                                <xsl:otherwise>
                                    <db:informaltable>
                                        <xsl:call-template name="elml:Label"/>
                                        <db:tr>
                                            <db:td>
                                                <xsl:apply-templates/>
                                            </db:td>
                                        </db:tr>
                                    </db:informaltable>
                                </xsl:otherwise>
                            </xsl:choose>
                        </db:td>
                    </db:tr>
                </db:informaltable>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@title">
                        <db:table>
                            <xsl:call-template name="elml:Label"/>
                            <xsl:call-template name="elml:generate_Title"/>
                            <db:tr>
                                <db:td>
                                    <xsl:apply-templates/>
                                </db:td>
                            </db:tr>
                        </db:table>
                    </xsl:when>
                    <xsl:otherwise>
                        <db:informaltable>
                            <xsl:call-template name="elml:Label"/>
                            <db:tr>
                                <db:td>
                                    <xsl:apply-templates/>
                                </db:td>
                            </db:tr>
                        </db:informaltable>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:multimedia" mode="inline">
        <xsl:param name="specific_type">
            <xsl:value-of select="@type"/>
        </xsl:param>
        <xsl:param name="type">
            <xsl:choose>
                <xsl:when test="@type='jpeg' or @type='png' or @type='svg'">
                    <xsl:value-of>imagedata</xsl:value-of>
                </xsl:when>
                <xsl:when test="@type='flash' or @type='quicktime' or @type='mpeg' or @type='vrml' or @type='x3d'">
                    <xsl:value-of>videodata</xsl:value-of>
                </xsl:when>
                <xsl:when test="@type='mathml' or @type='div' or @type='applet'">
                    <xsl:value-of>textdata</xsl:value-of>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of>audiodata</xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <!-- test if multimedia should be displayed -->
        <xsl:if test="$display = 'yes'">
            <!-- insert icon if necessary -->
            <xsl:call-template name="elml:icon_inline"/>
            <!-- test if its a thumbnail-->
            <xsl:choose>
                <xsl:when test="@thumbnail">
                    <!-- its a thumbnail so wrap with link element -->
                    <db:link>
                        <xsl:attribute name="xlink:href">
                            <xsl:value-of select="@src"/>
                        </xsl:attribute>
                        <db:inlinemediaobject>
                            <xsl:call-template name="elml:Label"/>
                            <xsl:call-template name="elml:BibliographyRef"/>
                            <xsl:choose>
                                <!--choose from types image audio or text -->
                                <xsl:when test="$type='imagedata'">
                                    <db:imageobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                        <db:imagedata>
                                            <xsl:attribute name="fileref">
                                                <xsl:value-of select="@thumbnail"/>
                                            </xsl:attribute>
                                            <xsl:call-template name="elml:Format">
                                                <xsl:with-param name="specific_type">
                                                    <xsl:value-of select="$specific_type"/>
                                                </xsl:with-param>
                                            </xsl:call-template>
                                            <xsl:apply-templates/>
                                        </db:imagedata>
                                    </db:imageobject>
                                </xsl:when>
                                <xsl:when test="$type='videodata'">
                                    <db:videoobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                        <db:videodata>
                                            <xsl:attribute name="fileref">
                                                <xsl:value-of select="@thumbnail"/>
                                            </xsl:attribute>
                                            <xsl:call-template name="elml:Format">
                                                <xsl:with-param name="specific_type">
                                                    <xsl:value-of select="$specific_type"/>
                                                </xsl:with-param>
                                            </xsl:call-template>
                                            <xsl:apply-templates/>
                                        </db:videodata>
                                    </db:videoobject>
                                </xsl:when>
                                <xsl:when test="$type='textdata'">
                                    <db:textobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                        <db:textdata>
                                            <xsl:attribute name="fileref">
                                                <xsl:value-of select="@thumbnail"/>
                                            </xsl:attribute>
                                            <xsl:call-template name="elml:Format">
                                                <xsl:with-param name="specific_type">
                                                    <xsl:value-of select="$specific_type"/>
                                                </xsl:with-param>
                                            </xsl:call-template>
                                            <xsl:apply-templates/>
                                        </db:textdata>
                                    </db:textobject>
                                </xsl:when>
                                <xsl:otherwise>
                                    <db:audioobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                        <db:audiodata>
                                            <xsl:attribute name="fileref">
                                                <xsl:value-of select="@thumbnail"/>
                                            </xsl:attribute>
                                            <xsl:call-template name="elml:Format">
                                                <xsl:with-param name="specific_type">
                                                    <xsl:value-of select="$specific_type"/>
                                                </xsl:with-param>
                                            </xsl:call-template>
                                            <xsl:apply-templates/>
                                        </db:audiodata>
                                    </db:audioobject>
                                </xsl:otherwise>
                            </xsl:choose>
                        </db:inlinemediaobject>
                        <xsl:call-template name="elml:caption_inline"/>
                    </db:link>
                </xsl:when>
                <xsl:otherwise>
                    <!-- its not a thumbnail so go further -->
                    <db:inlinemediaobject>
                        <xsl:call-template name="elml:Label"/>
                        <xsl:call-template name="elml:BibliographyRef"/>
                        <xsl:choose>
                            <!--choose from types image audio or text -->
                            <xsl:when test="$type='imagedata'">
                                <db:imageobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                    <db:imagedata>
                                        <xsl:attribute name="fileref">
                                            <xsl:value-of select="@src"/>
                                        </xsl:attribute>
                                        <xsl:call-template name="elml:Format">
                                            <xsl:with-param name="specific_type">
                                                <xsl:value-of select="$specific_type"/>
                                            </xsl:with-param>
                                        </xsl:call-template>
                                        <xsl:apply-templates/>
                                    </db:imagedata>
                                </db:imageobject>
                            </xsl:when>
                            <xsl:when test="$type='videodata'">
                                <db:videoobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                    <db:videodata>
                                        <xsl:attribute name="fileref">
                                            <xsl:value-of select="@src"/>
                                        </xsl:attribute>
                                        <xsl:call-template name="elml:Format">
                                            <xsl:with-param name="specific_type">
                                                <xsl:value-of select="$specific_type"/>
                                            </xsl:with-param>
                                        </xsl:call-template>
                                        <xsl:apply-templates/>
                                    </db:videodata>
                                </db:videoobject>
                            </xsl:when>
                            <xsl:when test="$type='textdata'">
                                <db:textobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                    <db:textdata>
                                        <xsl:attribute name="fileref">
                                            <xsl:value-of select="@src"/>
                                        </xsl:attribute>
                                        <xsl:call-template name="elml:Format">
                                            <xsl:with-param name="specific_type">
                                                <xsl:value-of select="$specific_type"/>
                                            </xsl:with-param>
                                        </xsl:call-template>
                                        <xsl:apply-templates/>
                                    </db:textdata>
                                </db:textobject>
                            </xsl:when>
                            <xsl:otherwise>
                                <db:audioobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                    <db:audiodata>
                                        <xsl:attribute name="fileref">
                                            <xsl:value-of select="@src"/>
                                        </xsl:attribute>
                                        <xsl:call-template name="elml:Format">
                                            <xsl:with-param name="specific_type">
                                                <xsl:value-of select="$specific_type"/>
                                            </xsl:with-param>
                                        </xsl:call-template>
                                        <xsl:apply-templates/>
                                    </db:audiodata>
                                </db:audioobject>
                            </xsl:otherwise>
                        </xsl:choose>
                    </db:inlinemediaobject>
                    <xsl:call-template name="elml:caption_inline"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:multimedia">
        <xsl:param name="specific_type">
            <xsl:value-of select="@type"/>
        </xsl:param>
        <xsl:param name="type">
            <xsl:choose>
                <xsl:when test="@type='jpeg' or @type='png' or @type='svg'">
                    <xsl:value-of>imagedata</xsl:value-of>
                </xsl:when>
                <xsl:when test="@type='flash' or @type='quicktime' or @type='mpeg' or @type='vrml' or @type='x3d'">
                    <xsl:value-of>videodata</xsl:value-of>
                </xsl:when>
                <xsl:when test="@type='mathml' or @type='div' or @type='applet'">
                    <xsl:value-of>textdata</xsl:value-of>
                </xsl:when>
                <xsl:when test="@type='mp3'">
                    <xsl:value-of>audiodata</xsl:value-of>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of>textdata</xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <!-- test if multimedia should be displayed -->
        <xsl:if test="$display = 'yes'">
            <xsl:choose>
                <!-- test if its a thumbnail-->
                <xsl:when test="@thumbnail">
                    <!-- ist a thumbnail so wrap with link element -->
                    <!-- insert icon if necessary -->
                    <xsl:call-template name="elml:icon_inline"/>
                    <!-- test if parent causes inline-flow-->
                    <xsl:choose>
                        <xsl:when test="parent::elml:paragraph or parent::elml:link">
                            <db:link>
                                <xsl:attribute name="xlink:href">
                                    <xsl:value-of select="@src"/>
                                </xsl:attribute>
                                <db:inlinemediaobject>
                                    <xsl:call-template name="elml:Label"/>
                                    <xsl:call-template name="elml:BibliographyRef"/>
                                    <xsl:choose>
                                        <!--choose from types image audio or text -->
                                        <xsl:when test="$type='imagedata'">
                                            <db:imageobject>
                                                <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                                <db:imagedata>
                                                    <xsl:attribute name="fileref">
                                                        <xsl:value-of select="@thumbnail"/>
                                                    </xsl:attribute>
                                                    <xsl:call-template name="elml:Format">
                                                        <xsl:with-param name="specific_type">
                                                            <xsl:value-of select="$specific_type"/>
                                                        </xsl:with-param>
                                                    </xsl:call-template>
                                                    <xsl:apply-templates/>
                                                </db:imagedata>
                                            </db:imageobject> 
                                        </xsl:when>
                                        <xsl:when test="$type='videodata'">
                                            <db:videoobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                                <db:videodata>
                                                    <xsl:attribute name="fileref">
                                                        <xsl:value-of select="@thumbnail"/>
                                                    </xsl:attribute>
                                                    <xsl:call-template name="elml:Format">
                                                        <xsl:with-param name="specific_type">
                                                            <xsl:value-of select="$specific_type"/>
                                                        </xsl:with-param>
                                                    </xsl:call-template>
                                                    <xsl:apply-templates/>
                                                </db:videodata>
                                            </db:videoobject>
                                        </xsl:when>
                                        <xsl:when test="$type='textdata'">
                                            <db:textobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                                <db:textdata>
                                                    <xsl:attribute name="fileref">
                                                        <xsl:value-of select="@thumbnail"/>
                                                    </xsl:attribute>
                                                    <xsl:call-template name="elml:Format">
                                                        <xsl:with-param name="specific_type">
                                                            <xsl:value-of select="$specific_type"/>
                                                        </xsl:with-param>
                                                    </xsl:call-template>
                                                    <xsl:apply-templates/>
                                                </db:textdata>
                                            </db:textobject>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <db:audioobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                                <db:audiodata>
                                                    <xsl:attribute name="fileref">
                                                        <xsl:value-of select="@thumbnail"/>
                                                    </xsl:attribute>
                                                    <xsl:call-template name="elml:Format">
                                                        <xsl:with-param name="specific_type">
                                                            <xsl:value-of select="$specific_type"/>
                                                        </xsl:with-param>
                                                    </xsl:call-template>
                                                    <xsl:apply-templates/>
                                                </db:audiodata>
                                            </db:audioobject>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </db:inlinemediaobject>
                                <xsl:call-template name="elml:caption_inline"/>
                            </db:link>
                        </xsl:when>
                        <xsl:otherwise>
                            <db:para>
                                <!-- insert icon if necessary -->
                                <xsl:call-template name="elml:icon_inline"/>
                                <db:link>
                                    <xsl:attribute name="xlink:href">
                                        <xsl:value-of select="@src"/>
                                    </xsl:attribute>
                                    <db:inlinemediaobject>
                                        <xsl:call-template name="elml:Label"/>
                                        <xsl:call-template name="elml:BibliographyRef"/>
                                        <xsl:choose>
                                            <!--choose from types image audio or text -->
                                            <xsl:when test="$type='imagedata'">
                                                <db:imageobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                                    <db:imagedata>
                                                        <xsl:attribute name="fileref">
                                                            <xsl:value-of select="@thumbnail"/>
                                                        </xsl:attribute>
                                                        <xsl:call-template name="elml:Format">
                                                            <xsl:with-param name="specific_type">
                                                                <xsl:value-of select="$specific_type"/>
                                                            </xsl:with-param>
                                                        </xsl:call-template>
                                                        <xsl:apply-templates/>
                                                    </db:imagedata>
                                                </db:imageobject>
                                            </xsl:when>
                                            <xsl:when test="$type='videodata'">
                                                <db:videoobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                                    <db:videodata>
                                                        <xsl:attribute name="fileref">
                                                            <xsl:value-of select="@thumbnail"/>
                                                        </xsl:attribute>
                                                        <xsl:call-template name="elml:Format">
                                                            <xsl:with-param name="specific_type">
                                                                <xsl:value-of select="$specific_type"/>
                                                            </xsl:with-param>
                                                        </xsl:call-template>
                                                        <xsl:apply-templates/>
                                                    </db:videodata>
                                                </db:videoobject>
                                            </xsl:when>
                                            <xsl:when test="$type='textdata'">
                                                <db:textobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                                    <db:textdata>
                                                        <xsl:attribute name="fileref">
                                                            <xsl:value-of select="@thumbnail"/>
                                                        </xsl:attribute>
                                                        <xsl:call-template name="elml:Format">
                                                            <xsl:with-param name="specific_type">
                                                                <xsl:value-of select="$specific_type"/>
                                                            </xsl:with-param>
                                                        </xsl:call-template>
                                                        <xsl:apply-templates/>
                                                    </db:textdata>
                                                </db:textobject>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <db:audioobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                                    <db:audiodata>
                                                        <xsl:attribute name="fileref">
                                                            <xsl:value-of select="@thumbnail"/>
                                                        </xsl:attribute>
                                                        <xsl:call-template name="elml:Format">
                                                            <xsl:with-param name="specific_type">
                                                                <xsl:value-of select="$specific_type"/>
                                                            </xsl:with-param>
                                                        </xsl:call-template>
                                                        <xsl:apply-templates/>
                                                    </db:audiodata>
                                                </db:audioobject>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </db:inlinemediaobject>
                                    <xsl:call-template name="elml:caption_inline"/>
                                </db:link>
                            </db:para>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <!-- its not a thumbnail so go further -->
                    <xsl:choose>
                        <!-- test if parent causes inline-flow-->
                        <xsl:when test="parent::elml:paragraph or parent::elml:link">
                            <!-- insert icon if necessary -->
                            <xsl:call-template name="elml:icon_inline"/>
                            <db:inlinemediaobject>
                                <xsl:call-template name="elml:Label"/>
                                <xsl:call-template name="elml:BibliographyRef"/>
                                <xsl:choose>
                                    <!--choose from types image audio or text -->
                                    <xsl:when test="$type='imagedata'">
                                        <db:imageobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                            <db:imagedata>
                                                <xsl:attribute name="fileref">
                                                    <xsl:value-of select="@src"/>
                                                </xsl:attribute>
                                                <xsl:call-template name="elml:Format">
                                                    <xsl:with-param name="specific_type">
                                                        <xsl:value-of select="$specific_type"/>
                                                    </xsl:with-param>
                                                </xsl:call-template>
                                                <xsl:apply-templates/>
                                            </db:imagedata>
                                        </db:imageobject>
                                    </xsl:when>
                                    <xsl:when test="$type='videodata'">
                                        <db:videoobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                            <db:videodata>
                                                <xsl:attribute name="fileref">
                                                    <xsl:value-of select="@src"/>
                                                </xsl:attribute>
                                                <xsl:call-template name="elml:Format">
                                                    <xsl:with-param name="specific_type">
                                                        <xsl:value-of select="$specific_type"/>
                                                    </xsl:with-param>
                                                </xsl:call-template>
                                                <xsl:apply-templates/>
                                            </db:videodata>
                                        </db:videoobject>
                                    </xsl:when>
                                    <xsl:when test="$type='textdata'">
                                        <db:textobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                            <db:textdata>
                                                <xsl:attribute name="fileref">
                                                    <xsl:value-of select="@src"/>
                                                </xsl:attribute>
                                                <xsl:call-template name="elml:Format">
                                                    <xsl:with-param name="specific_type">
                                                        <xsl:value-of select="$specific_type"/>
                                                    </xsl:with-param>
                                                </xsl:call-template>
                                                <xsl:apply-templates/>
                                            </db:textdata>
                                        </db:textobject>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <db:audioobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                            <db:audiodata>
                                                <xsl:attribute name="fileref">
                                                    <xsl:value-of select="@src"/>
                                                </xsl:attribute>
                                                <xsl:call-template name="elml:Format">
                                                    <xsl:with-param name="specific_type">
                                                        <xsl:value-of select="$specific_type"/>
                                                    </xsl:with-param>
                                                </xsl:call-template>
                                                <xsl:apply-templates/>
                                            </db:audiodata>
                                        </db:audioobject>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </db:inlinemediaobject>
                            <xsl:call-template name="elml:caption_inline"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <!-- insert icon if necessary -->
                            <xsl:call-template name="elml:icon_block"/>
                            <db:mediaobject> 
                                <xsl:call-template name="elml:Label"/>
                                <xsl:call-template name="elml:BibliographyRef"/>
                                <xsl:choose>
                                    <!--choose from types image audio or text -->
                                    <xsl:when test="$type='imagedata'">
                                        <db:imageobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                            <db:imagedata>
                                                <xsl:attribute name="fileref">
                                                    <xsl:value-of select="@src"/>
                                                </xsl:attribute>
                                                <xsl:call-template name="elml:Format">
                                                    <xsl:with-param name="specific_type">
                                                        <xsl:value-of select="$specific_type"/>
                                                    </xsl:with-param>
                                                </xsl:call-template>
                                                <xsl:apply-templates/>
                                            </db:imagedata>
                                        </db:imageobject>
                                    </xsl:when>
                                    <xsl:when test="$type='videodata'">
                                        <db:videoobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                            <db:videodata>
                                                <xsl:attribute name="fileref">
                                                    <xsl:value-of select="@src"/>
                                                </xsl:attribute>
                                                <xsl:call-template name="elml:Format">
                                                    <xsl:with-param name="specific_type">
                                                        <xsl:value-of select="$specific_type"/>
                                                    </xsl:with-param>
                                                </xsl:call-template>
                                                <xsl:apply-templates/>
                                            </db:videodata>
                                        </db:videoobject>
                                    </xsl:when>
                                    <xsl:when test="$type='textdata'">
                                        <db:textobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                            <db:textdata>
                                                <xsl:attribute name="fileref">
                                                    <xsl:value-of select="@src"/>
                                                </xsl:attribute>
                                                <xsl:call-template name="elml:Format">
                                                    <xsl:with-param name="specific_type">
                                                        <xsl:value-of select="$specific_type"/>
                                                    </xsl:with-param>
                                                </xsl:call-template>
                                                <xsl:apply-templates/>
                                            </db:textdata>
                                        </db:textobject>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <db:audioobject> <xsl:call-template name="elml:generate_Title"></xsl:call-template>
                                            <db:audiodata>
                                                <xsl:attribute name="fileref">
                                                    <xsl:value-of select="@src"/>
                                                </xsl:attribute>
                                                <xsl:call-template name="elml:Format">
                                                    <xsl:with-param name="specific_type">
                                                        <xsl:value-of select="$specific_type"/>
                                                    </xsl:with-param>
                                                </xsl:call-template>
                                                <xsl:apply-templates/>
                                            </db:audiodata>
                                        </db:audioobject>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:call-template name="elml:caption_block"/>
                            </db:mediaobject>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:term" mode="inline">
        <xsl:choose>
            <xsl:when test="@icon">
                <xsl:call-template name="elml:icon_inline"/>
                <db:glossterm>
                    <xsl:call-template name="elml:Link"/>
                    <xsl:apply-templates/>
                </db:glossterm>
            </xsl:when>
            <xsl:otherwise>
                <db:glossterm>
                    <xsl:call-template name="elml:Link"/>
                    <xsl:apply-templates mode="inline"/>
                </db:glossterm>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:term">
        <xsl:choose>
            <xsl:when test="@icon">
                <db:informaltable>
                    <db:tr>
                        <db:td>
                            <xsl:call-template name="elml:icon_block"/>
                        </db:td>
                        <db:td>
                            <db:para>
                                <db:glossterm>
                                    <xsl:call-template name="elml:Link"/>
                                    <xsl:apply-templates mode="inline"/>
                                </db:glossterm>
                            </db:para>
                        </db:td>
                    </db:tr>
                </db:informaltable>
            </xsl:when>
            <xsl:otherwise>
                <db:para>
                    <db:glossterm>
                        <xsl:call-template name="elml:Link"/>
                        <xsl:apply-templates mode="inline"/>
                    </db:glossterm>
                </db:para>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:citation" mode="inline">
        <xsl:param name="bibIDRef">
            <xsl:value-of select="@bibIDRef"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="@icon">
                <xsl:call-template name="elml:icon_inline"/>
                <db:citation>
                    <xsl:call-template name="elml:Link"/>
                    <db:citebiblioid>
                        <xsl:value-of select="@bibIDRef"/>
                    </db:citebiblioid>
                    <!--  -->
                    <xsl:if test="/elml:lesson/elml:bibliography/*[@bibID=$bibIDRef]">
                        <xsl:choose>
                            <xsl:when test="not(@yearOnly='yes')">
                                <xsl:for-each select="/elml:lesson/elml:bibliography/*[@bibID=$bibIDRef]">
                                    <xsl:if test="@author or @publicationyear">
                                        <db:author>
                                            <db:personname>
                                                <xsl:if test="@author">
                                                    <xsl:value-of select="@author"/>
                                                </xsl:if>
                                                <xsl:if test="@author and @publicationYear">
                                                    <xsl:value-of select="' '"/>
                                                </xsl:if>
                                                <xsl:if test="@publicationYear">
                                                    <xsl:value-of select="@publicationYear"/>
                                                </xsl:if>
                                            </db:personname>
                                        </db:author>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="@publicationYear">
                                    <db:author>
                                        <db:personname>
                                            <xsl:value-of select="@publicationYear"/>
                                        </db:personname>
                                    </db:author>
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                    <!-- -->
                    <xsl:apply-templates/>
                </db:citation>
            </xsl:when>
            <xsl:otherwise>
                <db:citation>
                    <xsl:call-template name="elml:Link"/>
                    <db:citebiblioid>
                        <xsl:value-of select="@bibIDRef"/>
                    </db:citebiblioid>
                    <!-- same as elml:resItem -->
                    <xsl:if test="/elml:lesson/elml:bibliography/*[@bibID=$bibIDRef]">
                        <xsl:choose>
                            <xsl:when test="not(@yearOnly='yes')">
                                <xsl:for-each select="/elml:lesson/elml:bibliography/*[@bibID=$bibIDRef]">
                                    <xsl:if test="@author or @publicationyear">
                                        <db:author>
                                            <db:personname>
                                                <xsl:if test="@author">
                                                    <xsl:value-of select="@author"/>
                                                </xsl:if>
                                                <xsl:if test="@author and @publicationYear">
                                                    <xsl:value-of select="' '"/>
                                                </xsl:if>
                                                <xsl:if test="@publicationYear">
                                                    <xsl:value-of select="@publicationYear"/>
                                                </xsl:if>
                                            </db:personname>
                                        </db:author>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="@publicationYear">
                                    <db:author>
                                        <db:personname>
                                            <xsl:value-of select="@publicationYear"/>
                                        </db:personname>
                                    </db:author>
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                    <!-- end of same as resItem -->
                    <xsl:apply-templates mode="inline"/>
                </db:citation>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:citation">
        <xsl:param name="bibIDRef">
            <xsl:value-of select="@bibIDRef"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="@icon">
                <db:informaltable>
                    <db:tr>
                        <db:td>
                            <xsl:call-template name="elml:icon_block"/>
                        </db:td>
                        <db:td>
                            <db:para>
                                <db:citation>
                                    <xsl:call-template name="elml:Link"/>
                                    <db:citebiblioid>
                                        <xsl:value-of select="@bibIDRef"/>
                                    </db:citebiblioid>
                                    <!--  -->
                                    <xsl:if test="/elml:lesson/elml:bibliography/*[@bibID=$bibIDRef]">
                                        <xsl:choose>
                                            <xsl:when test="not(@yearOnly='yes')">
                                                <xsl:for-each select="/elml:lesson/elml:bibliography/*[@bibID=$bibIDRef]">
                                                    <xsl:if test="@author or @publicationyear">
                                                        <db:author>
                                                            <db:personname>
                                                                <xsl:if test="@author">
                                                                    <xsl:value-of select="@author"/>
                                                                </xsl:if>
                                                                <xsl:if test="@author and @publicationYear">
                                                                    <xsl:value-of select="' '"/>
                                                                </xsl:if>
                                                                <xsl:if test="@publicationYear">
                                                                    <xsl:value-of select="@publicationYear"/>
                                                                </xsl:if>
                                                            </db:personname>
                                                        </db:author>
                                                    </xsl:if>
                                                </xsl:for-each>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:if test="@publicationYear">
                                                    <db:author>
                                                        <db:personname>
                                                            <xsl:value-of select="@publicationYear"/>
                                                        </db:personname>
                                                    </db:author>
                                                </xsl:if>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                    <!-- -->
                                    <xsl:apply-templates mode="inline"/>
                                </db:citation>
                            </db:para>
                        </db:td>
                    </db:tr>
                </db:informaltable>
            </xsl:when>
            <xsl:otherwise>
                <db:para>
                    <db:citation>
                        <xsl:call-template name="elml:Link"/>
                        <db:citebiblioid>
                            <xsl:value-of select="@bibIDRef"/>
                        </db:citebiblioid>
                        <!--  -->
                        <xsl:if test="/elml:lesson/elml:bibliography/*[@bibID=$bibIDRef]">
                            <xsl:choose>
                                <xsl:when test="not(@yearOnly='yes')">
                                    <xsl:for-each select="/elml:lesson/elml:bibliography/*[@bibID=$bibIDRef]">
                                        <xsl:if test="@author or @publicationyear">
                                            <db:author>
                                                <db:personname>
                                                    <xsl:if test="@author">
                                                        <xsl:value-of select="@author"/>
                                                    </xsl:if>
                                                    <xsl:if test="@author and @publicationYear">
                                                        <xsl:value-of select="' '"/>
                                                    </xsl:if>
                                                    <xsl:if test="@publicationYear">
                                                        <xsl:value-of select="@publicationYear"/>
                                                    </xsl:if>
                                                </db:personname>
                                            </db:author>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:if test="@publicationYear">
                                        <db:author>
                                            <db:personname>
                                                <xsl:value-of select="@publicationYear"/>
                                            </db:personname>
                                        </db:author>
                                    </xsl:if>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                        <!-- -->
                        <xsl:apply-templates mode="inline"/>
                    </db:citation>
                </db:para>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:formatted" mode="inline">
        <xsl:param name="style">
            <xsl:value-of select="@style"/>
        </xsl:param>
        <db:emphasis>
            <xsl:choose>

                <xsl:when test="$style='subscript'">
                    <db:subscript>
                        <xsl:apply-templates/>
                    </db:subscript>
                </xsl:when>
                <xsl:when test="$style='subscript'">
                    <db:superscript>
                        <xsl:apply-templates/>
                    </db:superscript>
                </xsl:when>
                <xsl:otherwise>

                    <xsl:apply-templates/>

                </xsl:otherwise>

            </xsl:choose>

        </db:emphasis>
    </xsl:template>
    <xsl:template match="elml:formatted"> </xsl:template>
    <xsl:template match="elml:newLine">
        <xsl:processing-instruction name="breakLine"/>
    </xsl:template>
    <xsl:template match="elml:indexItem"/>
    <xsl:template match="elml:indexItem" mode="inline">
        <db:indexterm>
            <db:primary>
                <xsl:apply-templates mode="inline"/>
            </db:primary>
        </db:indexterm>
    </xsl:template>
    <xsl:template match="elml:span"> </xsl:template>
    <xsl:template match="elml:span" mode="inline">
        <db:phrase>
            <xsl:apply-templates mode="inline"/>
        </db:phrase>
    </xsl:template>
    <!-- <xsl:template match="elml:link" mode="inline">
        <db:link>
            <xsl:apply-templates mode="inline">
                
            </xsl:apply-templates>
        </db:link>
    </xsl:template>
    <xsl:template match="elml:link">
        
    </xsl:template> -->
    <xsl:template match="elml:link">
        <xsl:param name="label" select="@targetLabel"/>
        <xsl:param name="TempURL">
            <xsl:choose>
                <xsl:when test="not((@role='student') or (@role=$role) or (not (@role)))">
                    <xsl:text>none</xsl:text>
                </xsl:when>
                <xsl:when test="starts-with(@uri, 'http') or starts-with(@uri, 'mailto:')">
                    <xsl:value-of select="@uri"/>
                </xsl:when>
                <xsl:when test="@uri">
                    <xsl:value-of select="$server"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="/elml:lesson/@label"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$lang"/>
                    <xsl:choose>
                        <xsl:when test="starts-with(@uri, '..')">
                            <xsl:value-of select="substring-after(@uri, '..')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>/text/</xsl:text>
                            <xsl:value-of select="@uri"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="@targetLesson and not(@targetLesson = /elml:lesson/@label)">
                            <xsl:value-of select="$server"/>
                            <xsl:text>/</xsl:text>
                            <xsl:value-of select="@targetLesson"/>
                            <xsl:text>/</xsl:text>
                            <xsl:value-of select="$lang"/>
                            <xsl:text>/</xsl:text>
                        </xsl:when>
                        <xsl:when test="name(//*[@label=$label])='unit'">
                            <xsl:text>unit_</xsl:text>
                            <xsl:value-of select="@targetLabel"/>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:when>
                        <xsl:when test="name(//*[@label=$label])='learningObject'">
                            <xsl:value-of select="//*[@label=$label]/../@label"/>
                            <xsl:text>_</xsl:text>
                            <xsl:value-of select="@targetLabel"/>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:when>
                        <xsl:when test="@targetLabel">
                            <xsl:value-of select="//*[@label=$label]/../@label"/>
                            <xsl:text>_</xsl:text>
                            <xsl:value-of select="@targetLabel"/>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>index</xsl:text>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="((boolean(name(preceding-sibling::node()[1])) or boolean(name(following-sibling::node()[1]))) and not(../text())) or (count(../*)=number('1') and (name(parent::node())='look' or name(parent::node())='act' or name(parent::node())='clarify'))">
                <db:table>
                    <db:title>
                        <xsl:choose>
                            <xsl:when test="$lang='de'">
                                <xsl:value-of>Links Tabelle</xsl:value-of>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of>Links Table</xsl:value-of>
                            </xsl:otherwise>
                        </xsl:choose>
                    </db:title>
                    <db:tgroup cols="5" align="left" colsep="1" rowsep="1">

                        <db:colspec colname="c1"/>
                        <db:colspec colname="c2"/>
                        <db:colspec colname="c3"/>
                        <db:colspec colname="c4"/>
                        <db:colspec colnum="5" colname="c5"/>


                        <db:tbody>
                            <db:row>
                                <xsl:if test="@icon and not($layout='none')">
                                    <db:entry>

                                        <xsl:call-template name="elml:icon_block"/>

                                    </db:entry>
                                </xsl:if>
                                <db:entry>
                                    <xsl:if test="not(@icon) or $layout='none'">
                                        <xsl:attribute name="namest">c2</xsl:attribute>
                                        <xsl:attribute name="nameend">c3</xsl:attribute>
                                        <xsl:attribute name="align">center</xsl:attribute>
                                        <xsl:attribute name="morerows">1</xsl:attribute>
                                        <xsl:attribute name="valign">bottom</xsl:attribute>
                                    </xsl:if>
                                    <db:para>
                                        <xsl:choose>
                                            <xsl:when test="not((@role='student') or (@role=$role) or (not (@role)))">
                                                <xsl:apply-templates mode="inline"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <db:link>
                                                    <xsl:choose>
                                                        <xsl:when test="starts-with($TempURL, 'http') or starts-with($TempURL, 'mailto:')">
                                                            <xsl:attribute name="xlink:href">
                                                                <xsl:value-of select="$TempURL"/>
                                                            </xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="xlink:href">
                                                                <xsl:value-of select="$TempURL"/>
                                                            </xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                    <xsl:apply-templates/>
                                                </db:link>
                                                <xsl:if test="$display_links='yes'">
                                                    <db:para>
                                                        <xsl:text> [</xsl:text>
                                                        <xsl:choose>
                                                            <xsl:when test="starts-with($TempURL, 'http')">
                                                                <xsl:value-of select="$TempURL"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="$name_internalLink"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:choose>
                                                                    <xsl:when test="@targetLesson">
                                                                        <xsl:value-of select="$name_lesson"/>
                                                                        <xsl:text> </xsl:text>
                                                                        <xsl:value-of select="$TempURL"/>
                                                                    </xsl:when>
                                                                    <xsl:when test="@targetLabel">
                                                                        <xsl:value-of select="$name_page"/>
                                                                        <xsl:text> </xsl:text>

                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:text> URI </xsl:text>
                                                                        <xsl:value-of select="@uri"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:text>] </xsl:text>
                                                    </db:para>
                                                </xsl:if>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </db:para>
                                </db:entry>
                                <db:entry>
                                    <db:para>
                                        <xsl:if test="@size">
                                            <xsl:value-of select="@size"/>
                                        </xsl:if>
                                    </db:para>
                                </db:entry>
                                <db:entry>
                                    <db:para>
                                        <xsl:if test="@type">
                                            <xsl:value-of select="@type"/>
                                        </xsl:if>
                                    </db:para>
                                </db:entry>
                                <db:entry>
                                    <db:para>
                                        <xsl:if test="@legend">
                                            <xsl:value-of select="@legend"/>
                                        </xsl:if>
                                    </db:para>
                                </db:entry>
                            </db:row>
                        </db:tbody>

                    </db:tgroup>

                </db:table>
            </xsl:when>
            <xsl:when test="not((@role='student') or (@role=$role) or (not (@role)))">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <db:para>
                    <db:link>
                        <xsl:choose>
                            <xsl:when test="starts-with($TempURL, 'http') or starts-with($TempURL, 'mailto:')">
                                <xsl:attribute name="xlink:href">
                                    <xsl:value-of select="$TempURL"/>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="xlink:href">
                                    <xsl:value-of select="$TempURL"/>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:apply-templates/>
                    </db:link>
                    <xsl:if test="$display_links='yes'">

                        <xsl:text> [</xsl:text>
                        <xsl:choose>
                            <xsl:when test="starts-with($TempURL, 'http')">
                                <xsl:value-of select="$TempURL"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$name_internalLink"/>
                                <xsl:text> </xsl:text>
                                <xsl:choose>
                                    <xsl:when test="@targetLesson">
                                        <xsl:value-of select="$name_lesson"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="$TempURL"/>
                                    </xsl:when>
                                    <xsl:when test="@targetLabel">
                                        <xsl:value-of select="$name_page"/>
                                        <xsl:text> </xsl:text>

                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> URI </xsl:text>
                                        <xsl:value-of select="@uri"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:if test="@size or @type or @legend">
                            <xsl:text> </xsl:text>
                            <xsl:if test="@legend">
                                <xsl:value-of select="@legend"/>
                                <xsl:text>. </xsl:text>
                            </xsl:if>
                            <xsl:if test="@size">
                                <xsl:value-of select="$name_size"/>
                                <xsl:text>: </xsl:text>
                                <xsl:value-of select="@size"/>
                                <xsl:text>. </xsl:text>
                            </xsl:if>
                            <xsl:if test="@type">
                                <xsl:value-of select="$name_type"/>
                                <xsl:text>: </xsl:text>
                                <xsl:value-of select="@type"/>
                                <xsl:text>. </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:text>] </xsl:text>

                    </xsl:if>
                </db:para>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="elml:link" mode="inline">
        <xsl:param name="label" select="@targetLabel"/>
        <xsl:param name="TempURL">
            <xsl:choose>
                <xsl:when test="not((@role='student') or (@role=$role) or (not (@role)))">
                    <xsl:text>none</xsl:text>
                </xsl:when>
                <xsl:when test="starts-with(@uri, 'http') or starts-with(@uri, 'mailto:')">
                    <xsl:value-of select="@uri"/>
                </xsl:when>
                <xsl:when test="@uri">
                    <xsl:value-of select="$server"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="/elml:lesson/@label"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$lang"/>
                    <xsl:choose>
                        <xsl:when test="starts-with(@uri, '..')">
                            <xsl:value-of select="substring-after(@uri, '..')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>/text/</xsl:text>
                            <xsl:value-of select="@uri"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="@targetLesson and not(@targetLesson = /elml:lesson/@label)">
                            <xsl:value-of select="$server"/>
                            <xsl:text>/</xsl:text>
                            <xsl:value-of select="@targetLesson"/>
                            <xsl:text>/</xsl:text>
                            <xsl:value-of select="$lang"/>
                            <xsl:text>/</xsl:text>
                        </xsl:when>
                        <xsl:when test="name(//*[@label=$label])='unit'">
                            <xsl:text>unit_</xsl:text>
                            <xsl:value-of select="@targetLabel"/>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:when>
                        <xsl:when test="name(//*[@label=$label])='learningObject'">
                            <xsl:value-of select="//*[@label=$label]/../@label"/>
                            <xsl:text>_</xsl:text>
                            <xsl:value-of select="@targetLabel"/>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:when>
                        <xsl:when test="@targetLabel">
                            <xsl:value-of select="//*[@label=$label]/../@label"/>
                            <xsl:text>_</xsl:text>
                            <xsl:value-of select="@targetLabel"/>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>index</xsl:text>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>

            <xsl:when test="not((@role='student') or (@role=$role) or (not (@role)))">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>

                <db:link>
                    <xsl:choose>
                        <xsl:when test="starts-with($TempURL, 'http') or starts-with($TempURL, 'mailto:')">
                            <xsl:attribute name="xlink:href">
                                <xsl:value-of select="$TempURL"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="xlink:href">
                                <xsl:value-of select="$TempURL"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates/>
                </db:link>
                <xsl:if test="$display_links='yes'">

                    <xsl:text> [</xsl:text>
                    <xsl:choose>
                        <xsl:when test="starts-with($TempURL, 'http')">
                            <xsl:value-of select="$TempURL"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$name_internalLink"/>
                            <xsl:text> </xsl:text>
                            <xsl:choose>
                                <xsl:when test="@targetLesson">
                                    <xsl:value-of select="$name_lesson"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="$TempURL"/>
                                </xsl:when>
                                <xsl:when test="@targetLabel">
                                    <xsl:value-of select="$name_page"/>
                                    <xsl:text> </xsl:text>

                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text> URI </xsl:text>
                                    <xsl:value-of select="@uri"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="@size or @type or @legend">
                        <xsl:text> </xsl:text>
                        <xsl:if test="@legend">
                            <xsl:value-of select="@legend"/>
                            <xsl:text>. </xsl:text>
                        </xsl:if>
                        <xsl:if test="@size">
                            <xsl:value-of select="$name_size"/>
                            <xsl:text>: </xsl:text>
                            <xsl:value-of select="@size"/>
                            <xsl:text>. </xsl:text>
                        </xsl:if>
                        <xsl:if test="@type">
                            <xsl:value-of select="$name_type"/>
                            <xsl:text>: </xsl:text>
                            <xsl:value-of select="@type"/>
                            <xsl:text>. </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:text>] </xsl:text>

                </xsl:if>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:annotation">
        <db:annotation>
            <xsl:apply-templates/>
            <db:simpara/>
        </db:annotation>
    </xsl:template>
    <xsl:template match="elml:popup">
        <db:annotation>
            <xsl:apply-templates/>
            <db:simpara/>
        </db:annotation>
    </xsl:template>
    <xsl:template match="elml:metadata"/>
    <xsl:template match="elml:definition"/>
    <!-- ******* NAME TEMPLATES ***** -->
    <xsl:template name="elml:generate_Title">
        <xsl:choose>
            <xsl:when test="@title">
                <xsl:choose>
                    <xsl:when test="name()='multimedia'">
                        <db:info>
                            <db:annotation>
                                <db:simpara><xsl:value-of select="@title"/></db:simpara>
                            </db:annotation>
                        </db:info>
                    </xsl:when>
                    <xsl:when test="name()='table' or name()='box'">
                        <db:caption>
                            <xsl:value-of select="@title"/>
                        </db:caption>
                    </xsl:when>
                    <xsl:otherwise>
                        <db:title>
                            <xsl:value-of select="@title"/>
                        </db:title>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="name() = 'entry' or name() = 'summary' or name() = 'act' or name() = 'look' or name() = 'goals' or name() = 'lObjective' or name() = 'clarify' or name() = 'selfAssessment'">
                    <db:title>
                        <xsl:choose>
                            <xsl:when test="name() = 'entry'">
                                <xsl:value-of>Entry</xsl:value-of>
                            </xsl:when>
                            <xsl:when test="name() = 'summary'">
                                <xsl:value-of>Summary</xsl:value-of>
                            </xsl:when>
                            <xsl:when test="name() = 'act'">
                                <xsl:value-of>Act</xsl:value-of>
                            </xsl:when>
                            <xsl:when test="name() = 'look'">
                                <xsl:value-of>Look</xsl:value-of>
                            </xsl:when>
                            <xsl:when test="name() = 'goals'">
                                <xsl:value-of>Goals</xsl:value-of>
                            </xsl:when>
                            <xsl:when test="name() = 'lObjective'">
                                <xsl:value-of>Learning Objective</xsl:value-of>
                            </xsl:when>
                            <xsl:when test="name() = 'clarify'">
                                <xsl:value-of>Clarify</xsl:value-of>
                            </xsl:when>
                            <xsl:when test="name() = 'selfAssessment'">
                                <xsl:choose>
                                    <xsl:when test="@title">
                                        <xsl:value-of select="@title"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of>SelfAssessment</xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>_DEFAULTTITLE_</xsl:otherwise>
                        </xsl:choose>
                    </db:title>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:setDefaultPara">
        <xsl:if test="not(child::node()) or not(child::text())">
            <db:para> </db:para>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:useIS">
        <xsl:param name="textflow">
            <xsl:choose>
                <xsl:when test="child::elml:paragraph or child::elml:table or child::elml:list or child::elml:link or child::elml:annotation or child::elml:sefAssessment or child::elml:box or child::elml:column or child::elml:toc or child::elml:selfCheck">
                    <xsl:value-of>block</xsl:value-of>
                </xsl:when>
                <xsl:when test="child::elml:formatted or child::elml:newLine or child::elml:indexTerm or child::text() or child::elml:citation or child::elml:term or child::elml:indexItem">
                    <xsl:value-of>inline</xsl:value-of>
                </xsl:when>
                <xsl:otherwise>foo</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="textflow2">
            <xsl:choose>
                <xsl:when test="child::elml:formatted or child::elml:newLine or child::elml:indexTerm or child::text() or child::elml:citationor or child::elml:term or child::elml:indexItem">
                    <xsl:value-of>inline</xsl:value-of>
                </xsl:when>
                <xsl:when test="child::elml:paragraph or child::elml:table or child::elml:list or child::elml:link or child::elml:annotation or child::elml:sefAssessment or child::elml:box or child::elml:column or child::elml:toc or child::elml:selfCheck">
                    <xsl:value-of>block</xsl:value-of>
                </xsl:when>
                <xsl:otherwise>foo</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$textflow='foo' or $textflow2='foo'">
                <xsl:value-of>_foo</xsl:value-of>
            </xsl:when>
            <xsl:when test="$textflow='inline' and $textflow2='inline'">
                <xsl:value-of>_inline</xsl:value-of>
            </xsl:when>
            <xsl:when test="$textflow='block' and $textflow2='block'">
                <xsl:value-of>_block</xsl:value-of>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of><xsl:value-of select="$textflow"/>_<xsl:value-of select="$textflow2"/>_mixed</xsl:value-of>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:display">
        <xsl:choose>
            <xsl:when test="((@role='student') or (@role=$role) or (not (@role))) and not(@visible='online') and not(@visible='none')">
                <xsl:text>yes</xsl:text>
            </xsl:when>
            <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:icon_block">
        <xsl:param name="icon">
            <xsl:value-of select="@icon"/>
            <xsl:value-of>.gif</xsl:value-of>
        </xsl:param>
        <xsl:if test="@icon">
            <db:mediaobject>
                <db:imageobject>
                    <db:imagedata>
                        <xsl:choose>
                            <xsl:when test="$layout='none'">
                                <xsl:attribute name="fileref">
                                    <xsl:value-of select="$pathRoot"/>
                                    <xsl:value-of>/..</xsl:value-of>
                                    <xsl:text>/core/</xsl:text>
                                    <xsl:text>/presentation/</xsl:text>
                                    <!-- <xsl:value-of select="$layout"/> -->
                                    <xsl:value-of>/docbook/</xsl:value-of>
                                    <xsl:text>/icons/</xsl:text>
                                    <xsl:value-of select="@icon"/>
                                    <xsl:text>.gif</xsl:text>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="fileref">
                                    <xsl:value-of select="$pathRoot"/>
                                    <xsl:text>/core/</xsl:text>
                                    <xsl:text>/presentation/</xsl:text>
                                    <!-- <xsl:value-of select="$layout"/> -->
                                    <xsl:value-of>/docbook/</xsl:value-of>
                                    <xsl:text>/icons/</xsl:text>
                                    <xsl:value-of select="@icon"/>
                                    <xsl:text>.gif</xsl:text>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:attribute name="format">
                            <xsl:value-of>gif</xsl:value-of>
                        </xsl:attribute>
                    </db:imagedata>
                </db:imageobject>
                <xsl:call-template name="elml:caption_block"/>
            </db:mediaobject>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:icon_inline">
        <xsl:param name="icon">
            <xsl:value-of select="@icon"/>
            <xsl:value-of>.gif</xsl:value-of>
        </xsl:param>
        <xsl:if test="@icon">
            <db:inlinemediaobject>
                <db:imageobject>
                    <db:imagedata>
                        <xsl:choose>
                            <xsl:when test="$layout='none'">
                                <xsl:attribute name="fileref">
                                    <xsl:value-of select="$pathRoot"/>
                                    <xsl:value-of>/..</xsl:value-of>
                                    <xsl:text>/core/</xsl:text>
                                    <xsl:text>/presentation/</xsl:text>
                                    <!-- <xsl:value-of select="$layout"/> -->
                                    <xsl:value-of>/docbook/</xsl:value-of>
                                    <xsl:text>/icons/</xsl:text>
                                    <xsl:value-of select="@icon"/>
                                    <xsl:text>.gif</xsl:text>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="fileref">
                                    <xsl:value-of select="$pathRoot"/>
                                    <xsl:text>/core/</xsl:text>
                                    <xsl:text>/presentation/</xsl:text>
                                    <!-- <xsl:value-of select="$layout"/> -->
                                    <xsl:value-of>/docbook/</xsl:value-of>
                                    <xsl:text>/icons/</xsl:text>
                                    <xsl:value-of select="@icon"/>
                                    <xsl:text>.gif</xsl:text>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:attribute name="format">
                            <xsl:value-of>gif</xsl:value-of>
                        </xsl:attribute>
                    </db:imagedata>
                </db:imageobject>
            </db:inlinemediaobject>
            <xsl:call-template name="elml:caption_inline"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:caption_block">
        <xsl:if test="@legend">
            <db:caption>
                <xsl:if test="@legend">
                    <xsl:processing-instruction name="breakLine"/>
                    <db:simpara>
                        <xsl:value-of select="@legend"/>
                    </db:simpara>
                </xsl:if>
            </db:caption>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:caption_inline">
        <xsl:if test="@legend">
            <xsl:processing-instruction name="breakLine"/>
            <db:phrase>
                <xsl:value-of select="@legend"/>
            </db:phrase>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:Label">
        <xsl:param name="parent">
            <xsl:value-of select="node-name(parent::*)"/>
        </xsl:param>
        <xsl:if test="@label or name(.)='entry' or name(.)='goals' or name(.)='summary' or name(.)='furtherReading' or name(.)='learningObject' or name(.)='selfAssessment' or name(.)='bibliography' or name(.)='glossary' or name(.)='listOfFigures' or name(.)='listOfTables' or name(.)='index' or name(.)='metadata' or name(.)='clarify' or name(.)='look' or name(.)='act' or name(.)='table' or name(.)='multimedia' or parent::elml:paragraph[@label]">
            <xsl:attribute name="xreflabel">
                <xsl:call-template name="elml:Label_param"/>
            </xsl:attribute>
        </xsl:if>
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
            <!--   <xsl:value-of select="$filename_suffix"/> -->
        </xsl:param>
        <xsl:value-of select="string(concat(/elml:lesson/@label,'_',$Label_param_temp[1],$Label_param_temp[2],$Label_param_temp[3],$Label_param_temp[4],$Label_param_temp[5],$Label_param_temp[6],$Label_param_temp[7],$Label_param_temp[8]))"/>
    </xsl:template>
    <xsl:template name="elml:Height">
        <xsl:param name="height">
            <xsl:choose>
                <xsl:when test="@height and @units='pixels'">
                    <xsl:value-of select="@height"/>
                </xsl:when>
                <xsl:when test="@height and @units='percent'">
                    <xsl:value-of select="@height"/>
                    <xsl:value-of select="@units"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of>100%</xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:attribute name="height">
            <xsl:value-of select="$height"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template name="elml:Width">
        <xsl:param name="width">
            <xsl:choose>
                <xsl:when test="@width and @units='pixels'">
                    <xsl:value-of select="@width"/>
                </xsl:when>
                <xsl:when test="@width and @units='percent'">
                    <xsl:value-of select="@width"/>
                    <xsl:value-of>%</xsl:value-of>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of>100%</xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:attribute name="width">
            <xsl:value-of select="$width"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template name="elml:Align">
        <xsl:if test="@align">
            <xsl:attribute name="align">
                <xsl:value-of select="@align"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:Format">
        <xsl:param name="specific_type"/>
        <xsl:if test="@type">
            <xsl:attribute name="format">
                <xsl:value-of select="$specific_type"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:Link">
        <xsl:if test="name()='term'">
            <xsl:attribute name="xlink:href">
                <xsl:value-of select="/elml:lesson/@label"/>
                <xsl:value-of>_</xsl:value-of>
                <xsl:value-of select="translate(@glossRef,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:BibliographyRefWithMoreSemanticButNotUsedAtTheMoment">
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
            <xsl:choose>
                <xsl:when test="contains($author, ',')">
                    <db:author>
                        <db:personname>
                        <xsl:value-of select="substring-before($author, ',')"/>
                        <xsl:if test="contains(substring-after($author, ','), ',')">
                            <xsl:text> et al.</xsl:text>
                        </xsl:if>
                        </db:personname>  
                    </db:author>
                    <db:citerefentry>
                        <db:refentrytitle>
                            <xsl:value-of select="@bibIDRef"></xsl:value-of>
                        </db:refentrytitle>
                    </db:citerefentry>
                </xsl:when>
                <xsl:otherwise>
                    <db:author>
                        <db:personname>
                        <xsl:value-of select="$author"/>
                         </db:personname>
                    </db:author>
                    <db:citerefentry>
                        <db:refentrytitle>
                            <xsl:value-of select="@bibIDRef"></xsl:value-of>
                        </db:refentrytitle>
                    </db:citerefentry>
                </xsl:otherwise>
            </xsl:choose>
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
            <db:info>
                <db:bibliomset>
            <db:phrase>
                
            <xsl:if test="not(@yearOnly='yes')">
                <xsl:text>(</xsl:text>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="contains($author, ',')">
                    <db:link xlink:type="simple">
                        <xsl:attribute name="xlink:href">
                            <xsl:value-of>#</xsl:value-of>
                            <xsl:value-of select="@bibIDRef"/>
                        </xsl:attribute>
                        <xsl:value-of select="substring-before($author, ',')"/>
                        <xsl:if test="contains(substring-after($author, ','), ',')">
                            <xsl:text> et al.</xsl:text>
                        </xsl:if>
                    </db:link>
                </xsl:when>
                <xsl:otherwise>
                    <db:link xlink:type="simple">
                        <xsl:attribute name="xlink:href">
                            <xsl:value-of>#</xsl:value-of>
                            <xsl:value-of select="@bibIDRef"/>
                        </xsl:attribute>
                        <xsl:value-of select="$author"/>
                    </db:link>
                </xsl:otherwise>
            </xsl:choose>
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
        
        </db:phrase>
        </db:bibliomset>
            </db:info>
            </xsl:if>
    </xsl:template>
</xsl:stylesheet>
