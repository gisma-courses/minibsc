<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:elml="http://www.elml.ch" version="2.0">
<xsl:import href="../../../core/presentation/online/elml.xsl">
</xsl:import><xsl:param name="layout" select="'3rd'">
</xsl:param><xsl:param name="chapter_numeration" select="'no'">
</xsl:param><xsl:param name="pagebreak_level" select="'lo'">
</xsl:param><xsl:param name="css_framework" select="'yaml'">
</xsl:param><xsl:template name="elml:LayoutBody">
<body>
<div id="page_margins">
<div id="page">
<div id="header">
<div id="hcol1_2C">
<div id="hcol1_2Cc">
<div id="im_stones3_1">
<img height="100%" width="100%" src="../images/stones3.jpg">
</img></div></div></div><div id="hcol2_2C">
<div id="hcol2_2Cc">
<div id="im_emo_">
<img height="100%" width="100%" src="file:///D:/lehre/elearning_l3/GISBSc/builder/_templates/gisbsc/images/emo.jpeg">
</img></div></div></div></div><div id="main">
<div id="col1">
<div id="col1_content" class="nav">
<div id="im_baenke">
<img height="100%" width="100%" src="file:///D:/lehre/elearning_l3/GISBSc/builder/_templates/gisbsc/images/b%C3%A4nke.jpg">
</img></div><xsl:call-template name="elml:navigation">
</xsl:call-template></div></div><div id="col3">
<div id="col3_content">
 <xsl:call-template name="elml:LayoutBodyContent">
</xsl:call-template></div></div></div><div id="footer">
<div id="fcol_alone">
<div id="fcol1_content">
<div id="im_mandala">
<img height="100%" width="100%" src="../images/mandala.jpg">
</img></div></div></div></div></div></div></body></xsl:template></xsl:stylesheet>