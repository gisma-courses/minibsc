<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" xmlns:xhtml="http://www.w3.org/1999/xhtml" version="2.0" xmlns:functx="http://www.functx.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0">

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
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" media-type="text/xml" name="odfxml"/>
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
                    <xsl:text>\odf\</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="functx:substring-before-last($baseURI, concat('/', $lessonlabel,'/'))"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$lessonlabel"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$lang"/>
                    <xsl:text>/odf/</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="string(concat($pathODF_temp[1],$pathODF_temp[2],$pathODF_temp[3],$pathODF_temp[4],$pathODF_temp[5],$pathODF_temp[6],$pathODF_temp[7],$pathODF_temp[8]))"/>
    </xsl:function>
    <!-- ***** ROOT *****-->
    <xsl:template match="/">
        <xsl:param name="increment"/>
        <xsl:param name="base"/>
        <xsl:call-template name="directory_mathml_objects"/>
        <xsl:call-template name="directory_configurations"/>
        <xsl:call-template name="directory_pictures"/>
        <xsl:call-template name="document_mimetype"/>
        <xsl:call-template name="document_manifest"/>
        <xsl:call-template name="document_meta"/>
        <xsl:call-template name="document_styles">
            <xsl:with-param name="country"/>
        </xsl:call-template>
        <xsl:call-template name="document_settings"/>
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}content.xml" format="odfxml">
            <office:document-content xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0" xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0" xmlns:ooo="http://openoffice.org/2004/office" xmlns:ooow="http://openoffice.org/2004/writer" xmlns:oooc="http://openoffice.org/2004/calc" xmlns:dom="http://www.w3.org/2001/xml-events" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" office:version="1.0">
                <office:scripts/>
                <office:font-face-decls>
                    <style:font-face style:name="Tahoma1" svg:font-family="Tahoma"/>
                    <style:font-face style:name="Thorndale AMT" svg:font-family="&apos;Thorndale AMT&apos;" style:font-family-generic="roman" style:font-pitch="variable"/>
                    <style:font-face style:name="Albany AMT" svg:font-family="&apos;Albany AMT&apos;" style:font-family-generic="swiss" style:font-pitch="variable"/>
                    <style:font-face style:name="Arial Unicode MS" svg:font-family="&apos;Arial Unicode MS&apos;" style:font-family-generic="system" style:font-pitch="variable"/>
                    <style:font-face style:name="MS Mincho" svg:font-family="&apos;MS Mincho&apos;" style:font-family-generic="system" style:font-pitch="variable"/>
                    <style:font-face style:name="Tahoma" svg:font-family="Tahoma" style:font-family-generic="system" style:font-pitch="variable"/>
                </office:font-face-decls>
                <!-- here you find the declarations of styles-->
                <!-- style for pagebreak -->
                <office:automatic-styles>
                    <xsl:choose>
                        <xsl:when test="$multiple='on'">
                            <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                                <xsl:for-each select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson//elml:column">
                                    <xsl:choose>
                                        <xsl:when test="not(child::elml:columnMiddle)">
                                            <style:style style:name="columntwo" style:family="section">
                                                <xsl:attribute name="style:name">
                                                    <xsl:value-of>column</xsl:value-of>
                                                    <xsl:value-of select="string-length()"/>
                                                    <xsl:value-of>o_</xsl:value-of>
                                                    <xsl:value-of select="count(descendant-or-self::node())"/>
                                                    <xsl:value-of select="@label"/>
                                                </xsl:attribute>
                                                <style:section-properties text:dont-balance-text-columns="true" style:editable="true">
                                                    <style:columns fo:column-count="2">
                                                        <xsl:for-each select="elml:columnLeft">
                                                            <style:column fo:start-indent="0.5cm" fo:end-indent="0cm">
                                                                <xsl:call-template name="elml:Width"/>
                                                            </style:column>
                                                        </xsl:for-each>
                                                        <xsl:for-each select="elml:columnRight">
                                                            <style:column fo:start-indent="0.5cm" fo:end-indent="0.5cm">
                                                                <xsl:call-template name="elml:Width"/>
                                                            </style:column>
                                                        </xsl:for-each>
                                                    </style:columns>
                                                </style:section-properties>
                                            </style:style>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <style:style style:name="columnthree" style:family="section">
                                                <xsl:attribute name="style:name">
                                                    <xsl:value-of>column</xsl:value-of>
                                                    <xsl:value-of select="string-length()"/>
                                                    <xsl:value-of>m_</xsl:value-of>
                                                    <xsl:value-of select="count(descendant-or-self::node())"/>
                                                    <xsl:value-of select="@label"/>
                                                </xsl:attribute>
                                                <style:section-properties text:dont-balance-text-columns="true" style:editable="true">
                                                    <style:columns fo:column-count="3">
                                                        <xsl:for-each select="elml:columnLeft">
                                                            <style:column fo:start-indent="0.5cm" fo:end-indent="0cm">
                                                                <xsl:call-template name="elml:Width"/>
                                                            </style:column>
                                                        </xsl:for-each>
                                                        <xsl:for-each select="elml:columnMiddle">
                                                            <style:column fo:start-indent="0cm" fo:end-indent="0.5cm">
                                                                <xsl:call-template name="elml:Width"/>
                                                            </style:column>
                                                        </xsl:for-each>
                                                        <xsl:for-each select="elml:columnRight">
                                                            <style:column fo:start-indent="0.5cm" fo:end-indent="0.5cm">
                                                                <xsl:call-template name="elml:Width"/>
                                                            </style:column>
                                                        </xsl:for-each>
                                                    </style:columns>
                                                </style:section-properties>
                                            </style:style>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each>
                                <!-- style for tablewith-->
                                <xsl:for-each select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson//elml:table">
                                    <style:style style:family="table">
                                        <xsl:attribute name="style:name">
                                            <xsl:value-of>table</xsl:value-of>
                                            <xsl:value-of select="string-length()"/>
                                        </xsl:attribute>
                                        <style:table-properties table:align="margins">
                                            <xsl:call-template name="elml:Width"/>
                                        </style:table-properties>
                                    </style:style>
                                </xsl:for-each>
                                <!-- style for tabledatawith-->
                                <xsl:for-each select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson//elml:tabledata[@width]">
                                    <style:style style:family="table-column">
                                        <xsl:attribute name="style:name">
                                            <xsl:call-template name="node-identifier"/>
                                        </xsl:attribute>
                                        <style:table-column-properties table:align="margins">
                                            <xsl:call-template name="elml:Width"/>
                                        </style:table-column-properties>
                                    </style:style>
                                </xsl:for-each>
                                <!-- Caption Styles for Multimedia images-->
                                <xsl:for-each select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson//elml:multimedia[@legend]">
                                    <style:style style:family="text" style:parent-style-name="Caption" style:class="extra">
                                        <xsl:attribute name="style:name">
                                            <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                        </xsl:attribute>
                                    </style:style>
                                </xsl:for-each>
                                <xsl:for-each select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson//elml:multimedia[@legend]">
                                    <style:style style:family="paragraph" style:parent-style-name="Caption" style:class="extra">
                                        <xsl:attribute name="style:name">
                                            <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                        </xsl:attribute>
                                    </style:style>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="elml:generate_Head"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </office:automatic-styles>
                <!-- here ends the declaration of styles-->
                <office:body>
                    <office:text>
                        <xsl:choose>
                            <xsl:when test="$multiple='on'">
                                <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                                    <!-- the hole content of the document -->
                                    <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson"/>
                                    <text:p text:style-name="Standard1"/>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- the hole content of the document -->
                                <xsl:apply-templates/>
                                <text:p text:style-name="Standard1"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </office:text>
                </office:body>
            </office:document-content>
        </xsl:result-document>
    </xsl:template>
    <!-- ******** STRUCTURE ELEMENTS ******** -->
    <!-- elements with title -->
    <!-- <xsl:template match="elml:lesson">
        <xsl:call-template name="elml:generate_Title_Heading"> </xsl:call-template>  
    </xsl:template> -->
    <!-- <xsl:template match="elml:bibliography">
        <xsl:call-template name="elml:generate_Title_Heading"> </xsl:call-template>
        <xsl:for-each select="child::*">
            <text:p text:style-name="Bibliography">
                <xsl:element name="text:bookmark">
                    <xsl:attribute name="text:name">
                        <xsl:value-of select="@bibID"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:value-of select="@term"/>
                <xsl:if test="@author">
                    <text:span><xsl:value-of select="@author"/>, </text:span>
                </xsl:if>
                <xsl:if test="@title">
                    <text:span text:style-name="italic"><xsl:value-of select="@title"/>, </text:span>
                </xsl:if>
                <xsl:if test="name()='contributionInBook'"> in: <xsl:value-of> </xsl:value-of>
                    <xsl:if test="@editor">
                        <xsl:value-of select="@editor"/>, <xsl:value-of> </xsl:value-of>
                    </xsl:if>
                    <xsl:if test="@titleOfContribution">
                        <text:span text:style-name="italic">
                            <xsl:value-of select="@titleOfContribution"/>
                        </text:span>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="@publicationPlace">
                    <text:span><xsl:value-of select="@publicationPlace"/>, </text:span>
                </xsl:if>
                <xsl:if test="@publicationYear">
                    <text:span><xsl:value-of select="@publicationYear"/>. </text:span>
                </xsl:if>
                <xsl:if test="@pageNr">
                    <text:span>
                        <xsl:value-of select="@pageNr"/>
                    </text:span>
                </xsl:if>
            </text:p>
        </xsl:for-each>
    </xsl:template> -->
    <xsl:template match="elml:furtherReading">
        <xsl:call-template name="elml:generate_Title_Heading"> </xsl:call-template>
        <xsl:choose>
            <xsl:when test="@sorting='off'">
                <text:list text:style-name="furtherReading">
                    <xsl:for-each select="elml:resItem">
                        <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]">
                            <xsl:with-param name="comment" select="text()"/>
                            <xsl:with-param name="furtherReading" select="@bibIDRef"/>
                            <xsl:with-param name="pageNr" select="@pageNr"/>
                        </xsl:apply-templates>
                    </xsl:for-each>
                </text:list>
            </xsl:when>
            <xsl:when test="@sorting='byYear'">
                <text:list text:style-name="furtherReading">
                    <xsl:for-each select="elml:resItem">
                        <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@publicationYear" order="descending" lang="{$lang}"/>
                        <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]">
                            <xsl:with-param name="comment" select="text()"/>
                            <xsl:with-param name="furtherReading" select="@bibIDRef"/>
                            <xsl:with-param name="pageNr" select="@pageNr"/>
                        </xsl:apply-templates>
                    </xsl:for-each>
                </text:list>
            </xsl:when>
            <xsl:when test="@sorting='groupByType'">
                <xsl:for-each-group select="elml:resItem/@bibIDRef" group-by="/elml:lesson/elml:bibliography/*[@bibID=current()]/name()">
                    <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/name()" order="ascending" lang="{$lang}"/>
                    <text:h text:outline-level="2">
                        <xsl:call-template name="elml:name_biblio">
                            <xsl:with-param name="itemname" select="name(/elml:lesson/elml:bibliography/*[@bibID=current()])"/>
                        </xsl:call-template>
                    </text:h>
                    <text:list text:style-name="furtherReading">
                        <xsl:for-each select="current-group()">
                            <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@author" order="ascending" lang="{$lang}"/>
                            <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()]">
                                <xsl:with-param name="comment" select="../text()"/>
                                <xsl:with-param name="furtherReading" select="current()"/>
                                <xsl:with-param name="pageNr" select="../@pageNr"/>
                            </xsl:apply-templates>
                        </xsl:for-each>
                    </text:list>
                </xsl:for-each-group>
            </xsl:when>
            <xsl:when test="@sorting='groupByYear'">
                <xsl:for-each-group select="elml:resItem/@bibIDRef" group-by="/elml:lesson/elml:bibliography/*[@bibID=current()]/@publicationYear">
                    <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@publicationYear" order="descending" lang="{$lang}"/>
                    <text:h text:outline-level="2">
                        <xsl:value-of select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@publicationYear"/>
                    </text:h>
                    <text:list text:style-name="furtherReading">
                        <xsl:for-each select="current-group()">
                            <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()]/@author"/>
                            <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()]">
                                <xsl:with-param name="comment" select="../text()"/>
                                <xsl:with-param name="furtherReading" select="current()"/>
                                <xsl:with-param name="pageNr" select="../@pageNr"/>
                            </xsl:apply-templates>
                        </xsl:for-each>
                    </text:list>
                </xsl:for-each-group>
            </xsl:when>
            <xsl:otherwise>
                <text:list text:style-name="furtherReading">
                    <xsl:for-each select="elml:resItem">
                        <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@author" order="ascending" lang="{$lang}"/>
                        <xsl:apply-templates select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]">
                            <xsl:with-param name="comment" select="text()"/>
                            <xsl:with-param name="furtherReading" select="@bibIDRef"/>
                            <xsl:with-param name="pageNr" select="@pageNr"/>
                        </xsl:apply-templates>
                    </xsl:for-each>
                </text:list>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:bibliography">
        <xsl:call-template name="elml:generate_Title_Heading"> </xsl:call-template>
        <xsl:choose>
            <xsl:when test="@sorting='off'">
                <text:list text:style-name="bibliography">
                    <xsl:apply-templates/>
                </text:list>
            </xsl:when>
            <xsl:when test="@sorting='byYear'">
                <text:list text:style-name="bibliography">
                    <xsl:apply-templates>
                        <xsl:sort select="@publicationYear" order="descending" lang="{$lang}"/>
                    </xsl:apply-templates>
                </text:list>
            </xsl:when>
            <xsl:when test="@sorting='groupByType'">
                <xsl:for-each-group select="node()" group-by="name()">
                    <xsl:sort select="name()" order="ascending" lang="{$lang}"/>
                    <text:h text:outline-level="2">
                        <xsl:call-template name="elml:name_biblio">
                            <xsl:with-param name="itemname" select="name()"/>
                        </xsl:call-template>
                    </text:h>
                    <text:list text:style-name="bibliography">
                        <xsl:apply-templates select="current-group()">
                            <xsl:sort select="@author" order="ascending" lang="{$lang}"/>
                        </xsl:apply-templates>
                    </text:list>
                </xsl:for-each-group>
            </xsl:when>
            <xsl:when test="@sorting='groupByYear'">
                <xsl:for-each-group select="node()" group-by="@publicationYear">
                    <xsl:sort select="@publicationYear" order="descending" lang="{$lang}"/>
                    <text:h text:outline-level="2">
                        <xsl:value-of select="@publicationYear"/>
                    </text:h>
                    <text:list text:style-name="bibliography">
                        <xsl:apply-templates select="current-group()">
                            <xsl:sort select="@author" order="ascending" lang="{$lang}"/>
                        </xsl:apply-templates>
                    </text:list>
                </xsl:for-each-group>
            </xsl:when>
            <xsl:otherwise>
                <text:list text:style-name="bibliography">
                    <xsl:apply-templates>
                        <xsl:sort select="@author" order="ascending" lang="{$lang}"/>
                    </xsl:apply-templates>
                </text:list>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:resItem">
        <xsl:param name="bibIDRef">
            <xsl:value-of select="@bibIDRef"/>
        </xsl:param>

        <xsl:if test="/elml:lesson/elml:bibliography/*[@bibID=$bibIDRef]">

            <xsl:for-each select="/elml:lesson/elml:bibliography/*[@bibID=$bibIDRef]">
                <xsl:if test="@author or @publicationyear">
                    <text:p text:style-name="Bibliography">
                        <text:span>
                            <xsl:if test="@author">
                                <xsl:value-of select="@author"/>
                            </xsl:if>
                            <xsl:if test="@author and @publicationYear">
                                <xsl:value-of select="' '"/>
                            </xsl:if>
                            <xsl:if test="@publicationYear">
                                <xsl:value-of select="@publicationYear"/>
                            </xsl:if>
                        </text:span>
                    </text:p>
                </xsl:if>
            </xsl:for-each>



        </xsl:if>

        <!-- <xsl:apply-templates mode="inline"/>  -->

    </xsl:template>
    <xsl:template match="elml:lesson | elml:unit | elml:learningObject | elml:selfAssessment | elml:summary | elml:glossary | elml:listoffigures | elml:listoftables | elml:index">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:call-template name="elml:generate_Title_Heading"> </xsl:call-template>
            <xsl:apply-templates/>
            <!-- <xsl:choose>
                 <xsl:when test="$multiple='on' and name='*'">
                    <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                        <xsl:if test="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson//elml:glossary">
                        
                    </xsl:if>  
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="//elml:glossary">
                        <xsl:call-template name="glossary"/>
                    </xsl:if>   
                    
                </xsl:otherwise>
            </xsl:choose> -->
            <xsl:if test="name()='glossary'">
                <xsl:call-template name="glossary"/>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <!-- sections with optional title -->
    <xsl:template match="elml:entry | elml:clarify | elml:look | elml:act">
        <xsl:if test="@title">
            <xsl:call-template name="elml:generate_Title_Heading"/>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    <!-- goals -->
    <xsl:template match="elml:goals">
        <xsl:if test="elml:lObjective">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>
    <!-- lObjective -->
    <xsl:template match="elml:lObjective">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <text:p text:style-name="Standard1">
                <xsl:apply-templates/>
            </text:p>
        </xsl:if>
    </xsl:template>
    <!-- ******** CONTENT ELEMENTS ******** -->
    <!-- text node -->
    <xsl:template match="text()">
        <xsl:param name="is_the_empty_string">
            <xsl:choose>
                <xsl:when test="string(.) = '' ">
                    <xsl:value-of>yes</xsl:value-of>
                </xsl:when>
                <xsl:otherwise>no</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="parent::elml:paragraph | parent::elml:box | parent::elml:item | parent::elml:tabledata | parent::elml:popup | parent::elml:tableheading | parent::elml:annotation | parent::elml:definition | parent::elml:answer | parent::elml:solution | parent::elml:question">
                <xsl:element name="text:span">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="parent::elml:formatted | parent::elml:link | parent::elml:term | parent::elml:indexItem | parent::elml:citation">
                <xsl:value-of select="."/>
            </xsl:when>
            <xsl:when test="parent::elml:columnRight | parent::elml:columnMiddle | parent::elml:columnLeft">
                <xsl:element name="text:p">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$is_the_empty_string = 'yes'"/>
            <xsl:otherwise>
                <xsl:element name="text:span">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- elml:paragraph -->
    <xsl:template match="elml:paragraph">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:choose>
                <!-- case1 -->
                <xsl:when test="parent::elml:box | parent::elml:item | parent::elml:tabledata | parent::elml:annotation | parent::elml:definition">
                    <xsl:if test="@title">
                        <xsl:call-template name="elml:generate_Title_span"/>
                    </xsl:if>
                    <text:line-break/>
                    <xsl:call-template name="elml:Label"/>
                    <text:span>
                        <xsl:choose>
                            <xsl:when test="@cssClass and $enable_project_styles='yes'">
                                <xsl:attribute name="text:style-name">
                                    <xsl:value-of select="@cssClass"/>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="text:style-name">
                                    <xsl:value-of>Standard1</xsl:value-of>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:apply-templates/>
                    </text:span>
                </xsl:when>
                <!-- case2 -->

                <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                    <xsl:choose>
                        <xsl:when test="@title">
                            <text:p text:style-name="columnbreak">

                                <xsl:call-template name="elml:generate_Title_span"/>
                                <text:line-break/>
                                <text:span text:style-name="columnbreak">
                                    <xsl:call-template name="elml:Label"/>
                                    <xsl:apply-templates/>
                                </text:span>
                            </text:p>
                        </xsl:when>
                        <xsl:otherwise>
                            <text:p text:style-name="columnbreak">


                                <text:span text:style-name="columnbreak">
                                    <xsl:call-template name="elml:Label"/>
                                    <xsl:apply-templates/>
                                </text:span>
                            </text:p>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>

                <!-- default case -->
                <xsl:otherwise>
                    <xsl:if test="@title">
                        <xsl:call-template name="elml:generate_Title_Heading"/>
                    </xsl:if>
                    <text:p>
                        <xsl:choose>
                            <xsl:when test="@cssClass and $enable_project_styles='yes'">
                                <xsl:attribute name="text:style-name">
                                    <xsl:value-of select="@cssClass"/>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="text:style-name">
                                    <xsl:value-of>Standard1</xsl:value-of>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:call-template name="elml:Label"/>
                        <xsl:apply-templates/>
                    </text:p>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <!-- elml:column -->
    <xsl:template match="elml:column">
        <xsl:param name="labeladd">
            <xsl:if test="@label">
                <xsl:value-of select="/elml:lesson/@label"/>
                <xsl:text>_</xsl:text>
                <xsl:value-of select="@label"/>
            </xsl:if>
        </xsl:param>
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:choose>
                <xsl:when test="parent::elml:box | parent::elml:popup">
                    <xsl:choose>
                        <xsl:when test="elml:columnMiddle">
                            <draw:frame text:anchor-type="as-char" style:rel-width="69%" draw:z-index="0">
                                <draw:text-box>
                                    <text:section text:style-name="columnthree" text:name="Section2">
                                        <xsl:apply-templates/>
                                    </text:section>
                                </draw:text-box>
                            </draw:frame>
                        </xsl:when>
                        <xsl:otherwise>
                            <draw:frame text:anchor-type="as-char" style:rel-width="69%" draw:z-index="0">
                                <draw:text-box>
                                    <text:section text:style-name="columntwo" text:name="Section1">
                                        <xsl:apply-templates/>
                                    </text:section>
                                </draw:text-box>
                            </draw:frame>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="elml:columnMiddle">
                            <text:section>
                                <xsl:attribute name="text:name">
                                    <xsl:value-of>column</xsl:value-of>
                                    <xsl:value-of select="string-length()"/>
                                    <xsl:value-of>m_</xsl:value-of>
                                    <xsl:value-of select="count(descendant-or-self::node())"/>
                                    <xsl:value-of select="@label"/>
                                </xsl:attribute>
                                <xsl:attribute name="text:style-name">
                                    <xsl:value-of>column</xsl:value-of>
                                    <xsl:value-of select="string-length()"/>
                                    <xsl:value-of>m_</xsl:value-of>
                                    <xsl:value-of select="count(descendant-or-self::node())"/>
                                    <xsl:value-of select="@label"/>
                                </xsl:attribute>
                                <xsl:apply-templates/>
                            </text:section>
                        </xsl:when>
                        <xsl:otherwise>
                            <text:section>
                                <xsl:attribute name="text:name">
                                    <xsl:value-of>column</xsl:value-of>
                                    <xsl:value-of select="string-length()"/>
                                    <xsl:value-of>o_</xsl:value-of>
                                    <xsl:value-of select="count(descendant-or-self::node())"/>
                                    <xsl:value-of select="@label"/>
                                </xsl:attribute>
                                <xsl:attribute name="text:style-name">
                                    <xsl:value-of>column</xsl:value-of>
                                    <xsl:value-of select="string-length()"/>
                                    <xsl:value-of>o_</xsl:value-of>
                                    <xsl:value-of select="count(descendant-or-self::node())"/>
                                    <xsl:value-of select="@label"/>
                                </xsl:attribute>
                                <xsl:apply-templates/>
                            </text:section>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <!-- elml:columnLeft | elml:columnMiddle | elml:columnRight -->
    <xsl:template match="elml:columnLeft | elml:columnMiddle | elml:columnRight">
        <xsl:choose>
            <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                <xsl:attribute name="text:style-name">
                    <xsl:text>columnbreak</xsl:text>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        <xsl:apply-templates/>
    </xsl:template>
    <!-- elml:box-->
    <xsl:template match="elml:box">
        <xsl:choose>
            <xsl:when test="parent::elml:tabledata">
                <text:span text:style-name="paragraphBox">
                    <xsl:apply-templates/>
                </text:span>
            </xsl:when>
            <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                <text:p text:style-name="columnbreak"> </text:p>
                <text:p text:style-name="ParagraphBox">
                    <xsl:apply-templates/>
                </text:p>
            </xsl:when>
            <xsl:otherwise>
                <text:p text:style-name="ParagraphBox">
                    <xsl:apply-templates/>
                </text:p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- elml:mulimedia-->
    <xsl:template match="elml:multimedia">
        <xsl:param name="isBlock">
            <xsl:choose>
                <xsl:when test="not(../text()) and ((boolean(name(preceding-sibling::*[1])) or boolean(name(following-sibling::*[1]))) or (count(../*)=number('1') and (name(parent::*)='look' or name(parent::*)='act' or name(parent::*)='clarify' or name(parent::*)='columnLeft' or name(parent::*)='columnMiddle' or name(parent::*)='columnRight' or name(parent::*)='entry' or name(parent::*)='selfAssessment' or name(parent::*)='summary')) and not(name(parent::*)='link'))">
                    <xsl:text>_block</xsl:text>
                </xsl:when>
                <xsl:otherwise>_inline</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:param name="lastindexof">
            <xsl:call-template name="lastindexofstring"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:choose>
                <!-- case image format -->
                <xsl:when test="@type='jpeg' or @type='png' or @type='gif'">
                    <xsl:choose>
                        <!-- case block -->
                        <xsl:when test="$isBlock = '_block'">
                            <!-- case block and columnbreak -->
                            <xsl:choose>
                                <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                                    <text:p text:style-name="columnbreak">
                                        <!-- case block and columnbreak -->
                                        <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                            <xsl:attribute name="svg:width">
                                                <xsl:call-template name="elml:Width"/>
                                            </xsl:attribute>
                                            <xsl:choose>
                                                <xsl:when test="@align">
                                                    <xsl:attribute name="draw:style-name">
                                                        <xsl:value-of select="concat('frame__', @align, $isBlock)"/>
                                                    </xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="draw:style-name">frame__center_block</xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            <draw:text-box>
                                                <xsl:if test="@title">
                                                    <xsl:call-template name="elml:generate_Title_Heading"/>
                                                </xsl:if>
                                                <text:p>
                                                    <xsl:if test="@legend">
                                                        <xsl:attribute name="text:style-name">
                                                            <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                                        </xsl:attribute>
                                                    </xsl:if>
                                                    <draw:frame draw:name="graphics1" text:anchor-type="paragraph">
                                                        <xsl:choose>
                                                            <xsl:when test="@align">
                                                                <xsl:attribute name="draw:style-name">
                                                                    <xsl:value-of select="concat('singleimage_', @align, $isBlock)"/>
                                                                </xsl:attribute>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:attribute name="draw:style-name">center_inline</xsl:attribute>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:call-template name="elml:Width"/>
                                                        <xsl:call-template name="elml:Height"/>
                                                        <draw:image xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
                                                            <xsl:attribute name="xlink:href">
                                                                <xsl:value-of>Pictures</xsl:value-of>
                                                                <xsl:choose>
                                                                    <xsl:when test="@thumbnail">
                                                                        <xsl:value-of select="substring(@thumbnail,$lastindexof)"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="substring(@src,$lastindexof)"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:attribute>
                                                        </draw:image>
                                                    </draw:frame>
                                                    <xsl:if test="@legend">
                                                        <xsl:value-of select="@legend"/>
                                                    </xsl:if>
                                                    <xsl:call-template name="elml:BibliographyRef"/>
                                                </text:p>
                                            </draw:text-box>
                                        </draw:frame>
                                    </text:p>
                                </xsl:when>
                                <xsl:when test="parent::elml:box | parent::elml:item">
                                    <!-- case block and within a elml:box -->
                                    <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                        <xsl:attribute name="svg:width">
                                            <xsl:call-template name="elml:Width"/>
                                        </xsl:attribute>
                                        <xsl:choose>
                                            <xsl:when test="@align">
                                                <xsl:attribute name="draw:style-name">
                                                    <xsl:value-of select="concat('frame__', @align, $isBlock)"/>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="draw:style-name">frame__center_block</xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <draw:text-box>
                                            <xsl:if test="@title">
                                                <xsl:call-template name="elml:generate_Title_Heading"/>
                                            </xsl:if>
                                            <text:p>
                                                <xsl:if test="@legend">
                                                    <xsl:attribute name="text:style-name">
                                                        <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                                    </xsl:attribute>
                                                </xsl:if>
                                                <draw:frame draw:name="graphics1" text:anchor-type="paragraph">
                                                    <xsl:choose>
                                                        <xsl:when test="@align">
                                                            <xsl:attribute name="draw:style-name">
                                                                <xsl:value-of select="concat('singleimage_', @align, $isBlock)"/>
                                                            </xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="draw:style-name">center_inline</xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                    <xsl:call-template name="elml:Width"/>
                                                    <xsl:call-template name="elml:Height"/>
                                                    <draw:image xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
                                                        <xsl:attribute name="xlink:href">
                                                            <xsl:value-of>Pictures</xsl:value-of>
                                                            <xsl:choose>
                                                                <xsl:when test="@thumbnail">
                                                                    <xsl:value-of select="substring(@thumbnail,$lastindexof)"/>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:value-of select="substring(@src,$lastindexof)"/>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:attribute>
                                                    </draw:image>
                                                </draw:frame>
                                                <xsl:if test="@legend">
                                                    <xsl:value-of select="@legend"/>
                                                </xsl:if>
                                                <xsl:call-template name="elml:BibliographyRef"/>
                                            </text:p>
                                        </draw:text-box>
                                    </draw:frame>
                                </xsl:when>
                                <!-- case block default -->
                                <xsl:otherwise>
                                    <text:p>
                                        <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                            <xsl:attribute name="svg:width">
                                                <xsl:call-template name="elml:Width"/>
                                            </xsl:attribute>
                                            <xsl:choose>
                                                <xsl:when test="@align">
                                                    <xsl:attribute name="draw:style-name">
                                                        <xsl:value-of select="concat('frame__', @align, $isBlock)"/>
                                                    </xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="draw:style-name">frame__center_block</xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            <draw:text-box>
                                                <xsl:if test="@title">
                                                    <xsl:call-template name="elml:generate_Title_Heading"/>
                                                </xsl:if>
                                                <text:p>
                                                    <xsl:if test="@legend">
                                                        <xsl:attribute name="text:style-name">
                                                            <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                                        </xsl:attribute>
                                                    </xsl:if>
                                                    <draw:frame draw:name="graphics1" text:anchor-type="paragraph">
                                                        <xsl:choose>
                                                            <xsl:when test="@align">
                                                                <xsl:attribute name="draw:style-name">
                                                                    <xsl:value-of select="concat('singleimage_', @align, $isBlock)"/>
                                                                </xsl:attribute>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:attribute name="draw:style-name">center_inline</xsl:attribute>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:call-template name="elml:Width"/>
                                                        <xsl:call-template name="elml:Height"/>
                                                        <draw:image xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
                                                            <xsl:attribute name="xlink:href">
                                                                <xsl:value-of>Pictures</xsl:value-of>
                                                                <xsl:choose>
                                                                    <xsl:when test="@thumbnail">
                                                                        <xsl:value-of select="substring(@thumbnail,$lastindexof)"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="substring(@src,$lastindexof)"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:attribute>
                                                        </draw:image>
                                                    </draw:frame>
                                                    <xsl:if test="@legend">
                                                        <xsl:value-of select="@legend"/>
                                                    </xsl:if>
                                                    <xsl:call-template name="elml:BibliographyRef"/>
                                                </text:p>
                                            </draw:text-box>
                                        </draw:frame>
                                    </text:p>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <!-- case inline -->
                        <xsl:otherwise>
                            <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                <xsl:attribute name="svg:width">
                                    <xsl:call-template name="elml:Width"/>
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="@align">
                                        <xsl:attribute name="draw:style-name">
                                            <xsl:value-of select="concat('frame__', @align, $isBlock)"/>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="draw:style-name">frame__center_inline</xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <draw:text-box>
                                    <xsl:if test="@title">
                                        <xsl:call-template name="elml:generate_Title_Heading"/>
                                    </xsl:if>
                                    <text:p>
                                        <xsl:if test="@legend">
                                            <xsl:attribute name="text:style-name">
                                                <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <draw:frame draw:name="graphics1" text:anchor-type="paragraph">
                                            <xsl:choose>
                                                <xsl:when test="@align">
                                                    <xsl:attribute name="draw:style-name">
                                                        <xsl:value-of select="concat('singleimage_', @align, $isBlock)"/>
                                                    </xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="draw:style-name">center</xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            <xsl:call-template name="elml:Width"/>
                                            <xsl:call-template name="elml:Height"/>
                                            <draw:image xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
                                                <xsl:attribute name="xlink:href">
                                                    <xsl:value-of>Pictures</xsl:value-of>
                                                    <xsl:choose>
                                                        <xsl:when test="@thumbnail">
                                                            <xsl:value-of select="substring(@thumbnail,$lastindexof)"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="substring(@src,$lastindexof)"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:attribute>
                                            </draw:image>
                                        </draw:frame>
                                        <xsl:if test="@legend">
                                            <xsl:value-of select="@legend"/>
                                        </xsl:if>
                                        <xsl:call-template name="elml:BibliographyRef"/>
                                    </text:p>
                                </draw:text-box>
                            </draw:frame>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <!-- case mpgeg or mp3 or quicktime format -->
                <xsl:when test="@type='mpeg' or @type='mp3' or @type='quicktime' or type='QuickTime' ">
                    <xsl:choose>
                        <!-- case block -->
                        <xsl:when test="$isBlock = '_block'">
                            <!-- case block and columnbreak -->
                            <xsl:choose>
                                <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                                    <text:p text:style-name="columnbreak">
                                        <!-- case block and columnbreak -->
                                        <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                            <xsl:attribute name="svg:width">
                                                <xsl:call-template name="elml:Width"/>
                                            </xsl:attribute>
                                            <xsl:choose>
                                                <xsl:when test="@align">
                                                    <xsl:attribute name="draw:style-name">
                                                        <xsl:value-of select="concat('frame__', @align, $isBlock)"/>
                                                    </xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="draw:style-name">frame__center_block</xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            <draw:text-box>
                                                <xsl:if test="@title">
                                                    <xsl:call-template name="elml:generate_Title_Heading"/>
                                                </xsl:if>
                                                <text:p>
                                                    <xsl:if test="@legend">
                                                        <xsl:attribute name="text:style-name">
                                                            <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                                        </xsl:attribute>
                                                    </xsl:if>
                                                    <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                                        <xsl:choose>
                                                            <xsl:when test="@align">
                                                                <xsl:attribute name="draw:style-name">
                                                                    <xsl:value-of select="concat('plugin_', @align, $isBlock)"/>
                                                                </xsl:attribute>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:attribute name="draw:style-name">plugin_center_inline</xsl:attribute>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:call-template name="elml:Width"/>
                                                        <xsl:call-template name="elml:Height"/>
                                                        <draw:plugin xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad" draw:mime-type="application/vnd.sun.star.media">
                                                            <xsl:attribute name="xlink:href">
                                                                <xsl:value-of>../../multimedia</xsl:value-of>
                                                                <!-- <xsl:choose>
                                                                    <xsl:when test="@thumbnail">
                                                                        <xsl:value-of select="substring(@thumbnail,$lastindexof)"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise> -->
                                                                <xsl:value-of select="substring(@src,$lastindexof)"/>
                                                                <!--    </xsl:otherwise>
                                                                </xsl:choose> -->
                                                            </xsl:attribute>
                                                        </draw:plugin>
                                                    </draw:frame>
                                                    <xsl:if test="@legend">
                                                        <xsl:value-of select="@legend"/>
                                                    </xsl:if>
                                                    <xsl:call-template name="elml:BibliographyRef"/>
                                                </text:p>
                                            </draw:text-box>
                                        </draw:frame>
                                    </text:p>
                                </xsl:when>
                                <xsl:when test="parent::elml:box | parent::elml:item">
                                    <!-- case block and within a elml:box -->
                                    <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                        <xsl:attribute name="svg:width">
                                            <xsl:call-template name="elml:Width"/>
                                        </xsl:attribute>
                                        <xsl:choose>
                                            <xsl:when test="@align">
                                                <xsl:attribute name="draw:style-name">
                                                    <xsl:value-of select="concat('frame__', @align, $isBlock)"/>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="draw:style-name">frame__center_block</xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <draw:text-box>
                                            <xsl:if test="@title">
                                                <xsl:call-template name="elml:generate_Title_Heading"/>
                                            </xsl:if>
                                            <text:p>
                                                <xsl:if test="@legend">
                                                    <xsl:attribute name="text:style-name">
                                                        <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                                    </xsl:attribute>
                                                </xsl:if>
                                                <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                                    <xsl:choose>
                                                        <xsl:when test="@align">
                                                            <xsl:attribute name="draw:style-name">
                                                                <xsl:value-of select="concat('plugin_', @align, $isBlock)"/>
                                                            </xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="draw:style-name">plugin_center_inline</xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                    <xsl:call-template name="elml:Width"/>
                                                    <xsl:call-template name="elml:Height"/>
                                                    <draw:plugin xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad" draw:mime-type="application/vnd.sun.star.media">
                                                        <xsl:attribute name="xlink:href">
                                                            <xsl:value-of>../../multimedia</xsl:value-of>
                                                            <!-- <xsl:choose>
                                                                <xsl:when test="@thumbnail">
                                                                <xsl:value-of select="substring(@thumbnail,$lastindexof)"/>
                                                                </xsl:when>
                                                                <xsl:otherwise> -->
                                                            <xsl:value-of select="substring(@src,$lastindexof)"/>
                                                            <!--    </xsl:otherwise>
                                                                </xsl:choose> -->
                                                        </xsl:attribute>
                                                    </draw:plugin>
                                                </draw:frame>
                                                <xsl:if test="@legend">
                                                    <xsl:value-of select="@legend"/>
                                                </xsl:if>
                                                <xsl:call-template name="elml:BibliographyRef"/>
                                            </text:p>
                                        </draw:text-box>
                                    </draw:frame>
                                </xsl:when>
                                <!-- case block default -->
                                <xsl:otherwise>
                                    <text:p>
                                        <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                            <xsl:attribute name="svg:width">
                                                <xsl:call-template name="elml:Width"/>
                                            </xsl:attribute>
                                            <xsl:choose>
                                                <xsl:when test="@align">
                                                    <xsl:attribute name="draw:style-name">
                                                        <xsl:value-of select="concat('frame__', @align, $isBlock)"/>
                                                    </xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="draw:style-name">frame__center_block</xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            <draw:text-box>
                                                <xsl:if test="@title">
                                                    <xsl:call-template name="elml:generate_Title_Heading"/>
                                                </xsl:if>
                                                <text:p>
                                                    <xsl:if test="@legend">
                                                        <xsl:attribute name="text:style-name">
                                                            <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                                        </xsl:attribute>
                                                    </xsl:if>
                                                    <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                                        <xsl:choose>
                                                            <xsl:when test="@align">
                                                                <xsl:attribute name="draw:style-name">
                                                                    <xsl:value-of select="concat('plugin_', @align, $isBlock)"/>
                                                                </xsl:attribute>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:attribute name="draw:style-name">plugin_center_inline</xsl:attribute>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:call-template name="elml:Width"/>
                                                        <xsl:call-template name="elml:Height"/>
                                                        <draw:plugin xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad" draw:mime-type="application/vnd.sun.star.media">
                                                            <xsl:attribute name="xlink:href">
                                                                <xsl:value-of>../../multimedia</xsl:value-of>
                                                                <!-- <xsl:choose>
                                                                    <xsl:when test="@thumbnail">
                                                                    <xsl:value-of select="substring(@thumbnail,$lastindexof)"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise> -->
                                                                <xsl:value-of select="substring(@src,$lastindexof)"/>
                                                                <!--    </xsl:otherwise>
                                                                    </xsl:choose> -->
                                                            </xsl:attribute>
                                                        </draw:plugin>
                                                    </draw:frame>
                                                    <xsl:if test="@legend">
                                                        <xsl:value-of select="@legend"/>
                                                    </xsl:if>
                                                    <xsl:call-template name="elml:BibliographyRef"/>
                                                </text:p>
                                            </draw:text-box>
                                        </draw:frame>
                                    </text:p>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <!-- case inline -->
                        <xsl:otherwise>
                            <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                <xsl:attribute name="svg:width">
                                    <xsl:call-template name="elml:Width"/>
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="@align">
                                        <xsl:attribute name="draw:style-name">
                                            <xsl:value-of select="concat('frame__', @align, $isBlock)"/>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="draw:style-name">frame__center_inline</xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <draw:text-box>
                                    <xsl:if test="@title">
                                        <xsl:call-template name="elml:generate_Title_Heading"/>
                                    </xsl:if>
                                    <text:p>
                                        <xsl:if test="@legend">
                                            <xsl:attribute name="text:style-name">
                                                <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                            <xsl:choose>
                                                <xsl:when test="@align">
                                                    <xsl:attribute name="draw:style-name">
                                                        <xsl:value-of select="concat('plugin_', @align, $isBlock)"/>
                                                    </xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="draw:style-name">plugin_center_inline</xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            <xsl:call-template name="elml:Width"/>
                                            <xsl:call-template name="elml:Height"/>
                                            <draw:plugin xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad" draw:mime-type="application/vnd.sun.star.media">
                                                <xsl:attribute name="xlink:href">
                                                    <xsl:value-of>../../multimedia</xsl:value-of>
                                                    <!-- <xsl:choose>
                                                        <xsl:when test="@thumbnail">
                                                        <xsl:value-of select="substring(@thumbnail,$lastindexof)"/>
                                                        </xsl:when>
                                                        <xsl:otherwise> -->
                                                    <xsl:value-of select="substring(@src,$lastindexof)"/>
                                                    <!--    </xsl:otherwise>
                                                        </xsl:choose> -->
                                                </xsl:attribute>
                                            </draw:plugin>
                                        </draw:frame>
                                        <xsl:if test="@legend">
                                            <xsl:value-of select="@legend"/>
                                        </xsl:if>
                                        <xsl:call-template name="elml:BibliographyRef"/>
                                    </text:p>
                                </draw:text-box>
                            </draw:frame>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <!-- case mathml format -->
                <!-- Restrictions: 1. Mathml can only been included as a file. Writing mathml syntax within the 
                    elml:multimedia is not implemented so far.
                    2. You have to save all your mathml xml files in your lesson within the odf/Objects/multimedia/mathml directory
                    (probably you have to create these three Folder first within the odf directory)
                    3. For every mathml xml file you have to create an own folder within Objects/multimedia/mathml (example: OBJECTSmultimedia/mathml/cosinus)
                    4. within such a folder (for example 'cosinus') only two files are allowed: content.xml and settings.xml.
                    5. in the xml file of your lesson then write for the src attribute of the multimedia element the path to specific folder 
                    (example:  'src="../Objects/multimedia/mathml/cosinus"'
                -->
                <xsl:when test="@type='mathml'">
                    <xsl:choose>
                        <!-- case block -->
                        <xsl:when test="$isBlock = '_block'">
                            <!-- case block and columnbreak -->
                            <xsl:choose>
                                <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                                    <text:p text:style-name="columnbreak">
                                        <!-- case block and columnbreak -->
                                        <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                            <xsl:attribute name="svg:width">
                                                <xsl:call-template name="elml:Width"/>
                                            </xsl:attribute>
                                            <xsl:choose>
                                                <xsl:when test="@align">
                                                    <xsl:attribute name="draw:style-name">
                                                        <xsl:value-of select="concat('frame__', @align, $isBlock)"/>
                                                    </xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="draw:style-name">frame__center_block</xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            <draw:text-box>
                                                <xsl:if test="@title">
                                                    <xsl:call-template name="elml:generate_Title_Heading"/>
                                                </xsl:if>
                                                <text:p>
                                                    <xsl:if test="@legend">
                                                        <xsl:attribute name="text:style-name">
                                                            <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                                        </xsl:attribute>
                                                    </xsl:if>
                                                    <draw:frame text:anchor-type="as-char" draw:z-index="0">
                                                        <xsl:choose>
                                                            <xsl:when test="@align">
                                                                <xsl:attribute name="draw:style-name">
                                                                    <xsl:value-of select="concat('mathml_', @align, $isBlock)"/>
                                                                </xsl:attribute>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:attribute name="draw:style-name">mathml_center_inline</xsl:attribute>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:attribute name="draw:name">
                                                            <xsl:value-of select="substring-after(substring(@src,$lastindexof),'/')"/>
                                                        </xsl:attribute>
                                                        <xsl:call-template name="elml:Width"/>
                                                        <xsl:call-template name="elml:Height"/>
                                                        <draw:object xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
                                                            <xsl:attribute name="xlink:href">
                                                                <xsl:value-of>.</xsl:value-of>
                                                                <!-- <xsl:choose>
                                                                    <xsl:when test="@thumbnail">
                                                                    <xsl:value-of select="substring(@thumbnail,$lastindexof)"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise> -->
                                                                <xsl:value-of select="substring(@src,$lastindexof)"/>
                                                                <!--    </xsl:otherwise>
                                                                    </xsl:choose> -->
                                                            </xsl:attribute>
                                                        </draw:object>
                                                    </draw:frame>
                                                    <xsl:if test="@legend">
                                                        <xsl:value-of select="@legend"/>
                                                    </xsl:if>
                                                    <xsl:call-template name="elml:BibliographyRef"/>
                                                </text:p>
                                            </draw:text-box>
                                        </draw:frame>
                                    </text:p>
                                </xsl:when>
                                <xsl:when test="parent::elml:box | parent::elml:item">
                                    <!-- case block and within a elml:box -->
                                    <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                        <xsl:attribute name="svg:width">
                                            <xsl:call-template name="elml:Width"/>
                                        </xsl:attribute>
                                        <xsl:choose>
                                            <xsl:when test="@align">
                                                <xsl:attribute name="draw:style-name">
                                                    <xsl:value-of select="concat('frame__', @align, $isBlock)"/>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="draw:style-name">frame__center_block</xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <draw:text-box>
                                            <xsl:if test="@title">
                                                <xsl:call-template name="elml:generate_Title_Heading"/>
                                            </xsl:if>
                                            <text:p>
                                                <xsl:if test="@legend">
                                                    <xsl:attribute name="text:style-name">
                                                        <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                                    </xsl:attribute>
                                                </xsl:if>
                                                <draw:frame text:anchor-type="as-char" draw:z-index="0">
                                                    <xsl:choose>
                                                        <xsl:when test="@align">
                                                            <xsl:attribute name="draw:style-name">
                                                                <xsl:value-of select="concat('mathml_', @align, $isBlock)"/>
                                                            </xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="draw:style-name">mathml_center_inline</xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                    <xsl:attribute name="draw:name">
                                                        <xsl:value-of select="substring-after(substring(@src,$lastindexof),'/')"/>
                                                    </xsl:attribute>
                                                    <xsl:call-template name="elml:Width"/>
                                                    <xsl:call-template name="elml:Height"/>
                                                    <draw:object xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
                                                        <xsl:attribute name="xlink:href">
                                                            <xsl:value-of>.</xsl:value-of>
                                                            <!-- <xsl:choose>
                                                                <xsl:when test="@thumbnail">
                                                                <xsl:value-of select="substring(@thumbnail,$lastindexof)"/>
                                                                </xsl:when>
                                                                <xsl:otherwise> -->
                                                            <xsl:value-of select="substring(@src,$lastindexof)"/>
                                                            <!--    </xsl:otherwise>
                                                                </xsl:choose> -->
                                                        </xsl:attribute>
                                                    </draw:object>
                                                </draw:frame>
                                                <xsl:if test="@legend">
                                                    <xsl:value-of select="@legend"/>
                                                </xsl:if>
                                                <xsl:call-template name="elml:BibliographyRef"/>
                                            </text:p>
                                        </draw:text-box>
                                    </draw:frame>
                                </xsl:when>
                                <!-- case block default -->
                                <xsl:otherwise>
                                    <text:p>
                                        <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                            <xsl:attribute name="svg:width">
                                                <xsl:call-template name="elml:Width"/>
                                            </xsl:attribute>
                                            <xsl:choose>
                                                <xsl:when test="@align">
                                                    <xsl:attribute name="draw:style-name">
                                                        <xsl:value-of select="concat('frame__', @align, $isBlock)"/>
                                                    </xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="draw:style-name">frame__center_block</xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            <draw:text-box>
                                                <xsl:if test="@title">
                                                    <xsl:call-template name="elml:generate_Title_Heading"/>
                                                </xsl:if>
                                                <text:p>
                                                    <xsl:if test="@legend">
                                                        <xsl:attribute name="text:style-name">
                                                            <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                                        </xsl:attribute>
                                                    </xsl:if>
                                                    <draw:frame text:anchor-type="as-char" draw:z-index="0">
                                                        <xsl:choose>
                                                            <xsl:when test="@align">
                                                                <xsl:attribute name="draw:style-name">
                                                                    <xsl:value-of select="concat('mathml_', @align, $isBlock)"/>
                                                                </xsl:attribute>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:attribute name="draw:style-name">mathml_center_inline</xsl:attribute>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:attribute name="draw:name">
                                                            <xsl:value-of select="substring-after(substring(@src,$lastindexof),'/')"/>
                                                        </xsl:attribute>
                                                        <xsl:call-template name="elml:Width"/>
                                                        <xsl:call-template name="elml:Height"/>
                                                        <draw:object xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
                                                            <xsl:attribute name="xlink:href">
                                                                <xsl:value-of>.</xsl:value-of>
                                                                <!-- <xsl:choose>
                                                                    <xsl:when test="@thumbnail">
                                                                    <xsl:value-of select="substring(@thumbnail,$lastindexof)"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise> -->
                                                                <xsl:value-of select="substring(@src,$lastindexof)"/>
                                                                <!--    </xsl:otherwise>
                                                                    </xsl:choose> -->
                                                            </xsl:attribute>
                                                        </draw:object>
                                                    </draw:frame>
                                                    <xsl:if test="@legend">
                                                        <xsl:value-of select="@legend"/>
                                                    </xsl:if>
                                                    <xsl:call-template name="elml:BibliographyRef"/>
                                                </text:p>
                                            </draw:text-box>
                                        </draw:frame>
                                    </text:p>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <!-- case inline -->
                        <xsl:otherwise>
                            <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                <xsl:attribute name="svg:width">
                                    <xsl:call-template name="elml:Width"/>
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="@align">
                                        <xsl:attribute name="draw:style-name">
                                            <xsl:value-of select="concat('frame__', @align, $isBlock)"/>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="draw:style-name">frame__center_inline</xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <draw:text-box>
                                    <xsl:if test="@title">
                                        <xsl:call-template name="elml:generate_Title_Heading"/>
                                    </xsl:if>
                                    <text:p>
                                        <xsl:if test="@legend">
                                            <xsl:attribute name="text:style-name">
                                                <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <draw:frame text:anchor-type="paragraph" draw:z-index="0">
                                            <xsl:choose>
                                                <xsl:when test="@align">
                                                    <xsl:attribute name="draw:style-name">
                                                        <xsl:value-of select="concat('mathml_', @align, $isBlock)"/>
                                                    </xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="draw:style-name">mathml_center_inline</xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            <xsl:attribute name="draw:name">
                                                <xsl:value-of select="substring-after(substring(@src,$lastindexof),'/')"/>
                                            </xsl:attribute>
                                            <xsl:call-template name="elml:Width"/>
                                            <xsl:call-template name="elml:Height"/>
                                            <draw:object xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
                                                <xsl:attribute name="xlink:href">
                                                    <xsl:value-of>.</xsl:value-of>
                                                    <!-- <xsl:choose>
                                                        <xsl:when test="@thumbnail">
                                                        <xsl:value-of select="substring(@thumbnail,$lastindexof)"/>
                                                        </xsl:when>
                                                        <xsl:otherwise> -->
                                                    <xsl:value-of select="substring(@src,$lastindexof)"/>
                                                    <!--    </xsl:otherwise>
                                                        </xsl:choose> -->
                                                </xsl:attribute>
                                            </draw:object>
                                        </draw:frame>
                                        <xsl:if test="@legend">
                                            <xsl:value-of select="@legend"/>
                                        </xsl:if>
                                        <xsl:call-template name="elml:BibliographyRef"/>
                                    </text:p>
                                </draw:text-box>
                            </draw:frame>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <!-- elml:list-->
    <xsl:template match="elml:list">
        <xsl:param name="elmlListStyle">
            <xsl:choose>
                <xsl:when test="@listStyle">
                    <xsl:value-of select="@listStyle"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'unordered'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <!-- case 1 -->
            <xsl:when test="parent::elml:box | parent::elml:item | parent::elml:tabledata | parent::elml:popup | parent::elml:annotation | parent::elml:definition">
                <text:span>
                    <draw:frame text:anchor-type="as-char" style:rel-width="69%" draw:z-index="0">
                        <xsl:attribute name="draw:style-name">
                            <xsl:value-of select="concat('List',$elmlListStyle,'Frame')"/>
                        </xsl:attribute>
                        <draw:text-box fo:min-height="0.499cm">
                            <text:list>
                                <xsl:attribute name="text:style-name">
                                    <xsl:value-of select="concat('List',$elmlListStyle)"/>
                                </xsl:attribute>
                                <xsl:if test="@title">
                                    <text:list-header>
                                        <xsl:call-template name="elml:generate_Title_Heading"/>
                                    </text:list-header>
                                </xsl:if>
                                <xsl:apply-templates>
                                    <xsl:with-param name="elmlListStyle">
                                        <xsl:value-of select="$elmlListStyle"/>
                                    </xsl:with-param>
                                </xsl:apply-templates>
                            </text:list>
                        </draw:text-box>
                    </draw:frame>
                    <xsl:call-template name="elml:BibliographyRef"/>
                </text:span>
            </xsl:when>
            <!-- case 2 -->
            <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                <text:p text:style-name="columnbreak">
                    <text:span>
                        <draw:frame text:anchor-type="as-char" style:rel-width="69%" draw:z-index="0">
                            <xsl:attribute name="draw:style-name">
                                <xsl:value-of select="concat('List',$elmlListStyle,'Frame')"/>
                            </xsl:attribute>
                            <draw:text-box fo:min-height="0.499cm">
                                <text:list>
                                    <xsl:attribute name="text:style-name">
                                        <xsl:value-of select="concat('List',$elmlListStyle)"/>
                                    </xsl:attribute>
                                    <xsl:if test="@title">
                                        <text:list-header>
                                            <xsl:call-template name="elml:generate_Title_Heading"/>
                                        </text:list-header>
                                    </xsl:if>
                                    <xsl:apply-templates>
                                        <xsl:with-param name="elmlListStyle">
                                            <xsl:value-of select="$elmlListStyle"/>
                                        </xsl:with-param>
                                    </xsl:apply-templates>
                                </text:list>
                            </draw:text-box>
                        </draw:frame>
                        <xsl:call-template name="elml:BibliographyRef"/>
                    </text:span>
                </text:p>
            </xsl:when>
            <!-- case 3 -->
            <xsl:when test="((parent::elml:columnRight | parent::elml:columnMiddle) and not(position()=1)) or parent::elml:columnLeft">
                <text:p>
                    <text:span>
                        <draw:frame text:anchor-type="as-char" style:rel-width="69%" draw:z-index="0">
                            <xsl:attribute name="draw:style-name">
                                <xsl:value-of select="concat('List',$elmlListStyle,'Frame')"/>
                            </xsl:attribute>
                            <draw:text-box fo:min-height="0.499cm">
                                <text:list>
                                    <xsl:attribute name="text:style-name">
                                        <xsl:value-of select="concat('List',$elmlListStyle)"/>
                                    </xsl:attribute>
                                    <xsl:if test="@title">
                                        <text:list-header>
                                            <xsl:call-template name="elml:generate_Title_Heading"/>
                                        </text:list-header>
                                    </xsl:if>
                                    <xsl:apply-templates>
                                        <xsl:with-param name="elmlListStyle">
                                            <xsl:value-of select="$elmlListStyle"/>
                                        </xsl:with-param>
                                    </xsl:apply-templates>
                                </text:list>
                            </draw:text-box>
                        </draw:frame>
                    </text:span>
                    <xsl:call-template name="elml:BibliographyRef"/>
                </text:p>
            </xsl:when>
            <!-- default case -->
            <xsl:otherwise>
                <text:list>
                    <xsl:attribute name="text:style-name">
                        <xsl:value-of select="concat('List',$elmlListStyle)"/>
                    </xsl:attribute>
                    <xsl:if test="@title">
                        <text:list-header>
                            <xsl:call-template name="elml:generate_Title_Heading"/>
                        </text:list-header>
                    </xsl:if>
                    <xsl:apply-templates>
                        <xsl:with-param name="elmlListStyle">
                            <xsl:value-of select="$elmlListStyle"/>
                        </xsl:with-param>
                    </xsl:apply-templates>
                </text:list>
                <text:p>
                    <xsl:call-template name="elml:BibliographyRef"/>
                </text:p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- elml:item-->
    <xsl:template match="elml:item">
        <xsl:param name="elmlListStyle"/>
        <text:list-item>
            <text:p>
                <xsl:attribute name="text:style-name">
                    <xsl:value-of select="concat('List',$elmlListStyle,'Paragraph')"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </text:p>
        </text:list-item>
    </xsl:template>
    <!-- elml:popup -->
    <xsl:template match="elml:popup">
        <xsl:choose>
            <xsl:when test="parent::elml:box | parent::elml:tabledata">
                <text:span text:style-name="paragraphPopup">
                    <xsl:apply-templates/>
                </text:span>
            </xsl:when>
            <xsl:otherwise>
                <text:p text:style-name="ParagraphPopup">
                    <xsl:apply-templates/>
                </text:p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- elml:solution -->
    <xsl:template match="elml:solution">
        <text:p>
            <xsl:apply-templates/>
        </text:p>
    </xsl:template>
    <!-- elml:questionn -->
    <xsl:template match="elml:question">
        <text:p>
            <xsl:apply-templates/>
        </text:p>
    </xsl:template>
    <!-- elml:answer -->
    <xsl:template match="elml:answer">
        <text:p>
            <xsl:apply-templates/>
        </text:p>
    </xsl:template>
    <!-- elml:gapText -->
    <xsl:template match="elml:gapText">
        <text:p>
            <xsl:apply-templates/>
        </text:p>
    </xsl:template>
    <!-- elml:table -->
    <xsl:template match="elml:table">
        <xsl:param name="Width_averages">
            <xsl:value-of>
                <xsl:call-template name="Width_average"/>
            </xsl:value-of>
        </xsl:param>
        <xsl:param name="Width_average">
            <xsl:value-of select="substring-before($Width_averages,' ')"/>
        </xsl:param>
        <xsl:param name="Width_average_is_the_empty_string">
            <xsl:choose>
                <xsl:when test="$Width_average = '' ">
                    <xsl:value-of>yes</xsl:value-of>
                </xsl:when>
                <xsl:otherwise>no</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="unit_Width_averages">
            <xsl:value-of>
                <xsl:call-template name="units_Width_average"/>
            </xsl:value-of>
        </xsl:param>
        <xsl:param name="unit_Width_average">
            <xsl:value-of select="substring-before($unit_Width_averages,' ')"/>
        </xsl:param>
        <xsl:param name="unit_Width_average_is_the_empty_string">
            <xsl:choose>
                <xsl:when test="$unit_Width_average = '' ">
                    <xsl:value-of>yes</xsl:value-of>
                </xsl:when>
                <xsl:otherwise>no</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="foo5">
            <xsl:value-of select="count(elml:tablerow[1]/elml:tableheading)"/>
        </xsl:param>
        <xsl:param name="foo6">
            <xsl:value-of select="count(elml:tablerow[1]/elml:tabledata)"/>
        </xsl:param>
        <xsl:param name="fo7">
            <xsl:value-of select="($foo5 + $foo6)"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="parent::elml:box | parent::elml:popup">
                <!-- case 1 -->
                <draw:frame text:anchor-type="as-char" style:rel-width="69%" draw:z-index="0">
                    <draw:text-box>
                        <table:table>
                            <xsl:attribute name="table:style-name">
                                <xsl:value-of>table</xsl:value-of>
                                <xsl:value-of select="string-length()"/>
                            </xsl:attribute>
                            <xsl:attribute name="table:name">
                                <xsl:value-of>table</xsl:value-of>
                                <xsl:value-of select="string-length()"/>
                            </xsl:attribute>
                            <!--xsl:call-template name="elml:Label"/-->
                            <!--xsl:if test="@height">
                <xsl:attribute name="height">
                <xsl:choose>
                <xsl:when test="@units='percent'">
                <xsl:value-of select="@height"/>
                <xsl:text>%</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                <xsl:value-of select="(@height) * $converter_pixel_mm"/>
                <xsl:text>mm</xsl:text>
                </xsl:otherwise>
                </xsl:choose>
                </xsl:attribute>
                </xsl:if-->
                            <!--xsl:choose>
                <xsl:when test="@width">
                <xsl:attribute name="width">
                <xsl:choose>
                <xsl:when test="@units='percent'">
                <xsl:value-of select="@width"/>
                <xsl:text>%</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                <xsl:value-of select="(@width) * $converter_pixel_mm"/>
                <xsl:text>mm</xsl:text>
                </xsl:otherwise>
                </xsl:choose>
                </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                <xsl:attribute name="width">
                <xsl:text>100%</xsl:text>
                </xsl:attribute>
                </xsl:otherwise>
                </xsl:choose-->
                            <xsl:choose>
                                <xsl:when test="elml:tablerow[1]/elml:tableheading and elml:tablerow[1]/elml:tabledata">
                                    <table:table-columns>
                                        <xsl:for-each select="elml:tablerow[1]/child::node()">
                                            <xsl:choose>
                                                <xsl:when test="@colspan">
                                                    <xsl:call-template name="elml:columncreate">
                                                        <xsl:with-param name="columnamount" select="@colspan"/>
                                                        <!--heutealbi-->
                                                        <xsl:with-param name="style">
                                                            <xsl:call-template name="node-identifier"/>
                                                        </xsl:with-param>
                                                    </xsl:call-template>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:call-template name="elml:columncreate">
                                                        <xsl:with-param name="columnamount" select="1"/>
                                                        <!--heutealbi-->
                                                        <xsl:with-param name="style">
                                                            <xsl:call-template name="node-identifier"/>
                                                        </xsl:with-param>
                                                    </xsl:call-template>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                    </table:table-columns>
                                </xsl:when>
                                <xsl:when test="elml:tablerow[1]/elml:tableheading and not(elml:tablerow[1]/elml:tabledata)">
                                    <table:table-columns>
                                        <xsl:for-each select="elml:tablerow[1]/elml:tableheading">
                                            <xsl:choose>
                                                <xsl:when test="@colspan">
                                                    <xsl:call-template name="elml:columncreate">
                                                        <xsl:with-param name="columnamount" select="@colspan"/>
                                                        <!--heutealbi-->
                                                        <xsl:with-param name="style">
                                                            <xsl:call-template name="node-identifier"/>
                                                        </xsl:with-param>
                                                    </xsl:call-template>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:call-template name="elml:columncreate">
                                                        <xsl:with-param name="columnamount" select="1"/>
                                                        <!--heutealbi-->
                                                        <xsl:with-param name="style">
                                                            <xsl:call-template name="node-identifier"/>
                                                        </xsl:with-param>
                                                    </xsl:call-template>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                    </table:table-columns>
                                </xsl:when>
                                <xsl:otherwise>
                                    <table:table-columns>
                                        <xsl:for-each select="elml:tablerow[1]/elml:tabledata">
                                            <xsl:choose>
                                                <xsl:when test="@colspan">
                                                    <xsl:call-template name="elml:columncreate">
                                                        <xsl:with-param name="columnamount" select="@colspan"/>
                                                        <!--heutealbi-->
                                                        <xsl:with-param name="style">
                                                            <xsl:call-template name="node-identifier"/>
                                                        </xsl:with-param>
                                                    </xsl:call-template>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:call-template name="elml:columncreate">
                                                        <xsl:with-param name="columnamount" select="1"/>
                                                        <!--heutealbi-->
                                                        <xsl:with-param name="style">
                                                            <xsl:call-template name="node-identifier"/>
                                                        </xsl:with-param>
                                                    </xsl:call-template>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                    </table:table-columns>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:apply-templates/>
                        </table:table>
                        <!--add the legend or the BibIDRef for table if necessary "/-->
                        <xsl:if test="@legend | @bibIDRef">
                            <text:p text:style-name="Table_Caption">
                                <xsl:value-of select="string(@legend)"/>
                                <xsl:call-template name="elml:BibliographyRef"/>
                            </text:p>
                        </xsl:if>
                    </draw:text-box>
                </draw:frame>
            </xsl:when>
            <xsl:otherwise>
                <!-- default case -->
                <!-- <xsl:value-of select="$Width_average"></xsl:value-of>
                <xsl:value-of select="$unit_Width_average"></xsl:value-of> -->
                <table:table>
                    <xsl:attribute name="table:style-name">
                        <xsl:value-of>table</xsl:value-of>
                        <xsl:value-of select="string-length()"/>
                    </xsl:attribute>
                    <xsl:attribute name="table:name">
                        <xsl:value-of>table</xsl:value-of>
                        <xsl:value-of select="string-length()"/>
                    </xsl:attribute>
                    <!--xsl:call-template name="elml:Label"/-->
                    <!--xsl:if test="@height">
                        <xsl:attribute name="height">
                        <xsl:choose>
                        <xsl:when test="@units='percent'">
                        <xsl:value-of select="@height"/>
                        <xsl:text>%</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                        <xsl:value-of select="(@height) * $converter_pixel_mm"/>
                        <xsl:text>mm</xsl:text>
                        </xsl:otherwise>
                        </xsl:choose>
                        </xsl:attribute>
                        </xsl:if-->
                    <!--xsl:choose>
                        <xsl:when test="@width">
                        <xsl:attribute name="width">
                        <xsl:choose>
                        <xsl:when test="@units='percent'">
                        <xsl:value-of select="@width"/>
                        <xsl:text>%</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                        <xsl:value-of select="(@width) * $converter_pixel_mm"/>
                        <xsl:text>mm</xsl:text>
                        </xsl:otherwise>
                        </xsl:choose>
                        </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                        <xsl:attribute name="width">
                        <xsl:text>100%</xsl:text>
                        </xsl:attribute>
                        </xsl:otherwise>
                        </xsl:choose-->
                    <xsl:choose>
                        <xsl:when test="elml:tablerow[1]/elml:tableheading and elml:tablerow[1]/elml:tabledata">
                            <table:table-columns>
                                <xsl:for-each select="elml:tablerow[1]/child::node()">
                                    <xsl:choose>
                                        <xsl:when test="@colspan">
                                            <xsl:call-template name="elml:columncreate">
                                                <xsl:with-param name="columnamount" select="@colspan"/>
                                                <!--heutealbi-->
                                                <xsl:with-param name="style">
                                                    <xsl:call-template name="node-identifier"/>
                                                </xsl:with-param>
                                            </xsl:call-template>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:call-template name="elml:columncreate">
                                                <xsl:with-param name="columnamount" select="1"/>
                                                <!--heutealbi-->
                                                <xsl:with-param name="style">
                                                    <xsl:call-template name="node-identifier"/>
                                                </xsl:with-param>
                                            </xsl:call-template>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each>
                            </table:table-columns>
                        </xsl:when>
                        <xsl:when test="elml:tablerow[1]/elml:tableheading and not(elml:tablerow[1]/elml:tabledata)">
                            <table:table-columns>
                                <xsl:for-each select="elml:tablerow[1]/elml:tableheading">
                                    <xsl:choose>
                                        <xsl:when test="@colspan">
                                            <xsl:call-template name="elml:columncreate">
                                                <xsl:with-param name="columnamount" select="@colspan"/>
                                                <!--heutealbi-->
                                                <xsl:with-param name="style">
                                                    <xsl:call-template name="node-identifier"/>
                                                </xsl:with-param>
                                            </xsl:call-template>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:call-template name="elml:columncreate">
                                                <xsl:with-param name="columnamount" select="1"/>
                                                <!--heutealbi-->
                                                <xsl:with-param name="style">
                                                    <xsl:call-template name="node-identifier"/>
                                                </xsl:with-param>
                                            </xsl:call-template>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each>
                            </table:table-columns>
                        </xsl:when>
                        <xsl:otherwise>
                            <table:table-columns>
                                <xsl:for-each select="elml:tablerow[1]/elml:tabledata">
                                    <xsl:choose>
                                        <xsl:when test="@colspan">
                                            <xsl:call-template name="elml:columncreate">
                                                <xsl:with-param name="columnamount" select="@colspan"/>
                                                <!--heutealbi-->
                                                <xsl:with-param name="style">
                                                    <xsl:call-template name="node-identifier"/>
                                                </xsl:with-param>
                                            </xsl:call-template>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:call-template name="elml:columncreate">
                                                <xsl:with-param name="columnamount" select="1"/>
                                                <!--heutealbi-->
                                                <xsl:with-param name="style">
                                                    <xsl:call-template name="node-identifier"/>
                                                </xsl:with-param>
                                            </xsl:call-template>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each>
                            </table:table-columns>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates>
                        <xsl:with-param name="unit_Width_average" select="$unit_Width_average"/>
                        <xsl:with-param name="Width_average" select="$Width_average"/>
                    </xsl:apply-templates>
                </table:table>
                <!--add the legend or the BibIDRef for table if necessary "/-->
                <xsl:if test="@legend | @bibIDRef">
                    <text:p text:style-name="Table_Caption">
                        <xsl:value-of select="string(@legend)"/>
                        <xsl:call-template name="elml:BibliographyRef"/>
                    </text:p>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:tablerow">
        <xsl:param name="unit_Width_average"/>
        <xsl:param name="Width_average"/>
        <xsl:choose>
            <xsl:when test="elml:tableheading">
                <!-- <xsl:value-of select="$Width_average"></xsl:value-of>
                   <xsl:value-of select="$unit_Width_average"></xsl:value-of> -->
                <table:table-row>
                    <!--xsl:choose>
                        <xsl:when test="elml:tableheading[1]/@height">
                        <xsl:attribute name="height">
                        <xsl:choose>
                        <xsl:when test="elml:tableheading[1]/@units='percent'">
                        <xsl:value-of select="elml:tableheading[1]/@height"/>
                        <xsl:text>%</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                        <xsl:value-of select="(elml:tableheading[1]/@height) * $converter_pixel_mm"/>
                        <xsl:text>mm</xsl:text>
                        </xsl:otherwise>
                        </xsl:choose>
                        </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="elml:tabledata[1]/@height">
                        <xsl:attribute name="height">
                        <xsl:choose>
                        <xsl:when test="elml:tabledata[1]/@units='percent'">
                        <xsl:value-of select="elml:tabledata[1]/@height"/>
                        <xsl:text>%</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                        <xsl:value-of select="(elml:tabledata[1]/@height) * $converter_pixel_mm"/>
                        <xsl:text>mm</xsl:text>
                        </xsl:otherwise>
                        </xsl:choose>
                        </xsl:attribute>
                        </xsl:when>
                        </xsl:choose-->
                    <xsl:apply-templates/>
                </table:table-row>
            </xsl:when>
            <xsl:otherwise>
                <!-- <xsl:value-of select="$Width_average"></xsl:value-of>
                    <xsl:value-of select="$unit_Width_average"></xsl:value-of> -->
                <table:table-row>
                    <!--xsl:choose>
                        <xsl:when test="elml:tableheading[1]/@height">
                        <xsl:attribute name="height">
                        <xsl:choose>
                        <xsl:when test="elml:tableheading[1]/@units='percent'">
                        <xsl:value-of select="elml:tableheading[1]/@height"/>
                        <xsl:text>%</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                        <xsl:value-of select="(elml:tableheading[1]/@height) * $converter_pixel_mm"/>
                        <xsl:text>mm</xsl:text>
                        </xsl:otherwise>
                        </xsl:choose>
                        </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="elml:tabledata[1]/@height">
                        <xsl:attribute name="height">
                        <xsl:choose>
                        <xsl:when test="elml:tabledata[1]/@units='percent'">
                        <xsl:value-of select="elml:tabledata[1]/@height"/>
                        <xsl:text>%</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                        <xsl:value-of select="(elml:tabledata[1]/@height) * $converter_pixel_mm"/>
                        <xsl:text>mm</xsl:text>
                        </xsl:otherwise>
                        </xsl:choose>
                        </xsl:attribute>
                        </xsl:when>
                        </xsl:choose-->
                    <xsl:apply-templates/>
                </table:table-row>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:tableheading">
        <table:table-cell>
            <xsl:if test="@colspan">
                <xsl:attribute name="table:number-columns-spanned">
                    <xsl:value-of select="@colspan"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@rowspan">
                <xsl:attribute name="number-rows-spanned">
                    <xsl:value-of select="@rowspan"/>
                </xsl:attribute>
            </xsl:if>
            <!--xsl:call-template name="elml:WidthHeight"/>
                <xsl:call-template name="elml:Alignment"/>
                <fo:block>
                <xsl:call-template name="elml:Alignment"/>
                <xsl:apply-templates/>
                </fo:block-->
            <text:p text:style-name="bold">
                <xsl:apply-templates/>
            </text:p>
        </table:table-cell>
    </xsl:template>
    <xsl:template match="elml:tabledata">
        <table:table-cell>
            <xsl:call-template name="valign_for_tabledata">
                <xsl:with-param name="valign">
                    <xsl:value-of select="@valign"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:if test="@colspan">
                <xsl:attribute name="table:number-columns-spanned">
                    <xsl:value-of select="@colspan"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@rowspan">
                <xsl:attribute name="table:number-rows-spanned">
                    <xsl:value-of select="@rowspan"/>
                </xsl:attribute>
            </xsl:if>
            <!--xsl:call-template name="elml:WidthHeight"/>
                <xsl:call-template name="elml:Alignment"/>
                <fo:block>
                <xsl:call-template name="elml:Alignment"/>
                <xsl:apply-templates/>
                </fo:block-->
            <xsl:choose>
                <xsl:when test="not(@align)">
                    <text:p>
                        <xsl:call-template name="align_for_table"/>
                    </text:p>
                </xsl:when>
                <xsl:otherwise>
                    <text:p>
                        <xsl:call-template name="align_for_table"/>
                    </text:p>
                </xsl:otherwise>
            </xsl:choose>
        </table:table-cell>
    </xsl:template>
    <!--link -->
    <xsl:template match="elml:link">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:param name="inline">
            <xsl:choose>
                <xsl:when test="not(parent::elml:paragraph | parent::elml:box | parent::elml:popup | parent::elml:item | parent::elml:tabledata | parent::elml:annotation | parent::elml:definition)">
                    <xsl:text>_block</xsl:text>
                </xsl:when>
                <xsl:otherwise>_inline</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
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
                        <xsl:otherwise>
                            <!-- Interner Link folgt hier: -->
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:text>_</xsl:text>
                            <xsl:value-of select="@targetLabel"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:choose>
                <!-- case: has a multimedia child and block-->
                <xsl:when test="child::elml:multimedia and $inline='_block'">
                    <text:p>
                        <xsl:if test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                            <xsl:attribute name="text:style-name">columnbreak</xsl:attribute>
                        </xsl:if>
                        <draw:a xlink:type="simple">
                            <xsl:attribute name="xlink:href">
                                <xsl:choose>
                                    <!--extern Link and block layout-->
                                    <xsl:when test="starts-with($TempURL, 'mailto:') or starts-with($TempURL, 'http')">
                                        <xsl:attribute name="xlink:href">
                                            <xsl:value-of select="$TempURL"/>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <!--intern Link and block layout-->
                                    <xsl:otherwise>
                                        <xsl:attribute name="xlink:href">
                                            <xsl:value-of>#</xsl:value-of>
                                            <xsl:value-of select="$TempURL"/>
                                        </xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </draw:a>
                    </text:p>
                </xsl:when>
                <!-- case: has a multimedia child and inline-->
                <xsl:when test="child::elml:multimedia and $inline='_inline'">
                    <draw:a xlink:type="simple">
                        <xsl:attribute name="xlink:href">
                            <xsl:choose>
                                <!--extern Link and Inline layout-->
                                <xsl:when test="starts-with($TempURL, 'mailto:') or starts-with($TempURL, 'http')">
                                    <xsl:attribute name="xlink:href">
                                        <xsl:value-of select="$TempURL"/>
                                    </xsl:attribute>
                                </xsl:when>
                                <!--intern Link and Inline layout-->
                                <xsl:otherwise>
                                    <xsl:value-of>#</xsl:value-of>
                                    <xsl:value-of select="$TempURL"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </draw:a>
                </xsl:when>
                <xsl:when test="parent::elml:paragraph | parent::elml:box | parent::elml:popup | parent::elml:item | parent::elml:tabledata | parent::elml:definition | parent::elml:annotation">
                    <xsl:choose>
                        <!-- case: extern Link and Inline layout-->
                        <xsl:when test="$inline='_inline' and (starts-with($TempURL, 'mailto:') or starts-with($TempURL, 'http'))">
                            <text:a xlink:type="simple">
                                <xsl:attribute name="xlink:href">
                                    <xsl:value-of select="$TempURL"/>
                                </xsl:attribute>
                                <xsl:apply-templates/>
                            </text:a>
                            <xsl:if test="@legend">
                                <text:span>
                                    <xsl:if test="@size and @type">
                                        <xsl:text> [</xsl:text>
                                        <xsl:value-of select="@size"/>
                                        <xsl:text> - </xsl:text>
                                        <xsl:value-of select="@legend"/>
                                        <xsl:text> - </xsl:text>
                                        <xsl:value-of select="@type"/>
                                        <xsl:text>] </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="@size and not(@type)">
                                        <xsl:text> [</xsl:text>
                                        <xsl:value-of select="@size"/>
                                        <xsl:text> - </xsl:text>
                                        <xsl:value-of select="@legend"/>
                                        <xsl:text>] </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="not(@size) and @type">
                                        <xsl:text> [</xsl:text>
                                        <xsl:value-of select="@legend"/>
                                        <xsl:text> - </xsl:text>
                                        <xsl:value-of select="@type"/>
                                        <xsl:text>] </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="not(@size) and not(@type)">
                                        <xsl:text> [</xsl:text>
                                        <xsl:value-of select="@legend"/>
                                        <xsl:text>] </xsl:text>
                                    </xsl:if>
                                </text:span>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <!-- case: intern Link and Inline layout-->
                            <text:a xlink:type="simple">
                                <xsl:attribute name="xlink:href">
                                    <xsl:value-of>#</xsl:value-of>
                                    <xsl:value-of select="$TempURL"/>
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="@target='_blank'">
                                        <xsl:attribute name="xlink:show">
                                            <xsl:text>new</xsl:text>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xlink:show">
                                            <xsl:text>replace</xsl:text>
                                        </xsl:attribute>
                                        <xsl:apply-templates/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </text:a>
                            <xsl:if test="@legend">
                                <text:span>
                                    <xsl:if test="@size and @type">
                                        <xsl:text> [</xsl:text>
                                        <xsl:value-of select="@size"/>
                                        <xsl:text> - </xsl:text>
                                        <xsl:value-of select="@legend"/>
                                        <xsl:text> - </xsl:text>
                                        <xsl:value-of select="@type"/>
                                        <xsl:text>] </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="@size and not(@type)">
                                        <xsl:text> [</xsl:text>
                                        <xsl:value-of select="@size"/>
                                        <xsl:text> - </xsl:text>
                                        <xsl:value-of select="@legend"/>
                                        <xsl:text>] </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="not(@size) and @type">
                                        <xsl:text> [</xsl:text>
                                        <xsl:value-of select="@legend"/>
                                        <xsl:text> - </xsl:text>
                                        <xsl:value-of select="@type"/>
                                        <xsl:text>] </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="not(@size) and not(@type)">
                                        <xsl:text> [</xsl:text>
                                        <xsl:value-of select="@legend"/>
                                        <xsl:text>] </xsl:text>
                                    </xsl:if>
                                </text:span>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="not(parent::elml:paragraph | parent::elml:box | parent::elml:popup | parent::elml:item | parent::elml:tabledata | parent::elml:definition | parent::elml:annotation) and (starts-with($TempURL, 'mailto:') or starts-with($TempURL, 'http'))">
                    <!-- case: extern Link and Block layout-->
                    <text:p>
                        <xsl:if test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                            <xsl:attribute name="text:style-name">columnbreak</xsl:attribute>
                        </xsl:if>
                        <text:a xlink:type="simple">
                            <xsl:attribute name="xlink:href">
                                <xsl:value-of select="$TempURL"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </text:a>
                        <xsl:if test="@legend">
                            <text:span>
                                <xsl:if test="@size and @type">
                                    <xsl:text> [</xsl:text>
                                    <xsl:value-of select="@size"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:value-of select="@legend"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:value-of select="@type"/>
                                    <xsl:text>] </xsl:text>
                                </xsl:if>
                                <xsl:if test="@size and not(@type)">
                                    <xsl:text> [</xsl:text>
                                    <xsl:value-of select="@size"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:value-of select="@legend"/>
                                    <xsl:text>] </xsl:text>
                                </xsl:if>
                                <xsl:if test="not(@size) and @type">
                                    <xsl:text> [</xsl:text>
                                    <xsl:value-of select="@legend"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:value-of select="@type"/>
                                    <xsl:text>] </xsl:text>
                                </xsl:if>
                                <xsl:if test="not(@size) and not(@type)">
                                    <xsl:text> [</xsl:text>
                                    <xsl:value-of select="@legend"/>
                                    <xsl:text>] </xsl:text>
                                </xsl:if>
                            </text:span>
                        </xsl:if>
                    </text:p>
                </xsl:when>
                <xsl:otherwise>
                    <!-- case4: intern Link and Block layout-->
                    <text:p>
                        <xsl:if test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                            <xsl:attribute name="text:style-name">columnbreak</xsl:attribute>
                        </xsl:if>
                        <text:a xlink:type="simple">
                            <xsl:attribute name="xlink:href">
                                <xsl:value-of>#</xsl:value-of>
                                <xsl:value-of select="$TempURL"/>
                            </xsl:attribute>
                            <xsl:choose>
                                <xsl:when test="@target='_blank'">
                                    <xsl:attribute name="xlink:show">
                                        <xsl:text>new</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="xlink:show">
                                        <xsl:text>replace</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </text:a>
                        <xsl:if test="@legend">
                            <text:span>
                                <xsl:if test="@size and @type">
                                    <xsl:text> [</xsl:text>
                                    <xsl:value-of select="@size"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:value-of select="@legend"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:value-of select="@type"/>
                                    <xsl:text>] </xsl:text>
                                </xsl:if>
                                <xsl:if test="@size and not(@type)">
                                    <xsl:text> [</xsl:text>
                                    <xsl:value-of select="@size"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:value-of select="@legend"/>
                                    <xsl:text>] </xsl:text>
                                </xsl:if>
                                <xsl:if test="not(@size) and @type">
                                    <xsl:text> [</xsl:text>
                                    <xsl:value-of select="@legend"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:value-of select="@type"/>
                                    <xsl:text>] </xsl:text>
                                </xsl:if>
                                <xsl:if test="not(@size) and not(@type)">
                                    <xsl:text> [</xsl:text>
                                    <xsl:value-of select="@legend"/>
                                    <xsl:text>] </xsl:text>
                                </xsl:if>
                            </text:span>
                        </xsl:if>
                    </text:p>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <!-- elml:annotation element if you dont want to use the default style for the representation of elml:annotation in odf-->
    <!-- <xsl:template match="elml:annotationDOESNOTWORK">
        <xsl:choose>
            <xsl:when test="parent::elml:paragraph | parent::elml:box | parent::elml:popup">
                <text:line-break/>
                <text:span text:style-name="standard1">
                    <text:note text:note-class="footnote">
                        <text:note-citation text:label="*">*</text:note-citation>
                        <text:note-body>
                            <text:p>
                                <xsl:apply-templates/>
                            </text:p>
                        </text:note-body>
                    </text:note>
                </text:span>
            </xsl:when>
            <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                <text:p text:style-name="columnbreak">
                    <text:note text:note-class="footnote">
                        <text:note-citation text:label="*">*</text:note-citation>
                        <text:note-body>
                            <text:p>
                                <xsl:apply-templates/>
                            </text:p>
                        </text:note-body>
                    </text:note>
                </text:p>
            </xsl:when> 
            <xsl:otherwise>
                <text:p text:style-name="Standard1">
                    <text:note text:note-class="footnote">
                        <text:note-citation text:label="*">*</text:note-citation>
                        <text:note-body>
                            <text:p>
                                <xsl:apply-templates/>
                            </text:p>
                        </text:note-body>
                    </text:note>
                </text:p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template> -->
    <!-- elml:citation -->
    <xsl:template match="elml:citation">
        <xsl:param name="hasIcon">
            <xsl:choose>
                <xsl:when test="@icon">true</xsl:when>
                <xsl:otherwise>false</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="inline">
            <xsl:choose>
                <xsl:when test="not(parent::elml:paragraph | parent::elml:box | parent::elml:popup | parent::elml:item | parent::elml:tabledata | parent::elml:annotation | parent::elml:definition | parent::elml:term)">
                    <xsl:text>_block</xsl:text>
                </xsl:when>
                <xsl:otherwise>_inline</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="bibIDRef">
            <xsl:value-of select="@bibIDRef"/>
        </xsl:param>
        <xsl:choose>
            <!--case block and icon-->
            <xsl:when test="$inline = '_block' and $hasIcon = 'true'">
                <!--case block and icon and columnbreak-->
                <xsl:choose>
                    <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                        <text:p text:style-name="columnbreak">
                            <draw:frame draw:name="graphics1" text:anchor-type="paragraph">
                                <xsl:attribute name="svg:width">6mm</xsl:attribute>
                                <xsl:attribute name="svg:height">6mm</xsl:attribute>
                                <xsl:attribute name="draw:style-name">singleimage_left_inline</xsl:attribute>
                                <xsl:call-template name="elml:Width"/>
                                <xsl:call-template name="elml:Height"/>
                                <draw:image xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
                                    <xsl:attribute name="xlink:href">
                                        <xsl:value-of>Pictures/</xsl:value-of>
                                        <xsl:value-of select="@icon"/>
                                        <xsl:value-of>.</xsl:value-of>
                                        <xsl:value-of select="$icon_filetype"/>
                                    </xsl:attribute>
                                </draw:image>
                            </draw:frame>
                            <!-- hier zitiertet Text -->
                            <text:span text:style-name="italic"> PROBLEM1 <xsl:apply-templates/>
                            </text:span>
                            <xsl:call-template name="elml:BibliographyRef"> </xsl:call-template>
                        </text:p>
                    </xsl:when>
                    <xsl:otherwise>
                        <!--case block and icon and no columnbreak-->
                        <text:p text:style-name="Standard1">
                            <draw:frame draw:name="graphics1" text:anchor-type="paragraph">
                                <xsl:attribute name="svg:width">6mm</xsl:attribute>
                                <xsl:attribute name="svg:height">6mm</xsl:attribute>
                                <xsl:attribute name="draw:style-name">singleimage_left_inline</xsl:attribute>
                                <xsl:call-template name="elml:Width"/>
                                <xsl:call-template name="elml:Height"/>
                                <draw:image xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
                                    <xsl:attribute name="xlink:href">
                                        <xsl:value-of>Pictures/</xsl:value-of>
                                        <xsl:value-of select="@icon"/>
                                        <xsl:value-of>.</xsl:value-of>
                                        <xsl:value-of select="$icon_filetype"/>
                                    </xsl:attribute>
                                </draw:image>
                            </draw:frame>
                            <!-- hier zitiertet Text -->
                            <text:span text:style-name="italic"> PROBLEM2 <xsl:apply-templates/>
                            </text:span>
                            <xsl:call-template name="elml:BibliographyRef"> </xsl:call-template>
                        </text:p>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <!--case block and no icon-->
            <xsl:when test="$inline = '_block' and $hasIcon = 'false'">
                <text:p text:style-name="Standard1">
                    <!-- hier zitiertet Text -->
                    <text:span text:style-name="italic"> PROBLEM3 <xsl:apply-templates/>
                    </text:span>
                    <xsl:call-template name="elml:BibliographyRef"> </xsl:call-template>
                </text:p>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <!--case columnbreak-->
                    <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                        <text:p>
                            <!-- hier zitiertet Text -->
                            <text:span text:style-name="italic"> PROBLEM4 <xsl:apply-templates/>
                            </text:span>
                            <!-- hier der Link -->
                            <xsl:call-template name="elml:BibliographyRef"/>
                        </text:p>
                    </xsl:when>
                    <xsl:otherwise>
                        <!--case default-->
                        <text:span text:style-name="italic">
                            <xsl:apply-templates/>
                        </text:span>
                        <!-- hier der Link -->
                        <xsl:call-template name="elml:BibliographyRef"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--xsl:template match="elml:citation">
        <xsl:choose>
            <xsl:when test="not(node())">
                <text:note text:note-class="endnote">
                <xsl:call-template name="elml:BibliographyRef"/>
                    </text:note>
            </xsl:when>
            <xsl:when test="((boolean(name(preceding-sibling::node()[1])) or boolean(name(following-sibling::node()[1]))) and not(../text())) or (count(../*)=number('1') and     (name(parent::node())='look' or name(parent::node())='act' or name(parent::node())='clarify'))">
                <text:p>
                    <text:note text:note-class="endnote">
                        <text:note-body>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:choose>
                        <xsl:when test="@yearOnly='yes'">
                            <xsl:call-template name="elml:BibliographyRef"/>
                            <xsl:text> "</xsl:text>
                            <text:span style-name="italic">
                                <xsl:apply-templates mode="#default"/>
                            </text:span>
                            <xsl:text>"</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>"</xsl:text>
                            <text:span style-name="italic">
                                <xsl:apply-templates mode="#default"/>
                            </text:span>
                            <xsl:text>"</xsl:text>
                            <xsl:call-template name="elml:BibliographyRef"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    </text:note-body>
                        </text:note>
                </text:p>
            </xsl:when>
            <xsl:otherwise>
                <text:note text:note-class="endnote">
            <text:note-ciation>
                <xsl:attribute name="text:label"></xsl:attribute>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:choose>
                        <xsl:when test="@yearOnly='yes'">
                            <xsl:call-template name="elml:BibliographyRef"/>
                            <xsl:text> "</xsl:text>
                            <text:span style-name="italic">
                                <xsl:apply-templates mode="#default"/>
                            </text:span>
                            <xsl:text>"</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>"</xsl:text>
                            <text:span style-name="italic">
                                <xsl:apply-templates mode="#default"/>
                            </text:span>
                            <xsl:text>"</xsl:text>
                            <xsl:call-template name="elml:BibliographyRef"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </text:note-ciation>
                    </text:note>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template-->
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
            <xsl:choose>
                <xsl:when test="contains($author, ',')">
                    <text:a xlink:type="simple">
                        <xsl:attribute name="xlink:href">
                            <xsl:value-of>#</xsl:value-of>
                            <xsl:value-of select="@bibIDRef"/>
                        </xsl:attribute>
                        <xsl:value-of select="substring-before($author, ',')"/>
                        <xsl:if test="contains(substring-after($author, ','), ',')">
                            <xsl:text> et al.</xsl:text>
                        </xsl:if>
                    </text:a>
                </xsl:when>
                <xsl:otherwise>
                    <text:a xlink:type="simple">
                        <xsl:attribute name="xlink:href">
                            <xsl:value-of>#</xsl:value-of>
                            <xsl:value-of select="@bibIDRef"/>
                        </xsl:attribute>
                        <xsl:value-of select="$author"/>
                    </text:a>
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
    <xsl:template match="elml:annotation"/>
    <xsl:template match="elml:term">
        <xsl:param name="hasIcon">
            <xsl:choose>
                <xsl:when test="@icon">true</xsl:when>
                <xsl:otherwise>false</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="TempURL">
            <xsl:value-of select="/elml:lesson/@label"/>
            <xsl:text>_</xsl:text>
            <xsl:value-of select="@glossRef"/>
        </xsl:param>
        <xsl:param name="inline">
            <xsl:choose>
                <xsl:when test="not(parent::elml:paragraph | parent::elml:box | parent::elml:popup | parent::elml:item | parent::elml:tabledata | parent::elml:annotation | parent::elml:definition | parent::elml:citation)">
                    <xsl:text>_block</xsl:text>
                </xsl:when>
                <xsl:otherwise>_inline</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="glossRef">
            <xsl:value-of select="@glossRef"/>
        </xsl:param>
        <xsl:choose>
            <!--case block and icon-->
            <xsl:when test="$inline = '_block' and $hasIcon = 'true'">
                <!--case block and icon and columnbreak-->
                <xsl:choose>
                    <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                        <text:p text:style-name="columnbreak">
                            <draw:frame draw:name="graphics1" text:anchor-type="paragraph">
                                <xsl:attribute name="svg:width">6mm</xsl:attribute>
                                <xsl:attribute name="svg:height">6mm</xsl:attribute>
                                <xsl:attribute name="draw:style-name">singleimage_left_inline</xsl:attribute>
                                <xsl:call-template name="elml:Width"/>
                                <xsl:call-template name="elml:Height"/>
                                <draw:image xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
                                    <xsl:attribute name="xlink:href">
                                        <xsl:value-of>Pictures/</xsl:value-of>
                                        <xsl:value-of select="@icon"/>
                                        <xsl:value-of>.</xsl:value-of>
                                        <xsl:value-of select="$icon_filetype"/>
                                    </xsl:attribute>
                                </draw:image>
                            </draw:frame>
                            <text:a xlink:type="simple">
                                <xsl:attribute name="xlink:href">
                                    <xsl:value-of>#</xsl:value-of>
                                    <xsl:value-of select="$TempURL"/>
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="@glossRef">
                                        <xsl:value-of select="@glossRef"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:apply-templates/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </text:a>
                            <xsl:for-each select="/elml:lesson/elml:glossary/elml:definition">
                                <xsl:if test="@term = $glossRef">
                                    <!-- <text:p><xsl:value-of select="@term"/></text:p> -->
                                    <text:line-break/>
                                    <text:span>
                                        <xsl:apply-templates/>
                                        <text:line-break/>
                                    </text:span>
                                </xsl:if>
                            </xsl:for-each>
                        </text:p>
                    </xsl:when>
                    <xsl:otherwise>
                        <!--case block and icon and no columnbreak-->
                        <text:p text:style-name="Standard1">
                            <draw:frame draw:name="graphics1" text:anchor-type="paragraph">
                                <xsl:attribute name="svg:width">6mm</xsl:attribute>
                                <xsl:attribute name="svg:height">6mm</xsl:attribute>
                                <xsl:attribute name="draw:style-name">singleimage_left_inline</xsl:attribute>
                                <xsl:call-template name="elml:Width"/>
                                <xsl:call-template name="elml:Height"/>
                                <draw:image xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
                                    <xsl:attribute name="xlink:href">
                                        <xsl:value-of>Pictures/</xsl:value-of>
                                        <xsl:value-of select="@icon"/>
                                        <xsl:value-of>.</xsl:value-of>
                                        <xsl:value-of select="$icon_filetype"/>
                                    </xsl:attribute>
                                </draw:image>
                            </draw:frame>
                            <text:a xlink:type="simple">
                                <xsl:attribute name="xlink:href">
                                    <xsl:value-of>#</xsl:value-of>
                                    <xsl:value-of select="$TempURL"/>
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="@glossRef">
                                        <xsl:value-of select="@glossRef"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:apply-templates/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </text:a>
                            <xsl:for-each select="/elml:lesson/elml:glossary/elml:definition">
                                <xsl:if test="@term = $glossRef">
                                    <!-- <text:p><xsl:value-of select="@term"/></text:p> -->
                                    <text:line-break/>
                                    <text:span>
                                        <xsl:apply-templates/>
                                        <text:line-break/>
                                    </text:span>
                                </xsl:if>
                            </xsl:for-each>
                        </text:p>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <!--case block and no icon-->
            <xsl:when test="$inline = '_block' and $hasIcon = 'false'">
                <text:p text:style-name="Standard1">
                    <text:a xlink:type="simple">
                        <xsl:attribute name="xlink:href">
                            <xsl:value-of>#</xsl:value-of>
                            <xsl:value-of select="$TempURL"/>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="@glossRef">
                                <xsl:value-of select="@glossRef"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </text:a>
                    <xsl:for-each select="/elml:lesson/elml:glossary/elml:definition">
                        <xsl:if test="@term = $glossRef">
                            <!-- <text:p><xsl:value-of select="@term"/></text:p> -->
                            <text:line-break/>
                            <text:span>
                                <xsl:apply-templates/>
                                <text:line-break/>
                            </text:span>
                        </xsl:if>
                    </xsl:for-each>
                </text:p>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <!--case columnbreak-->
                    <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                        <text:p>
                            <text:a xlink:type="simple">
                                <xsl:attribute name="xlink:href">
                                    <xsl:value-of>#</xsl:value-of>
                                    <xsl:value-of select="$TempURL"/>
                                </xsl:attribute>
                                <xsl:apply-templates/>
                            </text:a>
                        </text:p>
                    </xsl:when>
                    <xsl:otherwise>
                        <!--case default-->
                        <text:a xlink:type="simple">
                            <xsl:attribute name="xlink:href">
                                <xsl:value-of>#</xsl:value-of>
                                <xsl:value-of select="$TempURL"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </text:a>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- indexItem -->
    <xsl:template match="elml:indexItem">
        <xsl:choose>
            <xsl:when test="not(parent::elml:paragraph | parent::elml:box | parent::elml:popup | parent::elml:item | parent::elml:tabledata | parent::elml:annotation | parent::elml:definition | parent::elml:citation)">
                <text:p text:style-name="Standard1">
                    <xsl:element name="text:user-index-mark">
                        <xsl:attribute name="text:string-value">
                            <xsl:value-of select="text()"/>
                        </xsl:attribute>
                        <xsl:attribute name="text:index-name">
                            <xsl:choose>
                                <xsl:when test="@affiliatedTo">
                                    <xsl:value-of select="@affiliatedTo"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="text()"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:attribute name="text:outline-level">1</xsl:attribute>
                    </xsl:element>
                    <xsl:apply-templates/>
                </text:p>
            </xsl:when>
            <xsl:when test="(parent::elml:columnRight | parent::elml:columnMiddle) and position()=1">
                <text:p text:style-name="columnbreak">
                    <xsl:element name="text:user-index-mark">
                        <xsl:attribute name="text:string-value">
                            <xsl:value-of select="text()"/>
                        </xsl:attribute>
                        <xsl:attribute name="text:index-name">
                            <xsl:choose>
                                <xsl:when test="@affiliatedTo">
                                    <xsl:value-of select="@affiliatedTo"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="text()"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:attribute name="text:outline-level">1</xsl:attribute>
                    </xsl:element>
                    <xsl:apply-templates/>
                </text:p>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="text:user-index-mark">
                    <xsl:attribute name="text:index-name">
                        <xsl:value-of select="User-Defined"/>
                    </xsl:attribute>
                    <xsl:attribute name="text:string-value">
                        <xsl:choose>
                            <xsl:when test="@affiliatedTo">
                                <xsl:value-of select="@affiliatedTo"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="text()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:attribute name="text:outline-level">1</xsl:attribute>
                </xsl:element>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:definition"/>
    <xsl:template match="elml:matadata"/>
    <!-- ******** STYLE (ONLY INLINE) ELEMENTS ******** -->
    <!-- elml:formatted -->
    <xsl:template match="elml:formatted">
        <xsl:choose>
            <xsl:when test="parent::elml:columnMiddle | parent::elml:columnLeft | parent::elml:columnRight"> </xsl:when>
            <xsl:otherwise>
                <xsl:element name="text:span">
                    <xsl:choose>
                        <xsl:when test="not(@style)">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="text:style-name">
                                <xsl:value-of select="@style"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- elml:newLine -->
    <xsl:template match="elml:newLine">
        <xsl:param name="isBlock">
            <xsl:choose>
                <xsl:when test="parent::elml:tabledata | parent::elml:popup | parent::elml:box | parent::elml:paragraph | parent::elml:item | parent::elml:annotation | parent::elml:definition | parent::elml:term | parent::elml:solution | parent::elml:question| parent::elml:answer | parent::elml:gapText  | parent::elml:citation">
                    <xsl:text>_inline</xsl:text>
                </xsl:when>
                <xsl:otherwise>_block</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$isBlock='_inline'">
                <xsl:element name="text:line-break"/>
            </xsl:when>
            <xsl:otherwise>
                <text:p>
                    <xsl:element name="text:line-break"/>
                </text:p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- ******* NAME TEMPLATES ***** -->
    <!-- The created documents in project/lesson/lang/odf-->
    <xsl:template name="directory_mathml_objects">
        <!-- <xsl:param name="StringContainingFileNames">
            <xsl:for-each select="//multimedia[@type='mathml']">
                <xsl:if test="@src">
                <xsl:value-of select="substring-before(substring-after(@src,'/'),'.')"/>
                    <xsl:value-of >,</xsl:value-of>
                </xsl:if>
                </xsl:for-each>
        </xsl:param> -->
        <xsl:for-each select="//elml:multimedia[@type='mathml']">
            <xsl:if test="@src">
                <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}Objects/{substring-after(@src,'/')}/default.txt" format="odfxml">
                    <xsl:text>default</xsl:text>
                </xsl:result-document>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="directory_pictures">
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}Pictures/default.txt" format="odfxml">
            <xsl:text>default</xsl:text>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="directory_configurations">
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}Configurations2/default" format="odfxml">
            <xsl:text>application/vnd.sun.xml.ui.configuration</xsl:text>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="document_manifest">
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}META-INF/manifest.xml" format="odfxml">
            <manifest:manifest xmlns:manifest="urn:oasis:names:tc:opendocument:xmlns:manifest:1.0">
                <manifest:file-entry manifest:media-type="application/vnd.oasis.opendocument.text" manifest:full-path="/"/>
                <!--manifest:file-entry manifest:media-type="" manifest:full-path="Configurations2/statusbar/"/-->
                <!--manifest:file-entry manifest:media-type="" manifest:full-path="Configurations2/accelerator/current.xml"/-->
                <!--manifest:file-entry manifest:media-type="" manifest:full-path="Configurations2/accelerator/"/-->
                <!--manifest:file-entry manifest:media-type="" manifest:full-path="Configurations2/floater/"/-->
                <!--manifest:file-entry manifest:media-type="" manifest:full-path="Configurations2/popupmenu/"/-->
                <!--manifest:file-entry manifest:media-type="" manifest:full-path="Configurations2/progressbar/"/-->
                <!--manifest:file-entry manifest:media-type="" manifest:full-path="Configurations2/menubar/"/-->
                <!--manifest:file-entry manifest:media-type="" manifest:full-path="Configurations2/toolbar/"/-->
                <!--manifest:file-entry manifest:media-type="" manifest:full-path="Configurations2/images/Bitmaps/"/-->
                <!--manifest:file-entry manifest:media-type="" manifest:full-path="Configurations2/images/"/-->
                <manifest:file-entry manifest:media-type="application/vnd.sun.xml.ui.configuration" manifest:full-path="Configurations2/"/>
                <manifest:file-entry manifest:media-type="default.text" manifest:full-path="Pictures/"/>
                <!--manifest:file-entry manifest:media-type="default.text" manifest:full-path="/Pictures/"/-->
                <manifest:file-entry manifest:media-type="text/xml" manifest:full-path="content.xml"/>
                <manifest:file-entry manifest:media-type="text/xml" manifest:full-path="styles.xml"/>
                <manifest:file-entry manifest:media-type="text/xml" manifest:full-path="meta.xml"/>
                <!--manifest:file-entry manifest:media-type="" manifest:full-path="Thumbnails/thumbnail.png"/-->
                <!--manifest:file-entry manifest:media-type="" manifest:full-path="Thumbnails/"/-->
                <manifest:file-entry manifest:media-type="text/xml" manifest:full-path="settings.xml"/>
            </manifest:manifest>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="document_mimetype">
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}mimetype" format="plaintext">
            <xsl:text>application/vnd.oasis.opendocument.text</xsl:text>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="document_meta">
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}meta.xml" format="odfxml">
            <office:document-meta xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:ooo="http://openoffice.org/2004/office" office:version="1.0"><!-- not meta content defined yet --></office:document-meta>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="document_settings">
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}settings.xml" format="odfxml">
            <office:document-settings xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:config="urn:oasis:names:tc:opendocument:xmlns:config:1.0" xmlns:ooo="http://openoffice.org/2004/office" office:version="1.0">
                <office:settings>
                    <config:config-item-set config:name="ooo:view-settings">
                        <config:config-item config:name="ViewAreaTop" config:type="int">0</config:config-item>
                        <config:config-item config:name="ViewAreaLeft" config:type="int">0</config:config-item>
                        <config:config-item config:name="ViewAreaWidth" config:type="int">25825</config:config-item>
                        <config:config-item config:name="ViewAreaHeight" config:type="int">18284</config:config-item>
                        <config:config-item config:name="ShowRedlineChanges" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="InBrowseMode" config:type="boolean">false</config:config-item>
                        <config:config-item-map-indexed config:name="Views">
                            <config:config-item-map-entry>
                                <config:config-item config:name="ViewId" config:type="string">view2</config:config-item>
                                <config:config-item config:name="ViewLeft" config:type="int">6454</config:config-item>
                                <config:config-item config:name="ViewTop" config:type="int">3002</config:config-item>
                                <config:config-item config:name="VisibleLeft" config:type="int">0</config:config-item>
                                <config:config-item config:name="VisibleTop" config:type="int">0</config:config-item>
                                <config:config-item config:name="VisibleRight" config:type="int">25823</config:config-item>
                                <config:config-item config:name="VisibleBottom" config:type="int">18283</config:config-item>
                                <config:config-item config:name="ZoomType" config:type="short">0</config:config-item>
                                <config:config-item config:name="ZoomFactor" config:type="short">100</config:config-item>
                                <config:config-item config:name="IsSelectedFrame" config:type="boolean">false</config:config-item>
                            </config:config-item-map-entry>
                        </config:config-item-map-indexed>
                    </config:config-item-set>
                    <config:config-item-set config:name="ooo:configuration-settings">
                        <config:config-item config:name="AddParaTableSpacing" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="PrintReversed" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="OutlineLevelYieldsNumbering" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="LinkUpdateMode" config:type="short">1</config:config-item>
                        <config:config-item config:name="PrintEmptyPages" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="IgnoreFirstLineIndentInNumbering" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="CharacterCompressionType" config:type="short">0</config:config-item>
                        <config:config-item config:name="PrintSingleJobs" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="UpdateFromTemplate" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="PrintPaperFromSetup" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="AddFrameOffsets" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="PrintLeftPages" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="RedlineProtectionKey" config:type="base64Binary"/>
                        <config:config-item config:name="PrintTables" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="ChartAutoUpdate" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="PrintControls" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="PrinterSetup" config:type="base64Binary"/>
                        <config:config-item config:name="IgnoreTabsAndBlanksForLineCalculation" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="PrintAnnotationMode" config:type="short">0</config:config-item>
                        <config:config-item config:name="LoadReadonly" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="AddParaSpacingToTableCells" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="AddExternalLeading" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="ApplyUserData" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="FieldAutoUpdate" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="SaveVersionOnClose" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="SaveGlobalDocumentLinks" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="IsKernAsianPunctuation" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="AlignTabStopPosition" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="ClipAsCharacterAnchoredWriterFlyFrames" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="CurrentDatabaseDataSource" config:type="string"/>
                        <config:config-item config:name="DoNotCaptureDrawObjsOnPage" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="TableRowKeep" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="PrinterName" config:type="string"/>
                        <config:config-item config:name="PrintFaxName" config:type="string"/>
                        <config:config-item config:name="ConsiderTextWrapOnObjPos" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="PrintRightPages" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="IsLabelDocument" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="UseFormerLineSpacing" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="AddParaTableSpacingAtStart" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="UseFormerTextWrapping" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="DoNotResetParaAttrsForNumFont" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="PrintProspect" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="PrintGraphics" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="AllowPrintJobCancel" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="CurrentDatabaseCommandType" config:type="int">0</config:config-item>
                        <config:config-item config:name="DoNotJustifyLinesWithManualBreak" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="UseFormerObjectPositioning" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="PrinterIndependentLayout" config:type="string">high-resolution</config:config-item>
                        <config:config-item config:name="UseOldNumbering" config:type="boolean">false</config:config-item>
                        <config:config-item config:name="PrintPageBackground" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="CurrentDatabaseCommand" config:type="string"/>
                        <config:config-item config:name="PrintDrawings" config:type="boolean">true</config:config-item>
                        <config:config-item config:name="PrintBlackFonts" config:type="boolean">false</config:config-item>
                    </config:config-item-set>
                </office:settings>
            </office:document-settings>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="document_styles">
        <xsl:param name="country"/>
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}styles.xml" format="odfxml">
            <office:document-styles xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0" xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0" xmlns:ooo="http://openoffice.org/2004/office" xmlns:ooow="http://openoffice.org/2004/writer" xmlns:oooc="http://openoffice.org/2004/calc" xmlns:dom="http://www.w3.org/2001/xml-events" office:version="1.0">
                <office:font-face-decls>
                    <style:font-face style:name="Tahoma1" svg:font-family="Tahoma"/>
                    <style:font-face style:name="Thorndale AMT" svg:font-family="&apos;Thorndale AMT&apos;" style:font-family-generic="roman" style:font-pitch="variable"/>
                    <style:font-face style:name="Albany AMT" svg:font-family="&apos;Albany AMT&apos;" style:font-family-generic="swiss" style:font-pitch="variable"/>
                    <style:font-face style:name="Arial Unicode MS" svg:font-family="&apos;Arial Unicode MS&apos;" style:font-family-generic="system" style:font-pitch="variable"/>
                    <style:font-face style:name="Albany AMT" svg:font-family="&apos;Albany AMT&apos;" style:font-family-generic="swiss" style:font-pitch="variable"/>
                    <style:font-face style:name="MS Mincho" svg:font-family="&apos;MS Mincho&apos;" style:font-family-generic="system" style:font-pitch="variable"/>
                    <style:font-face style:name="Tahoma" svg:font-family="Tahoma" style:font-family-generic="system" style:font-pitch="variable"/>
                    <style:font-face style:name="Cumberland AMT" svg:font-family="&apos;Cumberland AMT&apos;" style:font-family-generic="modern" style:font-pitch="fixed"/>
                </office:font-face-decls>
                <office:styles>
                    <!-- style for columnwidth-->
                    <style:style style:name="Column" style:family="table-column">
                        <style:table-column-properties style:use-optimal-column-width="true"/>
                    </style:style>
                    <!-- <xsl:for-each select="//elml:tabledata">
                        <style:style style:family="table">
                        <xsl:attribute name="table:style-name">
                        <xsl:value-of>table_</xsl:value-of>
                        <xsl:value-of select="string-length()"></xsl:value-of>
                        
                        </xsl:attribute>
                        
                        </style:style>
                        </xsl:for-each> -->
                    <!-- style for tableheight-->
                    <!-- style for tablecells-->
                    <style:style style:name="Cell_middle" style:family="table-cell">
                        <style:table-cell-properties style:vertical-align="middle"/>
                    </style:style>
                    <style:style style:name="Cell_top" style:family="table-cell">
                        <style:table-cell-properties style:vertical-align="top"/>
                    </style:style>
                    <style:style style:name="Cell_bottom" style:family="table-cell">
                        <style:table-cell-properties style:vertical-align="bottom"/>
                    </style:style>
                    <!-- style paragraphs in tablecells-->
                    <style:style style:name="cell_center" style:family="paragraph" style:parent-style-name="Table_20_Contents">
                        <style:paragraph-properties fo:text-align="center" style:justify-single-word="false"/>
                    </style:style>
                    <style:style style:name="cell_left" style:family="paragraph" style:parent-style-name="Table_20_Contents">
                        <style:paragraph-properties fo:text-align="start" style:justify-single-word="false"/>
                    </style:style>
                    <style:style style:name="cell_right" style:family="paragraph" style:parent-style-name="Table_20_Contents">
                        <style:paragraph-properties fo:text-align="end" style:justify-single-word="false"/>
                    </style:style>
                    <!-- style for column -->
                    <style:style style:name="columnbreak" style:family="paragraph" style:parent-style-name="Standard">
                        <style:paragraph-properties fo:break-before="column"/>
                    </style:style>
                    <style:style style:name="columnbreak" style:family="text" style:parent-style-name="Standard">
                        <style:paragraph-properties fo:break-before="column"/>
                    </style:style>
                    <style:style style:name="Sect1" style:family="section">
                        <style:section-properties text:dont-balance-text-columns="true" style:editable="true">
                            <style:columns fo:column-count="0" fo:column-gap="0cm"/>
                        </style:section-properties>
                    </style:style>
                    <style:style style:name="columntwo" style:family="section">
                        <style:section-properties text:dont-balance-text-columns="true" style:editable="true">
                            <style:columns fo:column-count="2" fo:column-gap="0cm">
                                <style:column style:rel-width="4818*" fo:start-indent="0cm" fo:end-indent="0cm"/>
                                <style:column style:rel-width="4819*" fo:start-indent="0cm" fo:end-indent="0cm"/>
                            </style:columns>
                        </style:section-properties>
                    </style:style>
                    <style:style style:name="columnthree" style:family="section">
                        <style:section-properties text:dont-balance-text-columns="true" style:editable="true">
                            <style:columns fo:column-count="3">
                                <style:column style:rel-width="3212*" fo:start-indent="0cm" fo:end-indent="0cm"/>
                                <style:column style:rel-width="3212*" fo:start-indent="0cm" fo:end-indent="0cm"/>
                                <style:column style:rel-width="3213*" fo:start-indent="0cm" fo:end-indent="0cm"/>
                            </style:columns>
                        </style:section-properties>
                    </style:style>
                    <!-- style for box as a frame -->
                    <!--   <style:style style:name="fr1" style:family="graphic" style:parent-style-name="Frame">
                        <style:graphic-properties style:wrap="none" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="center" style:horizontal-rel="paragraph"/>
                        </style:style>
                        <style:style style:name="Box" style:family="paragraph" style:parent-style-name="Standard" style:next-style-name="Standard" style:class="text" style:master-page-name="">
                        <style:paragraph-properties fo:padding="0.049cm" fo:border="0.002cm solid #000000" style:shadow="none" style:join-border="false">
                        <style:background-image/>
                        </style:paragraph-properties>
                        </style:style> -->
                    <!-- style for singelimage -->
                    <style:style style:name="gr1" style:family="graphic">
                        <style:graphic-properties style:run-through="background" style:vertical-pos="from-top" style:vertical-rel="paragraph-content" style:horizontal-pos="from-left" style:horizontal-rel="paragraph-content"/>
                    </style:style>
                    <!-- video -->
                    <style:style style:name="plugin_right_block" style:family="graphic">
                        <style:graphic-properties style:run-through="background" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="right" style:horizontal-rel="paragraph-content"> </style:graphic-properties>
                    </style:style>
                    <style:style style:name="plugin_center_block" style:family="graphic">
                        <style:graphic-properties style:run-through="background" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="center" style:horizontal-rel="paragraph-content"> </style:graphic-properties>
                    </style:style>
                    <style:style style:name="plugin_left_block" style:family="graphic">
                        <style:graphic-properties style:run-through="background" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="left" style:horizontal-rel="paragraph-content"> </style:graphic-properties>
                    </style:style>
                    <style:style style:name="plugin_right_inline" style:family="graphic">
                        <style:graphic-properties style:run-through="background" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="right" style:horizontal-rel="paragraph-content"> </style:graphic-properties>
                    </style:style>
                    <style:style style:name="plugin_center_inline" style:family="graphic">
                        <style:graphic-properties style:run-through="background" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="center" style:horizontal-rel="paragraph-content"> </style:graphic-properties>
                    </style:style>
                    <style:style style:name="plugin_left_inline" style:family="graphic">
                        <style:graphic-properties style:run-through="background" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="left" style:horizontal-rel="paragraph-content"> </style:graphic-properties>
                    </style:style>
                    <style:style style:name="plugin" style:family="graphic">
                        <style:graphic-properties style:run-through="background" style:vertical-pos="from-top" style:vertical-rel="paragraph-content" style:horizontal-pos="from-left" style:horizontal-rel="paragraph-content"/>
                    </style:style>
                    <!-- image -->
                    <style:style style:name="singleimage_right_block" style:family="graphic" style:parent-style-name="Graphics">
                        <style:graphic-properties style:wrap="none" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="right" style:horizontal-rel="paragraph-content" style:mirror="none" fo:clip="rect(0cm 0cm 0cm 0cm)" draw:luminance="0%" draw:contrast="0%" draw:red="0%" draw:green="0%" draw:blue="0%" draw:gamma="100%" draw:color-inversion="false" draw:image-opacity="100%" draw:color-mode="standard">
                            <style:background-image/>
                        </style:graphic-properties>
                    </style:style>
                    <style:style style:name="singleimage_center_block" style:family="graphic" style:parent-style-name="Graphics">
                        <style:graphic-properties style:wrap="none" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="center" style:horizontal-rel="paragraph-content" style:mirror="none" fo:clip="rect(0cm 0cm 0cm 0cm)" draw:luminance="0%" draw:contrast="0%" draw:red="0%" draw:green="0%" draw:blue="0%" draw:gamma="100%" draw:color-inversion="false" draw:image-opacity="100%" draw:color-mode="standard">
                            <style:background-image/>
                        </style:graphic-properties>
                    </style:style>
                    <style:style style:name="singleimage_left_block" style:family="graphic" style:parent-style-name="Graphics">
                        <style:graphic-properties style:wrap="none" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="left" style:horizontal-rel="paragraph-content" style:mirror="none" fo:clip="rect(0cm 0cm 0cm 0cm)" draw:luminance="0%" draw:contrast="0%" draw:red="0%" draw:green="0%" draw:blue="0%" draw:gamma="100%" draw:color-inversion="false" draw:image-opacity="100%" draw:color-mode="standard">
                            <style:background-image/>
                        </style:graphic-properties>
                    </style:style>
                    <style:style style:name="singleimage_right_inline" style:family="graphic" style:parent-style-name="Graphics">
                        <style:graphic-properties style:wrap="left" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="right" style:horizontal-rel="paragraph-content" style:mirror="none" fo:clip="rect(0cm 0cm 0cm 0cm)" draw:luminance="0%" draw:contrast="0%" draw:red="0%" draw:green="0%" draw:blue="0%" draw:gamma="100%" draw:color-inversion="false" draw:image-opacity="100%" draw:color-mode="standard">
                            <style:background-image/>
                        </style:graphic-properties>
                    </style:style>
                    <style:style style:name="singleimage_center_inline" style:family="graphic" style:parent-style-name="Graphics">
                        <style:graphic-properties style:wrap="none" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="center" style:horizontal-rel="paragraph-content" style:mirror="none" fo:clip="rect(0cm 0cm 0cm 0cm)" draw:luminance="0%" draw:contrast="0%" draw:red="0%" draw:green="0%" draw:blue="0%" draw:gamma="100%" draw:color-inversion="false" draw:image-opacity="100%" draw:color-mode="standard">
                            <style:background-image/>
                        </style:graphic-properties>
                    </style:style>
                    <style:style style:name="singleimage_left_inline" style:family="graphic" style:parent-style-name="Graphics">
                        <style:graphic-properties style:wrap="right" style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="left" style:horizontal-rel="paragraph-content" style:mirror="none" fo:clip="rect(0cm 0cm 0cm 0cm)" draw:luminance="0%" draw:contrast="0%" draw:red="0%" draw:green="0%" draw:blue="0%" draw:gamma="100%" draw:color-inversion="false" draw:image-opacity="100%" draw:color-mode="standard">
                            <style:background-image/>
                        </style:graphic-properties>
                    </style:style>
                    <style:style style:name="singleimage" style:family="graphic" style:parent-style-name="Graphics">
                        <style:graphic-properties style:mirror="none" fo:clip="rect(0cm 0cm 0cm 0cm)" draw:luminance="0%" draw:contrast="0%" draw:red="0%" draw:green="0%" draw:blue="0%" draw:gamma="100%" draw:color-inversion="false" draw:image-opacity="100%" draw:color-mode="standard"/>
                    </style:style>
                    <!-- -->
                    <style:style style:name="frame__right_block" style:family="graphic" style:parent-style-name="Frame">
                        <style:graphic-properties style:run-through="foreground" fo:margin-left="0cm" fo:margin-right="0cm" fo:margin-top="0cm" fo:margin-bottom="0cm" style:wrap="none" style:number-wrapped-paragraphs="no-limit" style:vertical-pos="top" style:vertical-rel="paragraph" style:horizontal-pos="right" style:horizontal-rel="paragraph" fo:padding="0cm" fo:border="none"/>
                    </style:style>
                    <style:style style:name="frame__center_block" style:family="graphic" style:parent-style-name="Frame">
                        <style:graphic-properties style:run-through="foreground" fo:margin-left="0cm" fo:margin-right="0cm" fo:margin-top="0cm" fo:margin-bottom="0cm" style:wrap="none" style:number-wrapped-paragraphs="no-limit" style:vertical-pos="top" style:vertical-rel="paragraph" style:horizontal-pos="center" style:horizontal-rel="paragraph" fo:padding="0cm" fo:border="none"/>
                    </style:style>
                    <style:style style:name="frame__left_block" style:family="graphic" style:parent-style-name="Frame">
                        <style:graphic-properties style:run-through="foreground" fo:margin-left="0cm" fo:margin-right="0cm" fo:margin-top="0cm" fo:margin-bottom="0cm" style:wrap="none" style:number-wrapped-paragraphs="no-limit" style:vertical-pos="top" style:vertical-rel="paragraph" style:horizontal-pos="left" style:horizontal-rel="paragraph" fo:padding="0cm" fo:border="none"/>
                    </style:style>
                    <style:style style:name="frame__right_inline" style:family="graphic" style:parent-style-name="Frame">
                        <style:graphic-properties style:run-through="foreground" fo:margin-left="0cm" fo:margin-right="0cm" fo:margin-top="0cm" fo:margin-bottom="0cm" style:wrap="parallel" style:number-wrapped-paragraphs="no-limit" style:vertical-pos="top" style:vertical-rel="paragraph" style:horizontal-pos="right" style:horizontal-rel="paragraph" fo:padding="0cm" fo:border="none"/>
                    </style:style>
                    <style:style style:name="frame__center_inline" style:family="graphic" style:parent-style-name="Frame">
                        <style:graphic-properties style:run-through="foreground" fo:margin-left="0cm" fo:margin-right="0cm" fo:margin-top="0cm" fo:margin-bottom="0cm" style:wrap="none" style:number-wrapped-paragraphs="no-limit" style:vertical-pos="top" style:vertical-rel="paragraph" style:horizontal-pos="center" style:horizontal-rel="paragraph" fo:padding="0cm" fo:border="none"/>
                    </style:style>
                    <style:style style:name="frame__left_inline" style:family="graphic" style:parent-style-name="Frame">
                        <style:graphic-properties style:run-through="foreground" fo:margin-left="0cm" fo:margin-right="0cm" fo:margin-top="0cm" fo:margin-bottom="0cm" style:wrap="parallel" style:number-wrapped-paragraphs="no-limit" style:vertical-pos="top" style:vertical-rel="paragraph" style:horizontal-pos="left" style:horizontal-rel="paragraph" fo:padding="0cm" fo:border="none"/>
                    </style:style>
                    <style:style style:name="frame__" style:family="graphic" style:parent-style-name="Frame">
                        <style:graphic-properties style:run-through="foreground" fo:margin-left="0cm" fo:margin-right="0cm" fo:margin-top="0cm" fo:margin-bottom="0cm" style:number-wrapped-paragraphs="no-limit" style:vertical-pos="top" style:vertical-rel="paragraph" style:horizontal-rel="paragraph" fo:padding="0cm" fo:border="none"/>
                    </style:style>
                    <!-- Formula style is also used as parent style for displaying mathml -->
                    <style:style style:name="Formula" style:family="graphic">
                        <style:graphic-properties text:anchor-type="as-char" svg:y="0cm" fo:margin-left="0.201cm" fo:margin-right="0.201cm" style:vertical-pos="middle" style:vertical-rel="text"/>
                    </style:style>
                    <!-- mathml style-->
                    <style:style style:name="mathml" style:family="graphic" style:parent-style-name="Formula">
                        <style:graphic-properties style:vertical-pos="middle" style:vertical-rel="text" draw:ole-draw-aspect="1"/>
                    </style:style>
                    <!-- up to now every matml style from here is equally as the default above called 'matml' -->
                    <style:style style:name="mathml__right_block" style:family="graphic" style:parent-style-name="Formula">
                        <style:graphic-properties style:vertical-pos="middle" style:vertical-rel="text" draw:ole-draw-aspect="1"/>
                    </style:style>
                    <style:style style:name="mathml__center_block" style:family="graphic" style:parent-style-name="Formula">
                        <style:graphic-properties style:vertical-pos="middle" style:vertical-rel="text" draw:ole-draw-aspect="1"/>
                    </style:style>
                    <style:style style:name="mathml__left_block" style:family="graphic" style:parent-style-name="Formula">
                        <style:graphic-properties style:vertical-pos="middle" style:vertical-rel="text" draw:ole-draw-aspect="1"/>
                    </style:style>
                    <style:style style:name="mathml__right_inline" style:family="graphic" style:parent-style-name="Formula">
                        <style:graphic-properties style:vertical-pos="middle" style:vertical-rel="text" draw:ole-draw-aspect="1"/>
                    </style:style>
                    <style:style style:name="mathml__center_inline" style:family="graphic" style:parent-style-name="Formula">
                        <style:graphic-properties style:vertical-pos="middle" style:vertical-rel="text" draw:ole-draw-aspect="1"/>
                    </style:style>
                    <style:style style:name="mathml__left_inline" style:family="graphic" style:parent-style-name="Formula">
                        <style:graphic-properties style:vertical-pos="middle" style:vertical-rel="text" draw:ole-draw-aspect="1"/>
                    </style:style>
                    <style:style style:name="mathml__" style:family="graphic" style:parent-style-name="Formula">
                        <style:graphic-properties style:vertical-pos="middle" style:vertical-rel="text" draw:ole-draw-aspect="1"/>
                    </style:style>
                    <!-- style for List-Paragraph -->
                    <style:style style:name="ListorderedParagraph" style:family="paragraph" style:parent-style-name="Standard" style:list-style-name="L1"/>
                    <!-- style for List-Frame -->
                    <style:style style:name="ListorderedFrame" style:family="graphic" style:parent-style-name="Frame">
                        <style:graphic-properties style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="center" style:horizontal-rel="paragraph"/>
                    </style:style>
                    <!-- style for list-->
                    <text:list-style style:name="Listordered">
                        <text:list-level-style-number text:level="1" text:style-name="Numbering_20_Symbols" style:num-prefix="" style:num-suffix=". " style:num-format="1">
                            <style:list-level-properties text:space-before="0.635cm" text:min-label-width="0.635cm"/>
                        </text:list-level-style-number>
                        <text:list-level-style-number text:level="2" text:style-name="Numbering_20_Symbols" style:num-prefix="" style:num-suffix=". " style:num-format="1" text:display-levels="2">
                            <style:list-level-properties text:space-before="1.27cm" text:min-label-width="0.635cm"/>
                        </text:list-level-style-number>
                        <text:list-level-style-number text:level="3" text:style-name="Numbering_20_Symbols" style:num-prefix="" style:num-suffix=". " style:num-format="1" text:display-levels="3">
                            <style:list-level-properties text:space-before="1.905cm" text:min-label-width="0.635cm"/>
                        </text:list-level-style-number>
                        <text:list-level-style-number text:level="4" text:style-name="Numbering_20_Symbols" style:num-prefix="" style:num-suffix=". " style:num-format="1" text:display-levels="4">
                            <style:list-level-properties text:space-before="2.54cm" text:min-label-width="0.635cm"/>
                        </text:list-level-style-number>
                        <text:list-level-style-number text:level="5" text:style-name="Numbering_20_Symbols" style:num-prefix="" style:num-suffix=". " style:num-format="1" text:display-levels="5">
                            <style:list-level-properties text:space-before="3.175cm" text:min-label-width="0.635cm"/>
                        </text:list-level-style-number>
                        <text:list-level-style-number text:level="6" text:style-name="Numbering_20_Symbols" style:num-prefix="" style:num-suffix=". " style:num-format="1" text:display-levels="6">
                            <style:list-level-properties text:space-before="3.81cm" text:min-label-width="0.635cm"/>
                        </text:list-level-style-number>
                        <text:list-level-style-number text:level="7" text:style-name="Numbering_20_Symbols" style:num-prefix="" style:num-suffix=". " style:num-format="1" text:display-levels="7">
                            <style:list-level-properties text:space-before="4.445cm" text:min-label-width="0.635cm"/>
                        </text:list-level-style-number>
                        <text:list-level-style-number text:level="8" text:style-name="Numbering_20_Symbols" style:num-prefix="" style:num-suffix=". " style:num-format="1" text:display-levels="8">
                            <style:list-level-properties text:space-before="5.08cm" text:min-label-width="0.635cm"/>
                        </text:list-level-style-number>
                        <text:list-level-style-number text:level="9" text:style-name="Numbering_20_Symbols" style:num-prefix="" style:num-suffix=". " style:num-format="1" text:display-levels="9">
                            <style:list-level-properties text:space-before="5.715cm" text:min-label-width="0.635cm"/>
                        </text:list-level-style-number>
                        <text:list-level-style-number text:level="10" text:style-name="Numbering_20_Symbols" style:num-prefix="" style:num-suffix=". " style:num-format="1" text:display-levels="10">
                            <style:list-level-properties text:space-before="6.35cm" text:min-label-width="0.635cm"/>
                        </text:list-level-style-number>
                    </text:list-style>
                    <style:default-style style:family="graphic">
                        <style:graphic-properties draw:shadow-offset-x="0.3cm" draw:shadow-offset-y="0.3cm" draw:start-line-spacing-horizontal="0.283cm" draw:start-line-spacing-vertical="0.283cm" draw:end-line-spacing-horizontal="0.283cm" draw:end-line-spacing-vertical="0.283cm" style:flow-with-text="false"/>
                        <style:paragraph-properties style:text-autospace="ideograph-alpha" style:line-break="strict" style:writing-mode="lr-tb" style:font-independent-line-spacing="false">
                            <style:tab-stops/>
                        </style:paragraph-properties>
                        <style:text-properties style:use-window-font-color="true" fo:font-size="12pt" style:font-size-asian="10.5pt" style:language-asian="zxx" style:country-asian="none" style:font-size-complex="12pt" style:language-complex="zxx" style:country-complex="none">
                            <!-- here are the setings of the language and the country -->
                            <xsl:attribute name="fo:language">
                                <xsl:value-of select="$lang"/>
                            </xsl:attribute>
                            <xsl:attribute name="fo:country">
                                <xsl:value-of select="$country"/>
                            </xsl:attribute>
                        </style:text-properties>
                    </style:default-style>
                    <style:default-style style:family="paragraph">
                        <style:paragraph-properties fo:hyphenation-ladder-count="no-limit" style:text-autospace="ideograph-alpha" style:punctuation-wrap="hanging" style:line-break="strict" style:tab-stop-distance="1.251cm" style:writing-mode="page"> </style:paragraph-properties>
                        <style:text-properties style:use-window-font-color="true" style:font-name="Tahoma" fo:font-size="10.5pt" style:font-name-asian="Arial Unicode MS" style:font-size-asian="10.5pt" style:language-asian="zxx" style:country-asian="none" style:font-name-complex="Tahoma" style:font-size-complex="12pt" style:language-complex="zxx" style:country-complex="none" fo:hyphenation-remain-char-count="2" fo:hyphenation-push-char-count="2">
                            <xsl:attribute name="fo:hyphenate">
                                <xsl:value-of select="$hyphenation"/>
                            </xsl:attribute>
                            <!-- here are the setings of the language and the country -->
                            <xsl:attribute name="fo:language">
                                <xsl:value-of select="$lang"/>
                            </xsl:attribute>
                            <xsl:attribute name="fo:country">
                                <xsl:value-of select="$country"/>
                            </xsl:attribute>
                        </style:text-properties>
                    </style:default-style>
                    <style:default-style style:family="table">
                        <style:table-properties table:border-model="collapsing"/>
                    </style:default-style>
                    <style:default-style style:family="table-row">
                        <style:table-row-properties fo:keep-together="auto"/>
                    </style:default-style>
                    <!-- Frame style -->
                    <style:style style:name="Frame" style:family="graphic">
                        <style:graphic-properties fo:border="none" style:shadow="none"/>
                    </style:style>
                    <!-- <style:style style:name="ListorderedFrame" style:family="graphic" style:parent-style-name="Frame">
                        <style:graphic-properties style:vertical-pos="top" style:vertical-rel="paragraph-content" style:horizontal-pos="center" style:horizontal-rel="paragraph"/>
                    </style:style> -->
                    <!-- Standard Style -->
                    <style:style style:name="Standard" style:family="paragraph" style:class="text"/>
                    <style:style style:name="Standard1" style:display-name="Standard1" style:family="paragraph" style:class="text">
                        <style:paragraph-properties fo:line-height="100%" fo:margin-top="0.10cm" fo:margin-bottom="0.10cm">
                            <xsl:attribute name="fo:orphans">
                                <xsl:value-of select="$default_paragraph_orphans"/>
                            </xsl:attribute>
                            <xsl:attribute name="fo:text-align">
                                <xsl:value-of select="$default_text-align"/>
                            </xsl:attribute>
                        </style:paragraph-properties>
                    </style:style>
                    <!-- Bibliography Style -->
                    <style:style style:name="Bibliography" style:display-name="Bibliography" style:family="paragraph" style:class="text">
                        <style:paragraph-properties fo:line-height="100%" fo:margin-top="0.15cm" fo:margin-bottom="0.5cm">
                            <xsl:attribute name="fo:orphans">
                                <xsl:value-of select="$default_paragraph_orphans"/>
                            </xsl:attribute>
                            <xsl:attribute name="fo:text-align">
                                <xsl:value-of select="left"/>
                            </xsl:attribute>
                        </style:paragraph-properties>
                    </style:style>
                    <!-- Box Style -->
                    <style:style style:name="ParagraphBox" style:display-name="ParagraphBox" style:family="paragraph" style:class="text">
                        <style:paragraph-properties fo:line-height="100%" fo:margin-top="0.15cm" fo:margin-bottom="0.15cm" fo:background-color="#c0c0c0"/>
                    </style:style>
                    <!-- Popup Style -->
                    <style:style style:name="ParagraphPopup" style:display-name="ParagraphPopup" style:family="paragraph" style:class="text">
                        <style:paragraph-properties fo:line-height="100%" fo:margin-top="0.15cm" fo:margin-bottom="0.15cm" fo:background-color="#c0c0c0" fo:border="0.002cm solid #000000"/>
                    </style:style>
                    <!-- Paragraph within a Box -->
                    <style:style style:name="Frame_20_contents" style:display-name="Frame contents" style:family="paragraph" style:parent-style-name="Text_20_body" style:class="extra"/>

                    <style:style style:name="Heading" style:family="paragraph" style:parent-style-name="Standard" style:next-style-name="Text_20_body" style:class="text">
                        <style:paragraph-properties fo:margin-top="0.423cm" fo:margin-bottom="0.212cm" fo:keep-with-next="always"/>
                        <style:text-properties style:font-name="Albany AMT" fo:font-size="14pt" style:font-name-asian="MS Mincho" style:font-size-asian="14pt" style:font-name-complex="Tahoma" style:font-size-complex="14pt"/>
                    </style:style>


                    <style:style style:name="Heading_20_1" style:display-name="Heading 1" style:family="paragraph" style:parent-style-name="Standard" style:next-style-name="Text_20_body" style:class="text">
                        <style:paragraph-properties fo:keep-with-next="always">
                            <xsl:attribute name="fo:margin-top">
                                <xsl:value-of select="$Heading1_margin_top"/>
                            </xsl:attribute>
                            <xsl:attribute name="fo:margin-bottom">
                                <xsl:value-of select="$Heading1_margin_bottom"/>
                            </xsl:attribute>
                        </style:paragraph-properties>
                        <style:text-properties fo:font-weight="bold" style:font-weight-asian="bold" style:font-name="Tahoma" style:font-name-asian="MS Mincho" style:font-size-asian="14pt" style:font-name-complex="Tahoma" style:font-size-complex="14pt">
                            <xsl:attribute name="fo:font-size">
                                <xsl:value-of select="$Heading1"/>
                            </xsl:attribute>
                        </style:text-properties>
                    </style:style>
                    <style:style style:name="Heading_20_2" style:display-name="Heading 2" style:family="paragraph" style:parent-style-name="Standard" style:next-style-name="Text_20_body" style:class="text">
                        <style:paragraph-properties fo:keep-with-next="always">
                            <xsl:attribute name="fo:margin-top">
                                <xsl:value-of select="$Heading2_margin_top"/>
                            </xsl:attribute>
                            <xsl:attribute name="fo:margin-bottom">
                                <xsl:value-of select="$Heading2_margin_bottom"/>
                            </xsl:attribute>
                        </style:paragraph-properties>
                        <style:text-properties fo:font-weight="bold" style:font-weight-asian="bold" style:font-name="Tahoma" style:font-name-asian="MS Mincho" style:font-size-asian="14pt" style:font-name-complex="Tahoma" style:font-size-complex="14pt">
                            <xsl:attribute name="fo:font-size">
                                <xsl:value-of select="$Heading2"/>
                            </xsl:attribute>
                        </style:text-properties>
                    </style:style>
                    <style:style style:name="Heading_20_3" style:display-name="Heading 3" style:family="paragraph" style:parent-style-name="Standard" style:next-style-name="Text_20_body" style:class="text">
                        <style:paragraph-properties fo:keep-with-next="always">
                            <xsl:attribute name="fo:margin-top">
                                <xsl:value-of select="$Heading3_margin_top"/>
                            </xsl:attribute>
                            <xsl:attribute name="fo:margin-bottom">
                                <xsl:value-of select="$Heading3_margin_bottom"/>
                            </xsl:attribute>
                        </style:paragraph-properties>
                        <style:text-properties fo:font-weight="bold" style:font-weight-asian="bold" style:font-name="Tahoma" style:font-name-asian="MS Mincho" style:font-size-asian="14pt" style:font-name-complex="Tahoma" style:font-size-complex="14pt">
                            <xsl:attribute name="fo:font-size">
                                <xsl:value-of select="$Heading3"/>
                            </xsl:attribute>
                        </style:text-properties>
                    </style:style>
                    <style:style style:name="Heading_20_4" style:display-name="Heading 4" style:family="paragraph" style:parent-style-name="Standard" style:next-style-name="Text_20_body" style:class="text">
                        <style:paragraph-properties fo:keep-with-next="always">
                            <xsl:attribute name="fo:margin-top">
                                <xsl:value-of select="$Heading4_margin_top"/>
                            </xsl:attribute>
                            <xsl:attribute name="fo:margin-bottom">
                                <xsl:value-of select="$Heading4_margin_bottom"/>
                            </xsl:attribute>
                        </style:paragraph-properties>
                        <style:text-properties fo:font-weight="bold" style:font-weight-asian="bold" style:font-name="Tahoma" style:font-name-asian="MS Mincho" style:font-size-asian="14pt" style:font-name-complex="Tahoma" style:font-size-complex="14pt">
                            <xsl:attribute name="fo:font-size">
                                <xsl:value-of select="$Heading4"/>
                            </xsl:attribute>
                        </style:text-properties>
                    </style:style>
                    <style:style style:name="Heading_20_5" style:display-name="Heading 5" style:family="paragraph" style:parent-style-name="Standard" style:next-style-name="Text_20_body" style:class="text">
                        <style:paragraph-properties fo:keep-with-next="always">
                            <xsl:attribute name="fo:margin-top">
                                <xsl:value-of select="$Heading5_margin_top"/>
                            </xsl:attribute>
                            <xsl:attribute name="fo:margin-bottom">
                                <xsl:value-of select="$Heading5_margin_bottom"/>
                            </xsl:attribute>
                        </style:paragraph-properties>
                        <style:text-properties fo:font-weight="bold" style:font-weight-asian="bold" style:font-name="Tahoma" style:font-name-asian="MS Mincho" style:font-size-asian="14pt" style:font-name-complex="Tahoma" style:font-size-complex="14pt">
                            <xsl:attribute name="fo:font-size">
                                <xsl:value-of select="$Heading5"/>
                            </xsl:attribute>
                        </style:text-properties>
                    </style:style>
                    <style:style style:name="pagebreak" style:family="paragraph">
                        <style:paragraph-properties fo:break-before="page"/>
                    </style:style>
                    <style:style style:name="pagebreak_20_1" style:display-name="pagebreak 1" style:family="paragraph" style:parent-style-name="pagebreak">
                        <style:text-properties fo:font-weight="bold" style:font-weight-asian="bold">
                            <xsl:attribute name="fo:font-size">
                                <xsl:value-of select="$Heading1"/>
                            </xsl:attribute>
                        </style:text-properties>
                    </style:style>
                    <style:style style:name="pagebreak_20_2" style:display-name="pagebreak 2" style:family="paragraph" style:parent-style-name="pagebreak">
                        <style:text-properties fo:font-weight="bold" style:font-weight-asian="bold">
                            <xsl:attribute name="fo:font-size">
                                <xsl:value-of select="$Heading2"/>
                            </xsl:attribute>
                        </style:text-properties>
                    </style:style>
                    <style:style style:name="pagebreak_20_3" style:display-name="pagebreak 3" style:family="paragraph" style:parent-style-name="pagebreak">
                        <style:text-properties fo:font-weight="bold" style:font-weight-asian="bold">
                            <xsl:attribute name="fo:font-size">
                                <xsl:value-of select="$Heading3"/>
                            </xsl:attribute>
                        </style:text-properties>
                    </style:style>
                    <style:style style:name="List" style:family="paragraph" style:parent-style-name="Text_20_body" style:class="list">
                        <style:text-properties style:font-size-asian="12pt" style:font-name-complex="Tahoma1"/>
                    </style:style>
                    <style:style style:name="Caption" style:family="paragraph" style:parent-style-name="Standard" style:class="extra">
                        <style:paragraph-properties fo:margin-top="0.212cm" fo:margin-bottom="0.212cm" text:number-lines="false" text:line-number="0"/>
                        <style:text-properties fo:font-size="10.5pt" style:font-size-asian="10.5pt" style:font-name-complex="Tahoma1" style:font-size-complex="10.5pt"/>
                        <!-- <xsl:attribute name="fo:font-style"><xsl:value-of>italic</xsl:value-of></xsl:attribute> -->
                        <!-- <xsl:attribute name="fo:font-style-complex"><xsl:value-of>italic</xsl:value-of></xsl:attribute> -->
                        <!-- <xsl:attribute name="fo:font-style-asian"><xsl:value-of>italic</xsl:value-of></xsl:attribute> -->
                    </style:style>
                    <style:style style:name="Index" style:family="paragraph" style:parent-style-name="Standard" style:class="index">
                        <style:paragraph-properties text:number-lines="false" text:line-number="0"/>
                        <style:text-properties style:font-size-asian="12pt" style:font-name-complex="Tahoma1"/>
                    </style:style>
                    <!-- Internet Link-->
                    <style:style style:name="Internet_20_link" style:display-name="Internet link" style:family="text">
                        <style:text-properties fo:color="#000080" style:text-underline-style="solid" style:text-underline-width="auto" style:text-underline-color="font-color"/>
                    </style:style>
                    <style:style style:name="Visited_20_Internet_20_Link" style:display-name="Visited Internet Link" style:family="text">
                        <style:text-properties fo:color="#800000" style:text-underline-style="solid" style:text-underline-width="auto" style:text-underline-color="font-color"/>
                    </style:style>
                    <!-- Paragraph within a Tablecell -->
                    <style:style style:name="Table_20_Contents" style:display-name="Table Contents" style:family="paragraph" style:parent-style-name="Standard" style:class="extra">
                        <style:paragraph-properties text:number-lines="false" text:line-number="0"/>
                    </style:style>
                    <!-- Caption Styles for Tables -->
                    <style:style style:name="Table_Caption" style:family="paragraph" style:parent-style-name="Caption" style:class="extra"/>
                    <!-- here you find the declarations of styles-->
                    <!-- standard span style -->
                    <style:style style:name="standard1" style:display-name="standard1" style:family="text"/>
                    <style:style style:name="code" style:display-name="code" style:family="text">
                        <style:text-properties style:font-name="Cumberland AMT" style:font-name-asian="Cumberland AMT" style:font-name-complex="Cumberland AMT"/>
                    </style:style>
                    <style:style style:name="paragraphBox" style:display-name="paragraphBox" style:family="text">
                        <style:text-properties fo:background-color="#c0c0c0"/>
                    </style:style>
                    <style:style style:name="paragraphPopup" style:display-name="paragraphPopup" style:family="text">
                        <style:text-properties fo:background-color="#c0c0c0" fo:border="0.002cm solid #000000"/>
                    </style:style>
                    <style:style style:name="crossedOut" style:display-name="crossedOut" style:family="text">
                        <style:text-properties style:text-line-through-style="solid"/>
                    </style:style>
                    <style:style style:name="upperCase" style:display-name="upperCase" style:family="text">
                        <style:text-properties fo:text-transform="uppercase"/>
                    </style:style>
                    <style:style style:name="lowerCase" style:display-name="lowerCase" style:family="text">
                        <style:text-properties fo:text-transform="lowercase"/>
                    </style:style>
                    <style:style style:name="bold" style:display-name="bold" style:family="paragraph">
                        <style:text-properties fo:font-weight="bold" style:font-weight-asian="bold" style:font-weight-complex="bold"/>
                    </style:style>
                    <style:style style:name="bold" style:display-name="bold" style:family="text">
                        <style:text-properties fo:font-weight="bold" style:font-weight-asian="bold" style:font-weight-complex="bold"/>
                    </style:style>
                    <style:style style:name="bibAuthor" style:display-name="bold" style:family="text">
                        <style:text-properties fo:font-weight="bold" style:font-weight-asian="bold" style:font-weight-complex="bold"/>
                    </style:style>
                    <style:style style:name="italic" style:display-name="italic" style:family="text">
                        <style:text-properties fo:font-style="italic" style:font-style-asian="italic" style:font-style-complex="italic"/>
                    </style:style>
                    <style:style style:name="bibTitle" style:display-name="italic" style:family="text">
                        <style:text-properties fo:font-style="italic" style:font-style-asian="italic" style:font-style-complex="italic"/>
                    </style:style>
                    <style:style style:name="underlined" style:display-name="underlined" style:family="text">
                        <style:text-properties fo:font-style="normal" style:text-underline-style="solid" style:text-underline-width="auto" style:text-underline-color="font-color"/>
                    </style:style>
                    <style:style style:name="subscript" style:display-name="subscript" style:family="text">
                        <style:text-properties fo:font-size="6pt" style:text-underline-style="none" style:font-size-asian="6pt" style:font-size-complex="6pt" style:text-emphasize="none"/>
                    </style:style>
                    <style:style style:name="superscript" style:display-name="superscript" style:family="text">
                        <style:text-properties style:text-position="super 58%"/>
                    </style:style>
                    <style:style style:name="Footer" style:family="paragraph" style:parent-style-name="Standard" style:class="extra">
                        <style:paragraph-properties fo:text-align="end" style:justify-single-word="false" text:number-lines="false" text:line-number="0">
                            <style:tab-stops>
                                <style:tab-stop style:position="8.498cm" style:type="center"/>
                                <style:tab-stop style:position="16.999cm" style:type="right"/>
                            </style:tab-stops>
                        </style:paragraph-properties>
                        <style:text-properties style:font-name="Arial" fo:font-size="10pt" style:font-size-asian="10.5pt"/>
                    </style:style>
                    <!-- Number Format Style -->
                    <style:style style:name="Numbering_20_Symbols" style:display-name="Numbering Symbols" style:family="text"/>
                    <!-- the individual styles of the project -->
                    <xsl:if test="$enable_project_styles">
                        <xsl:call-template name="project_styles"/>
                    </xsl:if>
                    <!-- here ends the declaration of styles-->
                    <text:outline-style>
                        <text:outline-level-style text:level="1" style:num-format="">
                            <style:list-level-properties text:min-label-distance="0.381cm"/>
                        </text:outline-level-style>
                        <text:outline-level-style text:level="2" style:num-format="">
                            <style:list-level-properties text:min-label-distance="0.381cm"/>
                        </text:outline-level-style>
                        <text:outline-level-style text:level="3" style:num-format="">
                            <style:list-level-properties text:min-label-distance="0.381cm"/>
                        </text:outline-level-style>
                        <text:outline-level-style text:level="4" style:num-format="">
                            <style:list-level-properties text:min-label-distance="0.381cm"/>
                        </text:outline-level-style>
                        <text:outline-level-style text:level="5" style:num-format="">
                            <style:list-level-properties text:min-label-distance="0.381cm"/>
                        </text:outline-level-style>
                        <text:outline-level-style text:level="6" style:num-format="">
                            <style:list-level-properties text:min-label-distance="0.381cm"/>
                        </text:outline-level-style>
                        <text:outline-level-style text:level="7" style:num-format="">
                            <style:list-level-properties text:min-label-distance="0.381cm"/>
                        </text:outline-level-style>
                        <text:outline-level-style text:level="8" style:num-format="">
                            <style:list-level-properties text:min-label-distance="0.381cm"/>
                        </text:outline-level-style>
                        <text:outline-level-style text:level="9" style:num-format="">
                            <style:list-level-properties text:min-label-distance="0.381cm"/>
                        </text:outline-level-style>
                        <text:outline-level-style text:level="10" style:num-format="">
                            <style:list-level-properties text:min-label-distance="0.381cm"/>
                        </text:outline-level-style>
                    </text:outline-style>
                    <text:notes-configuration text:note-class="footnote" style:num-format="1" text:start-value="0" text:footnotes-position="page" text:start-numbering-at="document"/>
                    <text:notes-configuration text:note-class="endnote" style:num-format="i" text:start-value="0"/>
                    <text:linenumbering-configuration text:number-lines="false" text:offset="0.499cm" style:num-format="1" text:number-position="left" text:increment="5"/>
                </office:styles>
                <office:automatic-styles>
                    <style:page-layout style:name="pm1">
                        <style:page-layout-properties fo:page-width="{$pagewidth}" fo:page-height="{$pageheight}" style:num-format="1" style:print-orientation="portrait" fo:margin-top="2cm" fo:margin-bottom="2cm" fo:margin-left="2cm" fo:margin-right="2cm" style:writing-mode="lr-tb" style:footnote-max-height="0cm">
                            <style:footnote-sep style:width="0.018cm" style:distance-before-sep="0.101cm" style:distance-after-sep="0.101cm" style:adjustment="left" style:rel-width="25%" style:color="#000000"/>
                        </style:page-layout-properties>
                        <style:header-style/>
                        <style:footer-style/>
                    </style:page-layout>
                </office:automatic-styles>
                <office:master-styles>
                    <style:master-page style:name="Standard" style:page-layout-name="pm1">
                        <style:footer>
                            <text:p text:style-name="Footer">
                                <text:page-number text:select-page="current"/>
                            </text:p>
                        </style:footer>
                    </style:master-page>
                </office:master-styles>
            </office:document-styles>
        </xsl:result-document>
    </xsl:template>
    <!-- glossary -->
    <xsl:template name="glossary">
        <xsl:if test="not(/elml:lesson/elml:glossary[@visible = 'online'])">
            <xsl:for-each select="/elml:lesson/elml:glossary/elml:definition">
                <text:p>
                    <xsl:element name="text:bookmark">
                        <xsl:attribute name="text:name">
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:value-of>_</xsl:value-of>
                            <xsl:value-of select="@term"/>
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:value-of select="@term"/>
                </text:p>
                <text:p>
                    <xsl:apply-templates/>
                    <text:line-break/>
                </text:p>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <!-- display -->
    <xsl:template name="elml:display">
        <xsl:choose>
            <xsl:when test="((@role='student') or (@role=$role) or (not (@role))) and not(@visible='online') and not(@visible='none')">
                <xsl:text>yes</xsl:text>
            </xsl:when>
            <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- units for tablecolumns-->
    <xsl:template name="units_Width_average">
        <xsl:for-each select="elml:tablerow">
            <xsl:for-each select="elml:tabledata">
                <xsl:choose>
                    <xsl:when test="@units">
                        <xsl:value-of select="@units"/>
                        <xsl:value-of>
                            <xsl:text> </xsl:text>
                        </xsl:value-of>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    <!-- width for tablecolumns-->
    <xsl:template name="Width_average">
        <xsl:for-each select="elml:tablerow">
            <xsl:for-each select="elml:tabledata">
                <xsl:choose>
                    <xsl:when test="@width">
                        <xsl:value-of select="@width"/>
                        <xsl:value-of>
                            <xsl:text> </xsl:text>
                        </xsl:value-of>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    <!-- width -->
    <xsl:template name="elml:Width">
        <xsl:choose>
            <xsl:when test="name()='multimedia'">
                <xsl:choose>
                    <xsl:when test="@width">
                        <xsl:attribute name="svg:width">
                            <xsl:choose>
                                <xsl:when test="@units='percent'">
                                    <xsl:value-of select="@width"/>
                                    <xsl:text>%</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="(@width) * $converter_pixel_cm"/>
                                    <xsl:text>cm</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="not(@width) and @height">
                        <xsl:attribute name="svg:width">
                            <xsl:choose>
                                <xsl:when test="@units='percent'">
                                    <xsl:value-of select="@height"/>
                                    <xsl:text>%</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="(@height) * $converter_pixel_cm"/>
                                    <xsl:text>cm</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="svg:width">
                            <xsl:value-of>2.5cm</xsl:value-of>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="name()='tabledata'">
                <xsl:choose>
                    <xsl:when test="@units='percent' and not(ancestor::elml:box or ancestor::elml:popup)">
                        <xsl:attribute name="style:column-width">
                            <xsl:value-of select="16.99 * ((@width) div 100)"/>
                            <xsl:text>cm</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="@units='pixels' and not(parent::elml:box or parent::elml:popup)">
                        <xsl:attribute name="style:column-width">
                            <xsl:value-of select="(@width) * $converter_pixel_cm"/>
                            <xsl:text>cm</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise> </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="name()='table'">
                <xsl:choose>
                    <xsl:when test="@units='percent' and not(parent::elml:box or parent::elml:popup)">
                        <xsl:attribute name="style:rel-width">
                            <xsl:value-of select="@width"/>
                            <xsl:text>%</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="style:width">
                            <xsl:value-of select="16.99 * ((@width) div 100)"/>
                            <xsl:text>cm</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="fo:margin-right">
                            <xsl:value-of select="(17 - (16.99 * ((@width) div 100))) div 2"/>
                            <xsl:value-of>
                                <xsl:text>cm</xsl:text>
                            </xsl:value-of>
                        </xsl:attribute>
                        <xsl:attribute name="fo:margin-left">
                            <xsl:value-of select="(17 - (16.99 * ((@width) div 100))) div 2"/>
                            <xsl:text>cm</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="@units='pixels' and not(parent::elml:box or parent::elml:popup)">
                        <xsl:attribute name="style:width">
                            <xsl:value-of select="(@width) * $converter_pixel_cm"/>
                            <xsl:text>cm</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="table:align">
                            <xsl:value-of>margins</xsl:value-of>
                        </xsl:attribute>
                        <xsl:attribute name="fo:margin-right">
                            <xsl:value-of select="(16.99 - ((@width) * $converter_pixel_cm) )div 2"/>
                            <xsl:value-of>
                                <xsl:text>cm</xsl:text>
                            </xsl:value-of>
                        </xsl:attribute>
                        <xsl:attribute name="fo:margin-left">
                            <xsl:value-of select="(16.99 - ((@width) * $converter_pixel_cm) )div 2"/>
                            <xsl:text>cm</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="style:rel-width">
                            <xsl:value-of/>
                            <xsl:text>100%</xsl:text>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="name()='columnLeft' or name()='columnMiddle' or name()='columnRight'">
                <xsl:attribute name="style:rel-width">
                    <!-- <xsl:choose>
                       <xsl:when test="not(@width) and (following-sibling::elml:columnMiddle or name()='columnMiddle' or preceding-sibling::elml:columnMiddle)"></xsl:when>
                        <xsl:when test="not(@width) and not(following-sibling::elml:columnMiddle or name()='columnMiddle' or preceding-sibling::elml:columnMiddle)"></xsl:when>
                        <xsl:otherwise> -->
                    <xsl:choose>
                        <xsl:when test="@width">
                            <xsl:value-of select="@width"/>
                            <xsl:value-of>
                                <xsl:text>*</xsl:text>
                            </xsl:value-of>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of>
                                <xsl:text>50*</xsl:text>
                            </xsl:value-of>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- height -->
    <xsl:template name="elml:Height">
        <xsl:choose>
            <xsl:when test="name()='multimedia'">
                <xsl:choose>
                    <xsl:when test="@height">
                        <xsl:attribute name="svg:height">
                            <xsl:choose>
                                <xsl:when test="@units='percent'">
                                    <xsl:value-of select="@height"/>
                                    <xsl:text>%</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="(@height) * $converter_pixel_cm"/>
                                    <xsl:text>cm</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="not(@height) and @width ">
                        <xsl:attribute name="svg:height">
                            <xsl:choose>
                                <xsl:when test="@units='percent'">
                                    <xsl:value-of select="@width"/>
                                    <xsl:text>%</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="(@width) * $converter_pixel_cm"/>
                                    <xsl:text>cm</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:when>
            <!-- height for rows in tables-->
            <xsl:when test="name()='tabledata'">
                <xsl:choose>
                    <xsl:when test="@units='percent' and not(parent::elml:box or parent::elml:popup)">
                        <xsl:attribute name="style:rel-width">
                            <xsl:value-of select="@width"/>
                            <xsl:text>%</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="style:width">
                            <xsl:value-of select="16.99 * ((@width) div 100)"/>
                            <xsl:text>cm</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="fo:margin-right">
                            <xsl:value-of select="(17 - (16.99 * ((@width) div 100))) div 2"/>
                            <xsl:value-of>
                                <xsl:text>cm</xsl:text>
                            </xsl:value-of>
                        </xsl:attribute>
                        <xsl:attribute name="fo:margin-left">
                            <xsl:value-of select="(17 - (16.99 * ((@width) div 100))) div 2"/>
                            <xsl:text>cm</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="@units='pixels' and not(parent::elml:box or parent::elml:popup)">
                        <xsl:attribute name="style:width">
                            <xsl:value-of select="(@width) * $converter_pixel_cm"/>
                            <xsl:text>cm</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="table:align">
                            <xsl:value-of>margins</xsl:value-of>
                        </xsl:attribute>
                        <xsl:attribute name="fo:margin-right">
                            <xsl:value-of select="(16.99 - ((@width) * $converter_pixel_cm) )div 2"/>
                            <xsl:value-of>
                                <xsl:text>cm</xsl:text>
                            </xsl:value-of>
                        </xsl:attribute>
                        <xsl:attribute name="fo:margin-left">
                            <xsl:value-of select="(16.99 - ((@width) * $converter_pixel_cm) )div 2"/>
                            <xsl:text>cm</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="style:rel-width">
                            <xsl:value-of/>
                            <xsl:text>100%</xsl:text>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- valign for tabledata -->
    <xsl:template name="valign_for_tabledata">
        <xsl:param name="valign">
            <!-- <xsl:choose>
                <xsl:when test="@align">
                    <xsl:value-of select="@align"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of>center</xsl:value-of>
                </xsl:otherwise>
            </xsl:choose> -->
        </xsl:param>
        <xsl:choose>
            <xsl:when test="@valign">
                <xsl:attribute name="table:style-name">
                    <xsl:value-of select="concat('Cell_',$valign)"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="table:style-name">
                    <xsl:value-of select="concat('Cell_','center')"/>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- align for tabledata -->
    <xsl:template name="align_for_table">
        <xsl:param name="align">
            <xsl:choose>
                <xsl:when test="@align">
                    <xsl:value-of select="@align"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of>left</xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="@align">
                <xsl:attribute name="text:style-name">
                    <xsl:value-of select="concat('cell_',$align)"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="text:style-name">
                    <xsl:value-of select="concat('cell_', 'left')"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Label -->
    <!-- <xsl:template name="elml:Label">
        <xsl:if test="@label or name(.)='entry' or name(.)='goals' or name(.)='summary' or name(.)='furtherReading' or name(.)='learningObject' or name(.)='selfAssessment' or name(.)='bibliography' or name(.)='glossary' or name(.)='listOfFigures' or name(.)='listOfTables' or name(.)='index' or name(.)='metadata' or name(.)='clarify' or name(.)='look' or name(.)='act' or name(.)='table' or name(.)='multimedia'">
            <xsl:element name="text:bookmark">
                <xsl:attribute name="text:name">
                    <xsl:call-template name="elml:Label_param"/>
                </xsl:attribute>
            </xsl:element>
        </xsl:if>
    </xsl:template> -->
    <xsl:template name="elml:Label">
        <xsl:if test="@label">
            <xsl:element name="text:bookmark">
                <xsl:attribute name="text:name">
                    <xsl:value-of select="/elml:lesson/@label"/>
                    <xsl:text>_</xsl:text>
                    <xsl:value-of select="@label"/>
                </xsl:attribute>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <!-- elml:Label_param-->
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
    <!-- columncreate -->
    <xsl:template name="elml:columncreate">
        <xsl:param name="style"/>
        <xsl:param name="columnamount"/>
        <xsl:param name="Width_averages"/>
        <xsl:param name="Width_average"/>
        <xsl:param name="Width_average_is_the_empty_string"/>
        <xsl:param name="unit_Width_averages"/>
        <xsl:param name="unit_Width_average"/>
        <xsl:param name="unit_Width_average_is_the_empty_string"/>
        <table:table-column>
            <xsl:if test="$Width_average_is_the_empty_string='no'">
                <xsl:attribute name="table:style-name">Column</xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="not($style='')">
                    <xsl:attribute name="table:style-name">
                        <xsl:value-of select="$style"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise> </xsl:otherwise>
            </xsl:choose>
            <!--xsl:choose>
                <xsl:when test="@width">
                <xsl:attribute name="column-width">
                <xsl:choose>
                <xsl:when test="@units='percent'">
                <xsl:text>proportional-column-width(</xsl:text>
                <xsl:value-of select="@width"/>
                <xsl:text>)</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                <xsl:value-of select="(@width) * $converter_pixel_mm"/>
                <xsl:text>mm</xsl:text>
                </xsl:otherwise>
                </xsl:choose>
                </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                <xsl:attribute name="column-width">
                <xsl:text>proportional-column-width(1)</xsl:text>
                </xsl:attribute>
                </xsl:otherwise>
                </xsl:choose-->
        </table:table-column>
        <xsl:if test="not($columnamount=1)">
            <xsl:call-template name="elml:columncreate">
                <xsl:with-param name="columnamount" select="$columnamount - 1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <!-- elml:generate_Title_span -->
    <xsl:template name="elml:generate_Title_span">
        <xsl:param name="factor">
            <xsl:choose>
                <xsl:when test="name()='lesson'">
                    <xsl:text>1</xsl:text>
                </xsl:when>
                <xsl:when test="name()='unit' or name()='glossary' or name()='index' or name()='bibliography' or name()='metadata' ">
                    <xsl:text>2</xsl:text>
                </xsl:when>
                <xsl:when test="name()='learningObject'">
                    <xsl:text>3</xsl:text>
                </xsl:when>
                <xsl:when test="name()='clarify' or name()='look' or name()='act'">
                    <xsl:text>4</xsl:text>
                </xsl:when>
                <xsl:when test="name()='entry' or name()='goals' or name()='summary' or name()='selfAssessment' or name()='furtherReading'">
                    <xsl:choose>
                        <xsl:when test="name(parent::*)='lesson'">
                            <xsl:text>2</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>3</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>5</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <text:span text:style-name="bold">
            <xsl:choose>
                <xsl:when test="$pagebreak_level='lo' and $factor&lt;3.1 and not(name()='entry' or name()='goals')">
                    <xsl:attribute name="text:style-name">pagebreak_20_3</xsl:attribute>
                </xsl:when>
                <xsl:when test="$pagebreak_level='unit' and $factor&lt;2.1 and not(name()='entry' or name()='goals')">
                    <xsl:attribute name="text:style-name">pagebreak_20_2</xsl:attribute>
                </xsl:when>
                <xsl:when test="$pagebreak_level='lesson' and $factor&lt;1.1 and not(name()='entry' or name()='goals')">
                    <xsl:attribute name="text:style-name">pagebreak_20_1</xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:call-template name="elml:Label"/>
            <xsl:call-template name="elml:Kapitel"/>
        </text:span>
    </xsl:template>
    <!-- elml:generate_Title_Heading -->
    <xsl:template name="elml:generate_Title_Heading">
        <xsl:param name="factor">
            <xsl:choose>
                <xsl:when test="name()='lesson'">
                    <xsl:text>1</xsl:text>
                </xsl:when>
                <xsl:when test="name()='unit' or name()='glossary' or name()='index' or name()='bibliography' or name()='metadata' ">
                    <xsl:text>2</xsl:text>
                </xsl:when>
                <xsl:when test="name()='learningObject'">
                    <xsl:text>3</xsl:text>
                </xsl:when>
                <xsl:when test="name()='clarify' or name()='look' or name()='act'">
                    <xsl:text>4</xsl:text>
                </xsl:when>
                <xsl:when test="name()='entry' or name()='goals' or name()='summary' or name()='selfAssessment' or name()='furtherReading'">
                    <xsl:choose>
                        <xsl:when test="name(parent::*)='lesson'">
                            <xsl:text>2</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>3</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>5</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <text:h text:outline-level="{$factor}">
            <xsl:attribute name="text:style-name">
                <xsl:value-of>Heading_20_</xsl:value-of>
                <xsl:value-of select="$factor"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="$pagebreak_level='lo' and $factor&lt;3.1 and not(name()='entry' or name()='goals')">
                    <xsl:attribute name="text:style-name">pagebreak_20_<xsl:value-of select="$factor"/></xsl:attribute>
                </xsl:when>
                <xsl:when test="$pagebreak_level='unit' and $factor&lt;2.1 and not(name()='entry' or name()='goals')">
                    <xsl:attribute name="text:style-name">pagebreak_20_<xsl:value-of select="$factor"/></xsl:attribute>
                </xsl:when>
                <xsl:when test="$pagebreak_level='lesson' and $factor&lt;1.1 and not(name()='entry' or name()='goals')">
                    <xsl:attribute name="text:style-name">pagebreak_20_<xsl:value-of select="$factor"/></xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:call-template name="elml:Label"/>
            <xsl:call-template name="elml:Kapitel"/>
        </text:h>
    </xsl:template>
    <!-- elml:Kapitel -->
    <xsl:template name="elml:Kapitel">
        <xsl:param name="isnavigation"/>
        <xsl:param name="actual_lesson">
            <xsl:value-of select="/elml:lesson/@label"/>
        </xsl:param>
        <xsl:if test="($chapter_numeration='yes') and not($isnavigation='path_full') and (not(name(.)='goals')) and (not(name(.)='clarify')) and (not(name(.)='look')) and (not(name(.)='act')) and (not(name(.)='entry')) and not(name(.)='paragraph') and not(name(.)='list') and not(name(.)='multimedia')">
            <xsl:choose>
                <xsl:when test="$multiple='on'">
                    <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                        <xsl:if test="text()=$actual_lesson">
                            <xsl:value-of select="position()"/>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:text>.</xsl:text>
                    <xsl:number level="multiple" count="elml:unit[(@role eq 'student') or (@role eq $role) or (not (@role))] | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary[not(@visible='print') and not(@visible='none')] | elml:listoffigures[not(@visible='print') and not(@visible='none')] | elml:listoftables[not(@visible='print') and not(@visible='none')] | elml:index[not(@visible='print') and not(@visible='none')] | elml:bibliography[not(@visible='print') and not(@visible='none')] | elml:metadata[not(@visible='print') and not(@visible='none')] | elml:learningObject"/>
                    <xsl:if test="name()='entry'">
                        <xsl:text>.0</xsl:text>
                    </xsl:if>
                    <xsl:text> </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:number level="multiple" count="elml:lesson | elml:unit[(@role eq 'student') or (@role eq $role) or (not (@role))] | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary[not(@visible='print') and not(@visible='none')] | elml:listoffigures[not(@visible='print') and not(@visible='none')] | elml:listoftables[not(@visible='print') and not(@visible='none')] | elml:index[not(@visible='print') and not(@visible='none')] | elml:bibliography[not(@visible='print') and not(@visible='none')] | elml:metadata[not(@visible='print') and not(@visible='none')] | elml:learningObject"/>
                    <xsl:if test="name()='entry'">
                        <xsl:text>.0</xsl:text>
                    </xsl:if>
                    <xsl:text>. </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if test="name(.)='paragraph' and $paragraph_titles_numbered='true'">
            <xsl:choose>
                <xsl:when test="$multiple='on'">
                    <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                        <xsl:if test="text()=$actual_lesson">
                            <xsl:value-of select="position()"/>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:text>.</xsl:text>
                    <xsl:number level="multiple" count="elml:unit[(@role eq 'student') or (@role eq $role) or (not (@role))] | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary[not(@visible='print') and not(@visible='none')] | elml:listoffigures[not(@visible='print') and not(@visible='none')] | elml:listoftables[not(@visible='print') and not(@visible='none')] | elml:index[not(@visible='print') and not(@visible='none')] | elml:bibliography[not(@visible='print') and not(@visible='none')] | elml:metadata[not(@visible='print') and not(@visible='none')] | elml:learningObject"/>
                    <xsl:if test="name()='entry'">
                        <xsl:text>.0</xsl:text>
                    </xsl:if>
                    <xsl:text> </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:number level="multiple" count="elml:lesson | elml:unit[(@role eq 'student') or (@role eq $role) or (not (@role))] | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary[not(@visible='print') and not(@visible='none')] | elml:listoffigures[not(@visible='print') and not(@visible='none')] | elml:listoftables[not(@visible='print') and not(@visible='none')] | elml:index[not(@visible='print') and not(@visible='none')] | elml:bibliography[not(@visible='print') and not(@visible='none')] | elml:metadata[not(@visible='print') and not(@visible='none')] | elml:learningObject"/>
                    <xsl:if test="name()='entry'">
                        <xsl:text>.0</xsl:text>
                    </xsl:if>
                    <xsl:text>. </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
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
            <xsl:when test="name()='listoffigures'">
                <xsl:value-of select="$name_figures"/>
            </xsl:when>
            <xsl:when test="name()='listoftables'">
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
    <!-- Functions -->
    <!-- Last Index of -->
    <!-- reverse part 1 -->
    <xsl:template name="reverse">
        <xsl:param name="string"/>
        <xsl:value-of select="substring($string, string-length($string))"/>
        <xsl:if test="string-length($string) > 1">
            <xsl:call-template name="reverse">
                <xsl:with-param name="string" select="substring($string, 1, (string-length($string)-1))"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <!-- reverse part 2 -->
    <xsl:template name="rindex">
        <xsl:param name="string"/>
        <xsl:param name="substring"/>
        <xsl:choose>
            <xsl:when test="contains($string,$substring)">
                <xsl:variable name="rstring">
                    <xsl:call-template name="reverse">
                        <xsl:with-param name="string" select="$string"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="rsubstring">
                    <xsl:call-template name="reverse">
                        <xsl:with-param name="string" select="$substring"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:value-of select="string-length($string) -
                    (string-length(substring-before($rstring,$rsubstring)) +
                    string-length($rsubstring)) + 1"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="0"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- reverse part 3 -->
    <xsl:template name="lastindexofstring">
        <xsl:call-template name="rindex">
            <xsl:with-param name="string" select="@src"/>
            <xsl:with-param name="substring" select="'/'"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="elml:generate_Head">
        <xsl:for-each select="//elml:column">
            <xsl:choose>
                <xsl:when test="not(child::elml:columnMiddle)">
                    <style:style style:name="columntwo" style:family="section">
                        <xsl:attribute name="style:name">
                            <xsl:value-of>column</xsl:value-of>
                            <xsl:value-of select="string-length()"/>
                            <xsl:value-of>o_</xsl:value-of>
                            <xsl:value-of select="count(descendant-or-self::node())"/>
                            <xsl:value-of select="@label"/>
                        </xsl:attribute>
                        <style:section-properties text:dont-balance-text-columns="true" style:editable="true">
                            <style:columns fo:column-count="2">
                                <xsl:for-each select="elml:columnLeft">
                                    <style:column fo:start-indent="0.5cm" fo:end-indent="0cm">
                                        <xsl:call-template name="elml:Width"/>
                                    </style:column>
                                </xsl:for-each>
                                <xsl:for-each select="elml:columnRight">
                                    <style:column fo:start-indent="0.5cm" fo:end-indent="0.5cm">
                                        <xsl:call-template name="elml:Width"/>
                                    </style:column>
                                </xsl:for-each>
                            </style:columns>
                        </style:section-properties>
                    </style:style>
                </xsl:when>
                <xsl:otherwise>
                    <style:style style:name="columnthree" style:family="section">
                        <xsl:attribute name="style:name">
                            <xsl:value-of>column</xsl:value-of>
                            <xsl:value-of select="string-length()"/>
                            <xsl:value-of>m_</xsl:value-of>
                            <xsl:value-of select="count(descendant-or-self::node())"/>
                            <xsl:value-of select="@label"/>
                        </xsl:attribute>
                        <style:section-properties text:dont-balance-text-columns="true" style:editable="true">
                            <style:columns fo:column-count="3">
                                <xsl:for-each select="elml:columnLeft">
                                    <style:column fo:start-indent="0cm" fo:end-indent="0cm">
                                        <xsl:call-template name="elml:Width"/>
                                    </style:column>
                                </xsl:for-each>
                                <xsl:for-each select="elml:columnMiddle">
                                    <style:column fo:start-indent="0cm" fo:end-indent="0cm">
                                        <xsl:call-template name="elml:Width"/>
                                    </style:column>
                                </xsl:for-each>
                                <xsl:for-each select="elml:columnRight">
                                    <style:column fo:start-indent="0cm" fo:end-indent="0cm">
                                        <xsl:call-template name="elml:Width"/>
                                    </style:column>
                                </xsl:for-each>
                            </style:columns>
                        </style:section-properties>
                    </style:style>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <!-- style for tablewith-->
        <xsl:for-each select="//elml:table">
            <style:style style:family="table">
                <xsl:attribute name="style:name">
                    <xsl:value-of>table</xsl:value-of>
                    <xsl:value-of select="string-length()"/>
                </xsl:attribute>
                <style:table-properties table:align="margins">
                    <xsl:call-template name="elml:Width"/>
                </style:table-properties>
            </style:style>
        </xsl:for-each>
        <!-- Caption Styles for Multimedia images-->
        <xsl:for-each select="//elml:multimedia[@legend]">
            <style:style style:family="text" style:parent-style-name="Caption" style:class="extra">
                <xsl:attribute name="style:name">
                    <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                </xsl:attribute>
            </style:style>
        </xsl:for-each>
        <xsl:for-each select="//elml:multimedia[@legend]">
            <style:style style:family="paragraph" style:parent-style-name="Caption" style:class="extra">
                <xsl:attribute name="style:name">
                    <xsl:value-of select="translate(@legend,' ?!.,:;-/''()+@¦#°§¬|¢´~[]ö{}.-\>*ç%`=','_' )"/>
                </xsl:attribute>
            </style:style>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="node-identifier">
        <xsl:param name="id-node" select="self::*"/>
        <xsl:value-of select="generate-id($id-node)"/>
    </xsl:template>
    <xsl:template name="project_styles"/>
    <xsl:param name="converter_pixel_cm">
        <xsl:choose>
            <xsl:when test="document($config_file)/elml:config/elml:print/elml:converter_pixel_mm">
                <xsl:value-of select="concat('0.0',substring-after(document($config_file)/elml:config/elml:print/elml:converter_pixel_mm,'.'))"/>
            </xsl:when>
            <xsl:when test="document($config_file)/config/print/converter_pixel_mm">
                <xsl:value-of select="concat('0.0',substring-after(document($config_file)/config/print/converter_pixel_mm,'.'))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('0.0',substring-after(document($config_file_default)/elml:config/elml:print/elml:converter_pixel_mm,'.'))"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="default_text-align">left</xsl:param>
    <xsl:param name="default_paragraph_orphans">3</xsl:param>
    <xsl:param name="Heading1">20pt</xsl:param>
    <xsl:param name="Heading2">15pt</xsl:param>
    <xsl:param name="Heading3">13pt</xsl:param>
    <xsl:param name="Heading4">12pt</xsl:param>
    <xsl:param name="Heading5">12pt</xsl:param>
    <xsl:param name="Heading1_margin_top">0.843cm</xsl:param>
    <xsl:param name="Heading2_margin_top">0.843cm</xsl:param>
    <xsl:param name="Heading3_margin_top">0.843cm</xsl:param>
    <xsl:param name="Heading4_margin_top">0.843cm</xsl:param>
    <xsl:param name="Heading5_margin_top">0.843cm</xsl:param>
    <xsl:param name="Heading1_margin_bottom">0.212cm</xsl:param>
    <xsl:param name="Heading2_margin_bottom">0.212cm</xsl:param>
    <xsl:param name="Heading3_margin_bottom">0.212cm</xsl:param>
    <xsl:param name="Heading4_margin_bottom">0.212cm</xsl:param>
    <xsl:param name="Heading5_margin_bottom">0.212cm</xsl:param>
    <xsl:param name="paragraph_titles_numbered">true</xsl:param>
    <xsl:param name="enable_project_styles">no</xsl:param>
</xsl:stylesheet>
