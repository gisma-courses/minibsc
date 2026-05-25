<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" xmlns:xhtml="http://www.w3.org/1999/xhtml" version="2.0" xmlns:functx="http://www.functx.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0">
    <xsl:template name="directory_pictures">
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}Pictures/default.txt">
            <xsl:text>default</xsl:text>
        </xsl:result-document>
    </xsl:template>
    
     <xsl:template name="directory_configurations">
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}Configurations2/default">
            <xsl:text>application/vnd.sun.xml.ui.configuration</xsl:text>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="document_manifest">
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}META-INF/manifest.xml">
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
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}mimetype">
            <xsl:text>application/vnd.oasis.opendocument.text</xsl:text>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="document_meta">
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}meta.xml">
            <office:document-meta xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:ooo="http://openoffice.org/2004/office" office:version="1.0"><!-- not meta content defined yet --></office:document-meta>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="document_settings">
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}settings.xml">
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
        <xsl:result-document href="{elml:get_pathODF(base-uri(),/elml:lesson/@label)}styles.xml">
            <office:document-styles xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0" xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0" xmlns:ooo="http://openoffice.org/2004/office" xmlns:ooow="http://openoffice.org/2004/writer" xmlns:oooc="http://openoffice.org/2004/calc" xmlns:dom="http://www.w3.org/2001/xml-events" office:version="1.0">
                <office:font-face-decls>
                    <style:font-face style:name="Tahoma1" svg:font-family="Tahoma"/>
                    <style:font-face style:name="Thorndale AMT" svg:font-family="&apos;Thorndale AMT&apos;" style:font-family-generic="roman" style:font-pitch="variable"/>
                    <style:font-face style:name="Albany AMT" svg:font-family="&apos;Albany AMT&apos;" style:font-family-generic="swiss" style:font-pitch="variable"/>
                    <style:font-face style:name="Arial Unicode MS" svg:font-family="&apos;Arial Unicode MS&apos;" style:font-family-generic="system" style:font-pitch="variable"/>
                    <style:font-face style:name="MS Mincho" svg:font-family="&apos;MS Mincho&apos;" style:font-family-generic="system" style:font-pitch="variable"/>
                    <style:font-face style:name="Tahoma" svg:font-family="Tahoma" style:font-family-generic="system" style:font-pitch="variable"/>
                    <style:font-face style:name="Cumberland AMT" svg:font-family="&apos;Cumberland AMT&apos;" style:font-family-generic="modern" style:font-pitch="fixed"/>
                </office:font-face-decls>
                <office:styles>
                    <style:default-style style:family="graphic">
                        <style:graphic-properties draw:shadow-offset-x="0.3cm" draw:shadow-offset-y="0.3cm" draw:start-line-spacing-horizontal="0.283cm" draw:start-line-spacing-vertical="0.283cm" draw:end-line-spacing-horizontal="0.283cm" draw:end-line-spacing-vertical="0.283cm" style:flow-with-text="false"/>
                        <style:paragraph-properties style:text-autospace="ideograph-alpha" style:line-break="strict" style:writing-mode="lr-tb" style:font-independent-line-spacing="false">
                            <style:tab-stops/>
                        </style:paragraph-properties>
                        <!-- set here the standard language-->
                        <style:text-properties style:use-window-font-color="true" fo:font-size="12pt" fo:language="{$lang}" fo:country="{$lang}" style:font-size-asian="10.5pt" style:language-asian="zxx" style:country-asian="none" style:font-size-complex="12pt" style:language-complex="zxx" style:country-complex="none"/>
                    </style:default-style>
                    <style:default-style style:family="paragraph">
                        <style:paragraph-properties fo:hyphenation-ladder-count="no-limit" style:text-autospace="ideograph-alpha" style:punctuation-wrap="hanging" style:line-break="strict" style:tab-stop-distance="1.251cm" style:writing-mode="page"/>
                        <!-- set here the standard font-->
                        <style:text-properties style:use-window-font-color="true" style:font-name="Thorndale AMT" fo:font-size="12pt" fo:language="{$lang}" fo:country="{$lang}" style:font-name-asian="Arial Unicode MS" style:font-size-asian="10.5pt" style:language-asian="zxx" style:country-asian="none" style:font-name-complex="Tahoma" style:font-size-complex="12pt" style:language-complex="zxx" style:country-complex="none" fo:hyphenate="false" fo:hyphenation-remain-char-count="2" fo:hyphenation-push-char-count="2"/>
                    </style:default-style>
                    <style:default-style style:family="table">
                        <style:table-properties table:border-model="collapsing"/>
                    </style:default-style>
                    <style:default-style style:family="table-row">
                        <style:table-row-properties fo:keep-together="auto"/>
                    </style:default-style>
                    <!-- set here the styles for paragraphs, characters, etc.. -->
                    <style:style style:name="Table 1" style:family="table">
                        <style:table-properties style:width="12cm" fo:background-color="light-grey"/>
                    </style:style>
                    <style:style style:name="Col1" style:family="table-column">
                        <style:table-column-properties style:column-width="2cm"/>
                    </style:style>
                    <style:style style:name="Col2" style:family="table-column">
                        <style:table-column-properties style:column-width="4cm"/>
                    </style:style>
                    <style:style style:name="Col3" style:family="table-column">
                        <style:table-column-properties style:column-width="6cm"/>
                    </style:style>
                    <style:style style:name="Row1" style:family="table-row">
                        <style:table-row-properties fo:background-color="grey"/>
                    </style:style>
                    <style:style style:name="Cell1" style:family="table-cell">
                        <style:table-cell-properties fo:background-color="grey"/>
                    </style:style>
                    <style:style style:name="Text_20_body" style:display-name="Text body" style:family="paragraph" style:parent-style-name="Standard" style:class="text">
                        <style:paragraph-properties fo:margin-top="0cm" fo:margin-bottom="0.212cm"/>
                    </style:style>
                    <!-- BEGINN OPTION FOR THE NEWLINE ELEMENT - NOT WORKING AT THE MOMENT -->
                    <style:style style:name="Standard" style:family="paragraph" style:class="text">
                        <style:paragraph-properties fo:line-height="100%" fo:margin-top="0.15cm" fo:margin-bottom="0.15cm"/>
                    </style:style>
                    <style:style style:name="Standard continue with new line" style:family="paragraph" style:next-style-name="Newline" style:class="text">
                        <style:paragraph-properties fo:line-height="100%" fo:margin-top="0.15cm" fo:margin-bottom="0cm"/>
                    </style:style>
                    
                    <style:style style:name="Newline" style:family="paragraph" style:next-style-name="Standard" style:class="text">
                        <style:paragraph-properties fo:line-height="100%" fo:margin-top="0cm" fo:margin-bottom="0.15cm"/>
                    </style:style>
                    <!-- END OPTION FOR THE NEWLINE ELEMENT - NOT WORKING AT THE MOMENT -->
                    <style:style style:name="List" style:family="paragraph" style:parent-style-name="Text_20_body" style:class="list">
                        <style:text-properties style:font-size-asian="12pt" style:font-name-complex="Tahoma1"/>
                    </style:style>
                    <style:style style:name="Caption" style:family="paragraph" style:parent-style-name="Standard" style:class="extra">
                        <style:paragraph-properties fo:margin-top="0.212cm" fo:margin-bottom="0.212cm" text:number-lines="false" text:line-number="0"/>
                        <style:text-properties fo:font-size="12pt" fo:font-style="italic" style:font-size-asian="12pt" style:font-style-asian="italic" style:font-name-complex="Tahoma1" style:font-size-complex="12pt" style:font-style-complex="italic"/>
                    </style:style>
                    <style:style style:name="Index" style:family="paragraph" style:parent-style-name="Standard" style:class="index">
                        <style:paragraph-properties text:number-lines="false" text:line-number="0"/>
                        <style:text-properties style:font-size-asian="12pt" style:font-name-complex="Tahoma1"/>
                    </style:style>
                    <style:style style:name="code" style:display-name="code" style:family="text">
                        <style:text-properties style:font-name="Cumberland AMT" style:font-name-asian="Cumberland AMT" style:font-name-complex="Cumberland AMT"/>
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
                    <style:style style:name="italic" style:display-name="italic" style:family="text">
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
                        <style:page-layout-properties fo:page-width="20.999cm" fo:page-height="29.699cm" style:num-format="1" style:print-orientation="portrait" fo:margin-top="2cm" fo:margin-bottom="2cm" fo:margin-left="2cm" fo:margin-right="2cm" style:writing-mode="lr-tb" style:footnote-max-height="0cm">
                            <style:footnote-sep style:width="0.018cm" style:distance-before-sep="0.101cm" style:distance-after-sep="0.101cm" style:adjustment="left" style:rel-width="25%" style:color="#000000"/>
                        </style:page-layout-properties>
                        <style:header-style/>
                        <style:footer-style/>
                    </style:page-layout>
                </office:automatic-styles>
                <office:master-styles>
                    <style:master-page style:name="Standard" style:page-layout-name="pm1"/>
                </office:master-styles>
            </office:document-styles>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
