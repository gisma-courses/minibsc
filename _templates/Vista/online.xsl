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
    <a accesskey="2" href="#content" title="Zum Inhalt springen"> &#xE001;<![CDATA[!----]]>&#xE002; </a>
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




      </div>

      <h1>
       <xsl:value-of select="/elml:lesson/@title"/>
      </h1>
     </div>
    </div>

    <div class="floatclear"> &#xE001;<![CDATA[!----]]>&#xE002; </div>
    <div id="breadcrumbnav">
     <xsl:call-template name="elml:path_full"/>
    </div>
    <div class="floatclear"> &#xE001;<![CDATA[!----]]>&#xE002; </div>
    <div class="endheaderline">
     <img alt="separation line" height="1" src="../../../_templates/gisma/authoring/images/1.gif"
      width="1"/>
    </div>
    <div id="toolnav">

     <xsl:if test="not(contains($prev,'none'))">

      <a href="{$prev}">
       <img src="../../../_templates/{$layout}/images/arrow_left.gif" height="13" width="9"
        alt="Go to previous page" border="0"/> zurück </a>

     </xsl:if>
     <xsl:if test="not(contains($next,'none'))">

      <a href="{$next}">
       <img src="../../../_templates/{$layout}/images/arrow_right.gif" height="13" width="9"
        alt="Go to next page" border="0"/> vor </a>

     </xsl:if>
    </div>
    <div class="floatclear"> &#xE001;<![CDATA[!----]]>&#xE002; </div>

    <div id="col1">
     <div id="secnav">
      <xsl:call-template name="elml:navigation"/> &#xE001;<![CDATA[!----]]>&#xE002; </div>

    </div>



    <div class="contcol2">
     <a accesskey="2" class="namedanchor" name="content"> &#xE001;<![CDATA[!----]]>&#xE002; </a>

     <div class="content">
      <xsl:call-template name="elml:LayoutBodyContent"/>
     </div>
     <div id="toolnav">


      <xsl:if test="not(contains($prev,'none'))">

       <a href="{$prev}">
        <img src="../../../_templates/{$layout}/images/arrow_left.gif" height="13" width="9"
         alt="Go to previous page" border="0"/> zurück </a>

       <xsl:if test="not(contains($next,'none'))">

        <a href="{$next}">
         <img src="../../../_templates/{$layout}/images/arrow_right.gif" height="13" width="9"
          alt="Go to next page" border="0"/> vor </a>

       </xsl:if>


      </xsl:if>
      <a href="#top">
       <img src="../../../_templates/{$layout}/images/arrow_weiss.gif" height="13" width="9"
        border="0"/>
       <img src="../../../_templates/{$layout}/images/arrow_up.gif" height="13" width="9"
        alt="Go to next page" border="0"/> top </a>
     </div>
     <div class="footermargintop"> &#xE001;<![CDATA[!----]]>&#xE002; </div>


     <div class="solidline">
      <img alt="separation line" height="1" src="../../../_templates/gisma/authoring/images/1.gif"
       width="1"/>
     </div>
     <div id="footer">
      <xsl:call-template name="elml:footer_gitta"/>
     </div>
    </div>
   </div>
  </body>
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
     src="../../../_templates/gisma/icons/creativecommons.png" height="18" width="40" align="bottom"
    />
   </a> - <a>
    <xsl:attribute name="href">
     <xsl:text>mailto:</xsl:text>
     <xsl:value-of select="$contact"/>
    </xsl:attribute>
    <xsl:value-of select="$name_contact"/>
   </a>
  </p>

 </xsl:template>

</xsl:stylesheet>
