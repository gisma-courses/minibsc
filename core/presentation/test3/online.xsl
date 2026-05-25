<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:elml="http://www.elml.ch" version="2.0">
<xsl:import href="../../../core/presentation/online/elml.xsl">
</xsl:import><xsl:param name="layout" select="'test3'">
</xsl:param><xsl:param name="chapter_numeration" select="'no'">
</xsl:param><xsl:param name="pagebreak_level" select="'unit'">
</xsl:param><xsl:param name="css_framework" select="'yaml'">
</xsl:param><xsl:template name="elml:LayoutBody">
<body>
<div id="page_margins">
<div id="page">
<div id="header">
<div id="header_col1">
<div id="hcol1_content">
</div></div><div id="header_col2">
<div id="hcol2_content">
</div></div><div id="header_col3">
<div id="hcol3_content" class="clearfix">
</div></div></div><div id="main">
<div id="col1">
<div id="col1_content" class="nav">
<xsl:call-template name="elml:navigation">
</xsl:call-template></div></div><div id="col3">
<div id="col3_content">
 <xsl:call-template name="elml:LayoutBodyContent">
</xsl:call-template></div></div></div><div id="footer">
<div id="fcol_alone">
<div id="fcol1_content">
</div></div></div></div></div></body></xsl:template></xsl:stylesheet>