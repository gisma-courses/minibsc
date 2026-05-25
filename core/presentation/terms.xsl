<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
	<xsl:function name="elml:get_term_name">
		<xsl:param name="term_name_key"/>
		<xsl:choose>
			<xsl:when test="document($config_file)/elml:config/elml:terms/elml:msg[(@name=$term_name_key) and (@lang=$lang)]">
				<xsl:value-of select="document($config_file)/elml:config/elml:terms/elml:msg[(@name=$term_name_key) and (@lang=$lang)]"/>
			</xsl:when>
			<xsl:when test="document($config_file)/config/terms/msg[(@name=$term_name_key) and (@lang=$lang)]">
				<xsl:value-of select="document($config_file)/config/terms/msg[(@name=$term_name_key) and (@lang=$lang)]"/>
			</xsl:when>
			<xsl:when test="document($terms_file)/messagebundle/msg[@name=$term_name_key]">
				<xsl:value-of select="document($terms_file)/messagebundle/msg[@name=$term_name_key]"/>
			</xsl:when>
			<xsl:when test="document($terms_file_default)/messagebundle/msg[@name=$term_name_key]">
				<xsl:value-of select="document($terms_file_default)/messagebundle/msg[@name=$term_name_key]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>TERM KEY IS MISSING!</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:param name="country" select="'ALL'"/>
	<xsl:param name="terms_file_default">
		<xsl:choose>
			<xsl:when test="doc-available(concat('terms\terms_',$lang,'_',$country,'.xml'))">
				<xsl:value-of select="concat('terms\terms_',$lang,'_',$country,'.xml')"/>
			</xsl:when>
			<xsl:when test="doc-available(concat('terms/terms_',$lang,'_',$country,'.xml'))">
				<xsl:value-of select="concat('terms/terms_',$lang,'_',$country,'.xml')"/>
			</xsl:when>
			<xsl:when test="contains(base-uri(), '\')">
				<xsl:value-of select="concat('terms\terms_en_',$country,'.xml')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat('terms/terms_en_',$country,'.xml')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="terms_file">
		<xsl:choose>
			<xsl:when test="doc-available(concat(substring-before(base-uri(), concat('/', /elml:lesson/@label)),'/../core/presentation/terms/terms_',$lang,'_',$country,'.xml'))">
				<xsl:value-of select="concat(substring-before(base-uri(), concat('/', /elml:lesson/@label)),'/../core/presentation/terms/terms_',$lang,'_',$country,'.xml')"/>
			</xsl:when>
			<xsl:when test="doc-available(concat(substring-before(base-uri(), concat('\', /elml:lesson/@label)),'\..\core\presentation\terms\terms_',$lang,'_',$country,'.xml'))">
				<xsl:value-of select="concat(substring-before(base-uri(), concat('\', /elml:lesson/@label)),'\..\core\presentation\terms\terms_',$lang,'_',$country,'.xml')"/>
			</xsl:when>
		</xsl:choose>
	</xsl:param>
	<xsl:variable name="name_content" select="elml:get_term_name('name_content')"/>
	<xsl:variable name="name_entry" select="elml:get_term_name('name_entry')"/>
	<xsl:variable name="name_lObjectives" select="elml:get_term_name('name_lObjectives')"/>
	<xsl:variable name="name_glossary" select="elml:get_term_name('name_glossary')"/>
	<xsl:variable name="name_glossary_empty" select="elml:get_term_name('name_glossary_empty')"/>
	<xsl:variable name="name_keywords" select="elml:get_term_name('name_keywords')"/>
	<xsl:variable name="name_summary" select="elml:get_term_name('name_summary')"/>
	<xsl:variable name="name_selfAssessment" select="elml:get_term_name('name_selfAssessment')"/>
	<xsl:variable name="name_furtherReading" select="elml:get_term_name('name_furtherReading')"/>
	<xsl:variable name="name_bibliography" select="elml:get_term_name('name_bibliography')"/>
	<xsl:variable name="name_bibliography_empty" select="elml:get_term_name('name_glossary_empty')"/>
	<xsl:variable name="name_metaSetUpInfo" select="elml:get_term_name('name_metaSetUpInfo')"/>
	<xsl:variable name="name_metadata" select="elml:get_term_name('name_metadata')"/>
	<xsl:variable name="name_solution" select="elml:get_term_name('name_solution')"/>
	<xsl:variable name="name_solutiontext" select="elml:get_term_name('name_solutiontext')"/>
	<xsl:variable name="name_anon" select="elml:get_term_name('name_anon')"/>
	<xsl:variable name="name_size" select="elml:get_term_name('name_size')"/>
	<xsl:variable name="name_type" select="elml:get_term_name('name_type')"/>
	<xsl:variable name="name_internalLink" select="elml:get_term_name('name_internalLink')"/>
	<xsl:variable name="name_lesson" select="elml:get_term_name('name_lesson')"/>
	<xsl:variable name="name_page" select="elml:get_term_name('name_page')"/>
	<xsl:variable name="name_page_of" select="elml:get_term_name('name_page_of')"/>
	<xsl:variable name="name_hint" select="elml:get_term_name('name_hint')"/>
	<xsl:variable name="name_nolegend" select="elml:get_term_name('name_nolegend')"/>
	<xsl:variable name="name_notanimage" select="elml:get_term_name('name_notanimage')"/>
	<xsl:variable name="name_download" select="elml:get_term_name('name_download')"/>
	<xsl:variable name="name_annotation" select="elml:get_term_name('name_annotation')"/>
	<xsl:variable name="name_selfCheckCorrect" select="elml:get_term_name('name_selfCheckCorrect')"/>
	<xsl:variable name="name_selfCheckSolve" select="elml:get_term_name('name_selfCheckSolve')"/>
	<xsl:variable name="name_selfCheckMissing" select="elml:get_term_name('name_selfCheckMissing')"/>
	<xsl:variable name="name_optionalunits_symbol" select="elml:get_term_name('name_optionalunits_symbol')"/>
	<xsl:variable name="name_optionalunits_text" select="elml:get_term_name('name_optionalunits_text')"/>
	<xsl:variable name="name_index" select="elml:get_term_name('name_index')"/>
	<xsl:variable name="name_appendix" select="elml:get_term_name('name_appendix')"/>
	<xsl:variable name="name_figures" select="elml:get_term_name('name_figures')"/>
	<xsl:variable name="name_tables" select="elml:get_term_name('name_tables')"/>
	<xsl:variable name="name_bugtracker" select="elml:get_term_name('name_bugtracker')"/>
	<xsl:variable name="name_contact" select="elml:get_term_name('name_contact')"/>
	<xsl:variable name="name_print" select="elml:get_term_name('name_print')"/>
	<xsl:variable name="name_printed" select="elml:get_term_name('name_printed')"/>
	<xsl:variable name="name_responsible" select="elml:get_term_name('name_responsible')"/>
    <xsl:variable name="name_tutoronly" select="elml:get_term_name('name_tutoronly')"/>
    <xsl:variable name="name_html5support" select="elml:get_term_name('name_html5support')"/>
    <xsl:template name="elml:name_biblio">
		<xsl:param name="itemname"/>
		<xsl:choose>
			<xsl:when test="contains($itemname,'videoFilmBroadcast')">
				<xsl:value-of select="elml:get_term_name('name_biblio_videoFilmBroadcast')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'conferencePaper')">
				<xsl:value-of select="elml:get_term_name('name_biblio_conferencePaper')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'publicationCorporateBody')">
				<xsl:value-of select="elml:get_term_name('name_biblio_publicationCorporateBody')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'contributionInBook')">
				<xsl:value-of select="elml:get_term_name('name_biblio_contributionInBook')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'journalArticle')">
				<xsl:value-of select="elml:get_term_name('name_biblio_journalArticle')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'newspaperArticle')">
				<xsl:value-of select="elml:get_term_name('name_biblio_newspaperArticle')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'thesis')">
				<xsl:value-of select="elml:get_term_name('name_biblio_thesis')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'patent')">
				<xsl:value-of select="elml:get_term_name('name_biblio_patent')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'websites')">
				<xsl:value-of select="elml:get_term_name('name_biblio_websites')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'eJournals')">
				<xsl:value-of select="elml:get_term_name('name_biblio_eJournals')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'mailLists')">
				<xsl:value-of select="elml:get_term_name('name_biblio_mailLists')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'personalMail')">
				<xsl:value-of select="elml:get_term_name('name_biblio_personalMail')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'cdRom')">
				<xsl:value-of select="elml:get_term_name('name_biblio_cdRom')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'book')">
				<xsl:value-of select="elml:get_term_name('name_biblio_book')"/>
			</xsl:when>
			<xsl:when test="contains($itemname,'map')">
				<xsl:value-of select="elml:get_term_name('name_biblio_map')"/>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="not(contains($itemname,'Meta'))">
			<xsl:text>: </xsl:text>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
