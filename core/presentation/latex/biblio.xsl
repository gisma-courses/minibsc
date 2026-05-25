<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2004/07/xpath-functions" xmlns:xdt="http://www.w3.org/2004/07/xpath-datatypes">
	<!-- ******* Bibliography Elements (no style at all since style is defined in LaTeX settings) *********** -->
	<xsl:function name="elml:transform_key">
		<xsl:param name="key" as="xs:string"/>
		<xsl:value-of select="replace(replace(replace(replace(replace($key,'_','x'),'-','x'),'ä','ae'),'ö','oe'),'ü','ue')"/>
	</xsl:function>
	<xsl:template match="elml:book | elml:contributionInBook | elml:journalArticle | elml:newspaperArticle | elml:map | elml:cdRom | elml:personalMail | elml:mailLists | elml:eJournals | elml:websites | elml:videoFilmBroadcast | elml:thesis | elml:patent | elml:conferencePaper | elml:publicationCorporateBody">
		<xsl:param name="comment"/>
		<xsl:param name="bibtex_type">
			<xsl:choose>
				<xsl:when test="name()='publicationCorporateBody' or name()='patent' or name()='videoFilmBroadcast' or name()='websites' or name()='mailLists' or name()='personalMail'">
					<xsl:text>misc</xsl:text>
				</xsl:when>
				<xsl:when test="name()='thesis' and (@designation='thesis' or @designation='Thesis' or @designation='phd' or @designation='PHD' or @designation='PhD' or @designation='doctorate')">
					<xsl:text>phdthesis</xsl:text>
				</xsl:when>
				<xsl:when test="name()='thesis'">
					<xsl:text>masterthesis</xsl:text>
				</xsl:when>
				<xsl:when test="@published='no'">
					<xsl:text>unpublished</xsl:text>
				</xsl:when>
				<xsl:when test="name()='patent'">
					<xsl:text>techreport</xsl:text>
				</xsl:when>
				<xsl:when test="name()='book'">
					<xsl:text>book</xsl:text>
				</xsl:when>
				<xsl:when test="name()='contributionInBook'">
					<xsl:text>inbook</xsl:text>
				</xsl:when>
				<xsl:when test="name()='journalArticle' or name()='newspaperArticle' or name()='eJournals'">
					<xsl:text>article</xsl:text>
				</xsl:when>
				<xsl:when test="name()='map' or name()='cdRom'">
					<xsl:text>manual</xsl:text>
				</xsl:when>
				<xsl:when test="name()='conferencePaper'">
					<xsl:text>inproceedings</xsl:text>
				</xsl:when>
				<xsl:when test="name()='cdRom'">
					<xsl:text>book</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:param>
		<xsl:text>
@</xsl:text>
		<xsl:value-of select="$bibtex_type"/>
		<xsl:text>{</xsl:text>
		<xsl:value-of select="elml:transform_key(@bibID)" disable-output-escaping="yes"/>
		<xsl:text>,
			author = {</xsl:text>
		<xsl:choose>
			<xsl:when test="@author">
				<xsl:value-of select="@author"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$name_anon"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>}, 
			</xsl:text>
		<xsl:if test="@publicationYear">
			<xsl:text>year = {</xsl:text>
			<xsl:value-of select="@publicationYear"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@title">
			<xsl:choose>
				<xsl:when test="name()='contributionInBook'">
					<xsl:text>booktitle = {</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>title = {</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="@title"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@edition">
			<xsl:text>edition = {</xsl:text>
			<xsl:value-of select="@edition"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@publicationPlace">
			<xsl:text>address = {</xsl:text>
			<xsl:value-of select="@publicationPlace"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@publisher">
			<xsl:text>publisher = {</xsl:text>
			<xsl:value-of select="@publisher"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="$comment">
			<xsl:text>annote = {</xsl:text>
			<xsl:value-of select="$comment"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="text()">
			<xsl:text>note = {</xsl:text>
			<xsl:value-of select="text()"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@titleOfContribution">
			<xsl:text>title = {</xsl:text>
			<xsl:value-of select="@titleOfContribution"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@editor">
			<xsl:text>editor = {</xsl:text>
			<xsl:value-of select="@editor"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@pageNr">
			<xsl:text>pages = {</xsl:text>
			<xsl:value-of select="@pageNr"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@journalTitle">
			<xsl:text>journal = {</xsl:text>
			<xsl:value-of select="@journalTitle"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@volumeNr">
			<xsl:text>volume = {</xsl:text>
			<xsl:value-of select="@volumeNr"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@newspaperTitle">
			<xsl:text>journal = {</xsl:text>
			<xsl:value-of select="@newspaperTitle"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@dayMonth">
			<xsl:text>month = {</xsl:text>
			<xsl:value-of select="@dayMonth"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@scale">
			<xsl:text>series = {</xsl:text>
			<xsl:value-of select="@scale"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@proceedingsTitle">
			<xsl:text>booktitle = {</xsl:text>
			<xsl:value-of select="@proceedingsTitle"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@datePlace">
			<xsl:text>month = {</xsl:text>
			<xsl:value-of select="@datePlace"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@reportNr">
			<xsl:text>number = {</xsl:text>
			<xsl:value-of select="@reportNr"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@type">
			<xsl:text>type = {</xsl:text>
			<xsl:value-of select="@type"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@institution">
			<xsl:text>school = {</xsl:text>
			<xsl:value-of select="@institution"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@designation">
			<xsl:text>series = {</xsl:text>
			<xsl:value-of select="@designation"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@productionOrganisation">
			<xsl:text>institution = {</xsl:text>
			<xsl:value-of select="@productionOrganisation"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@productionPlace">
			<xsl:text>address = {</xsl:text>
			<xsl:value-of select="@productionPlace"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@url">
			<xsl:text>howpublished = {\url{</xsl:text>
			<xsl:value-of select="@url"/>
			<xsl:text>}}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@accessedDate">
			<xsl:text>month = {</xsl:text>
			<xsl:value-of select="@accessedDate"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@dayMonthYear">
			<xsl:text>month = {</xsl:text>
			<xsl:value-of select="@dayMonthYear"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@subject">
			<xsl:text>title = {</xsl:text>
			<xsl:value-of select="@subject"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@discussionList">
			<xsl:text>journal = {</xsl:text>
			<xsl:value-of select="@discussionList"/>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@emailSender or @recipient">
			<xsl:text>howpublished = {</xsl:text>
			<xsl:if test="@emailSender">
				<xsl:text>eMail from: </xsl:text>
				<xsl:value-of select="@emailSender"/>
				<xsl:text> </xsl:text>
				<xsl:if test="@recipient">
					<xsl:text> - </xsl:text>
				</xsl:if>
			</xsl:if>
			<xsl:if test="@recipient">
				<xsl:text>eMail recipent: </xsl:text>
				<xsl:value-of select="@recipient"/>
			</xsl:if>
			<xsl:text>}, 
			</xsl:text>
		</xsl:if>
		<xsl:if test="@supplier">
			<xsl:text>howpublished = {</xsl:text>
			<xsl:value-of select="@supplier"/>
			<xsl:text>},
			</xsl:text>
		</xsl:if>
		<xsl:text>key = {</xsl:text>
		<xsl:value-of select="elml:transform_key(@bibID)" disable-output-escaping="yes"/>
		<xsl:text>}
		}
</xsl:text>
	</xsl:template>
</xsl:stylesheet>
