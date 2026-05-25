<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../../../core/presentation/online/elml.xsl"/>
	<!-- ***** Parameter definitions  *****-->
	<!--The name of this layout (=folder name of template folder!)  -->
	<xsl:param name="layout" select="'gitta'"/>
	<xsl:variable name="name_furtherReading">
		<xsl:choose>
			<xsl:when test="/elml:lesson/@label='website'">
				<xsl:choose>
					<xsl:when test="$lang='de'">
						<xsl:text>Publikationen</xsl:text>
					</xsl:when>
					<xsl:when test="$lang='fr'">
						<xsl:text>Publicacions</xsl:text>
					</xsl:when>
					<xsl:when test="$lang='it'">
						<xsl:text>Publicazione</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Publications</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="elml:get_term_name('name_furtherReading')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:character-map name="comment">
		<!-- Comment start -->
		<xsl:output-character character="&#xE001;" string="&lt;"/>
		<!-- Comment end -->
		<xsl:output-character character="&#xE002;" string="&gt;"/>
		<!-- special path_full (breadcrumb) separator for GITTA -->
		<xsl:output-character character="&#xE003;" string=": "/>
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
		            <xsl:value-of>timeSpend()</xsl:value-of>
		        </xsl:attribute>
		    </xsl:if>
			<div id="button_pdf" class="dontprint">
				<a target="_blank">
					<xsl:attribute name="href">
						<xsl:text>../text/</xsl:text>
						<xsl:value-of select="/elml:lesson/@label"/>
						<xsl:text>.pdf</xsl:text>
					</xsl:attribute>
					<img src="../../../_templates/{$layout}/icons/PDF.gif" alt="PDF Version of this document" height="31" width="31" border="0"/>
				</a>
			</div>
			<xsl:if test="/elml:lesson/elml:glossary">
				<div id="button_glossary" class="dontprint">
					<a target="_top">
						<xsl:attribute name="href">
							<xsl:if test="not(($pagebreak_level='unit') or ($pagebreak_level='lo'))">
								<xsl:text>#</xsl:text>
							</xsl:if>
							<xsl:value-of select="/elml:lesson/@label"/>
							<xsl:text>_glossary</xsl:text>
							<xsl:value-of select="$filename_suffix"/>
						</xsl:attribute>
						<img src="../../../_templates/{$layout}/icons/glossary.gif" alt="Glossary" height="31" width="29" border="0"/>
					</a>
				</div>
			</xsl:if>
			<div id="button_help" class="dontprint">
				<a href="http://www.gitta.info/introduction.html" target="_blank">
					<img src="../../../_templates/{$layout}/icons/help.gif" alt="Help" height="31" width="29" border="0"/>
				</a>
			</div>
			<div id="bg_head" class="dontprint">
				<img src="../../../_templates/{$layout}/images/gitta_kopf_klein.gif" alt="" height="247" width="882" border="0"/>
			</div>
			<xsl:if test="not(contains($next,'none'))">
				<div id="next_top" class="dontprint">
					<a href="{$next}">
						<img src="../../../_templates/{$layout}/images/navigationright.gif" height="34" width="25" alt="Go to next page" border="0"/>
					</a>
				</div>
			</xsl:if>
			<xsl:if test="not(contains($prev,'none'))">
				<div id="prev_top" class="dontprint">
					<a href="{$prev}">
						<img src="../../../_templates/{$layout}/images/navigationleft.gif" height="34" width="25" alt="Go to previous page" border="0"/>
					</a>
				</div>
			</xsl:if>
			<div id="navigation" class="dontprint">
				<!-- Navigation Starts here -->
				<xsl:call-template name="elml:gitta_left_column"/>
				<!-- Navigation Ends here -->
			</div>
			<div id="head_title" class="dontprint">
				<p>
					<xsl:call-template name="elml:path_full"/>
				</p>
			</div>
			<div id="content">
				<!-- Content Starts here -->
				<a name="top"/>
				<xsl:call-template name="elml:LayoutBodyContent"/>
				<!-- Content Ends here -->
				<table width="639" border="0" cellspacing="0" cellpadding="0" class="background">
					<tr class="dontprint">
						<td width="590">
							<img src="../../../_templates/{$layout}/images/bottom_line.gif" height="15" width="590" alt=""/>
							<br/>
							<a href="#top">
								<img src="../../../_templates/{$layout}/images/arrowup.gif" height="15" width="27" alt=""/>
							</a>
						</td>
						<td width="25">
							<xsl:choose>
								<xsl:when test="contains($prev,'none')">
									<img src="../../../_templates/{$layout}/images/navigationleft_leer.gif" height="34" width="25" alt="No previous page available" border="0"/>
								</xsl:when>
								<xsl:otherwise>
									<a href="{$prev}">
										<img src="../../../_templates/{$layout}/images/navigationleft.gif" height="34" width="25" alt="Go to previous page" border="0"/>
									</a>
								</xsl:otherwise>
							</xsl:choose>
						</td>
						<td width="24">
							<xsl:choose>
								<xsl:when test="contains($next,'none')">
									<img src="../../../_templates/{$layout}/images/navigationright_leer.gif" height="34" width="25" alt="No following page available" border="0"/>
								</xsl:when>
								<xsl:otherwise>
									<a href="{$next}">
										<img src="../../../_templates/{$layout}/images/navigationright.gif" height="34" width="25" alt="Go to next page" border="0"/>
									</a>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr>
						<td colspan="3" width="882">
							<xsl:call-template name="elml:footer_gitta"/>
						</td>
					</tr>
				</table>
			</div>
		</body>
	</xsl:template>
	<xsl:template name="elml:footer_gitta">
		<p class="footer"> Update: <xsl:value-of select="day-from-date(current-date())"/>
			<xsl:text>.</xsl:text>
			<xsl:value-of select="month-from-date(current-date())"/>
			<xsl:text>.</xsl:text>
			<xsl:value-of select="year-from-date(current-date())"/> (<a href="http://www.elml.ch/" target="_blank">eLML</a>) <xsl:if test="not($bugtracker='')"> - <a target="_blank">
					<xsl:attribute name="href">
						<xsl:value-of select="$bugtracker"/>
					</xsl:attribute>
					<xsl:value-of select="$name_bugtracker"/>
				</a>
			</xsl:if> - <a>
				<xsl:attribute name="href">
					<xsl:text>mailto:</xsl:text>
					<xsl:value-of select="$contact"/>
				</xsl:attribute>
				<xsl:value-of select="$name_contact"/>
			</a> - <a>
				<xsl:attribute name="href">
					<xsl:text>../text/</xsl:text>
					<xsl:value-of select="/elml:lesson/@label"/>
					<xsl:text>.pdf</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="$name_print"/> (PDF)</a> - <a rel="license" target="_blank">
				<xsl:attribute name="href">
					<xsl:text>http://creativecommons.org/licenses/by-nc-sa/2.5/deed.</xsl:text>
					<xsl:value-of select="$lang"/>
				</xsl:attribute>
				<xsl:text disable-output-escaping="yes"> © GITTA 2006 (Creative Commons) </xsl:text>
			</a>
		</p>
		<xsl:call-template name="elml:cc_code"/>
	</xsl:template>
	<xsl:template name="elml:cc_code"> &#xE001;!--<rdf:RDF xmlns="http://web.resource.org/cc/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
			<Work rdf:about="">
				<license rdf:resource="http://creativecommons.org/licenses/by-nc-sa/2.5/"/>
				<dc:type rdf:resource="http://purl.org/dc/dcmitype/InteractiveResource"/>
			</Work>
			<License rdf:about="http://creativecommons.org/licenses/by-nc-sa/2.5/">
				<permits rdf:resource="http://web.resource.org/cc/Reproduction"/>
				<permits rdf:resource="http://web.resource.org/cc/Distribution"/>
				<requires rdf:resource="http://web.resource.org/cc/Notice"/>
				<requires rdf:resource="http://web.resource.org/cc/Attribution"/>
				<prohibits rdf:resource="http://web.resource.org/cc/CommercialUse"/>
				<permits rdf:resource="http://web.resource.org/cc/DerivativeWorks"/>
				<requires rdf:resource="http://web.resource.org/cc/ShareAlike"/>
			</License>
		</rdf:RDF> --&#xE002; </xsl:template>
	<!-- ***** Navigation GITTA *****-->
	<xsl:template name="elml:gitta_left_column">
		<xsl:if test="$use_navigation='yes'">
			<table width="243" border="0" cellspacing="0" cellpadding="0" style="table-layout:auto;width=243px;font-size:12px;">
				<colgroup>
					<col width="215"/>
					<col width="28"/>
				</colgroup>
				<xsl:call-template name="elml:navigation"/>
			</table>
		</xsl:if>
		<br/>
		<table class="box" style="width: 120px" width="120" cellspacing="0" cellpadding="2">
			<tr>
				<td>
					<form style="margin:0; padding:0;" action="https://lists.sourceforge.net/lists/subscribe/elml-gitta" method="post" name="newsletter-gitta">
						<p>
							<b>GITTA/CartouCHe news:</b>
							<br/>
							<input type="text" name="email" value="your@email" size="14" onfocus="if (this.value=='your@email') this.value=''" onblur="if (this.value=='') this.value='your@email'" border="0"/>
							<br/>
							<input type="hidden" name="pw">
								<xsl:attribute name="value">
									<xsl:value-of select="generate-id()"/>
								</xsl:attribute>
							</input>
							<input type="hidden" name="pw-conf">
								<xsl:attribute name="value">
									<xsl:value-of select="generate-id()"/>
								</xsl:attribute>
							</input>
							<input type="hidden" name="digest" value="0"/>
							<input type="submit" value="subscribe me!"/>
						</p>
					</form>
				</td>
			</tr>
		</table>
		<br/>
		<p id="cc_logo">
			<!--Creative Commons License-->
			<a rel="license" target="_blank">
				<xsl:attribute name="href">
					<xsl:text>http://creativecommons.org/licenses/by-nc-sa/2.5/deed.</xsl:text>
					<xsl:value-of select="$lang"/>
				</xsl:attribute>
				<img alt="Creative Commons License" border="0" src="../../../_templates/{$layout}/icons/creativecommons.png" align="top"/>
			</a>
		</p>
	</xsl:template>
	<xsl:template name="elml:navigation">
		<xsl:call-template name="elml:navigation_start"/>
	</xsl:template>
	<xsl:template match="elml:lesson" mode="navigation_lesson">
		<xsl:param name="filename"/>
		<xsl:param name="actual_lesson"/>
		<xsl:param name="navact">
			<xsl:if test="($actual_lesson=/elml:lesson/@label) and ($filename = concat('index', $filename_suffix))">
				<xsl:text>_act</xsl:text>
			</xsl:if>
		</xsl:param>
		<tr align="left" valign="top">
			<td width="215" height="34" class="background_nav" style="background-image: url(../../../_templates/{$layout}/navigation/line_first.gif)">
				<p style="text-align:left; line-height: 100%; text-indent:-32px; margin-left:32px; margin-top: 0; margin-bottom: 12px;">
					<img src="../../../_templates/{$layout}/navigation/punkt{$navact}.gif" height="16" width="27" alt="Lesson Navigation Icon"/>
					<xsl:call-template name="elml:nav_item_link_gitta">
						<xsl:with-param name="filename" select="$filename"/>
						<xsl:with-param name="navact" select="$navact"/>
					</xsl:call-template>
				</p>
			</td>
			<td width="28" height="34" class="background"/>
		</tr>
		<xsl:if test="(document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/@subnavigation='yes') or ($actual_lesson=/elml:lesson/@label)">
			<xsl:choose>
				<xsl:when test="/elml:lesson/@label='website'">
					<xsl:apply-templates select="elml:unit  | elml:selfAssessment | elml:summary" mode="navigation_unit_website">
						<xsl:with-param name="filename" select="$filename"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="elml:unit | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listoffigures | elml:listoftables | elml:index | elml:bibliography | elml:metadata" mode="navigation_unit">
						<xsl:with-param name="filename" select="$filename"/>
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template match="elml:unit | elml:selfAssessment | elml:summary | elml:furtherReading | elml:glossary | elml:listoffigures | elml:listoftables | elml:index | elml:bibliography | elml:metadata" mode="navigation_unit">
		<xsl:param name="filename"/>
		<xsl:param name="filenameactual">
			<xsl:call-template name="elml:Label_param"/>
		</xsl:param>
		<xsl:param name="navicon">
			<xsl:choose>
				<xsl:when test="name(.)='bibliography' and not($role='tutor' or /elml:lesson/elml:metadata/@role=$role or not(/elml:lesson/elml:metadata/@role))">
					<xsl:text>zurueck</xsl:text>
				</xsl:when>
				<xsl:when test="(count(preceding-sibling::elml:unit)=number(0)) and (count(following-sibling::*)=number(0))">
					<xsl:text>einrueckone</xsl:text>
				</xsl:when>
				<xsl:when test="count(preceding-sibling::elml:unit)=number(0)">
					<xsl:text>einrueck</xsl:text>
				</xsl:when>
				<xsl:when test="count(following-sibling::*)=number(0)">
					<xsl:text>zurueck</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="navline">
			<xsl:choose>
				<xsl:when test="$navicon='zurueck'">
					<xsl:text>first</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>second</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="navact">
			<xsl:choose>
				<xsl:when test="$filename = $filenameactual">
					<xsl:text>_act</xsl:text>
				</xsl:when>
				<xsl:when test="(name(.)='entry') and ($filename = concat('index', $filename_suffix))">
					<xsl:text>_act</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="display">
			<xsl:call-template name="elml:display"/>
		</xsl:param>
		<xsl:if test="$display='yes'">
			<tr align="left" valign="top">
				<td width="215" height="34" class="background_nav" style="background-image: url(../../../_templates/{$layout}/navigation/line_{$navline}.gif)">
					<p style="text-align:left; line-height: 100%; text-indent:-46px; margin-left:46px; margin-top: 0; margin-bottom: 12px;">
						<img src="../../../_templates/{$layout}/navigation/{$navicon}dreieck{$navact}.gif" height="15" width="41" alt="Unit Navigation Icon"/>
						<xsl:call-template name="elml:nav_item_link_gitta">
							<xsl:with-param name="filename" select="$filename"/>
							<xsl:with-param name="navact" select="$navact"/>
						</xsl:call-template>
					</p>
				</td>
				<td width="28" class="background"/>
			</tr>
			<xsl:if test="(name(.)='unit') and (($pagebreak_level='unit') or ($pagebreak_level='lo')) and (($filename = $filenameactual) or contains($filename,@label))">
				<xsl:apply-templates select="elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading" mode="navigation_lo">
					<xsl:with-param name="filename" select="$filename"/>
				</xsl:apply-templates>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="elml:unit  | elml:selfAssessment | elml:summary | elml:furtherReading" mode="navigation_unit_website">
		<xsl:param name="filename"/>
		<xsl:param name="filenameactual">
			<xsl:call-template name="elml:Label_param"/>
		</xsl:param>
		<xsl:param name="navicon">
			<xsl:choose>
				<xsl:when test="name(.)='summary'">
					<xsl:text>zurueck</xsl:text>
				</xsl:when>
				<xsl:when test="(count(preceding-sibling::elml:unit)=number(0)) and (count(following-sibling::*)=number(0))">
					<xsl:text>einrueckone</xsl:text>
				</xsl:when>
				<xsl:when test="count(preceding-sibling::elml:unit)=number(0)">
					<xsl:text>einrueck</xsl:text>
				</xsl:when>
				<xsl:when test="count(following-sibling::*)=number(0)">
					<xsl:text>zurueck</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="navline">
			<xsl:choose>
				<xsl:when test="$navicon='zurueck'">
					<xsl:text>first</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>second</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="navact">
			<xsl:choose>
				<xsl:when test="$filename = $filenameactual">
					<xsl:text>_act</xsl:text>
				</xsl:when>
				<xsl:when test="(name(.)='entry') and ($filename = concat('index', $filename_suffix))">
					<xsl:text>_act</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="display">
			<xsl:call-template name="elml:display"/>
		</xsl:param>
		<xsl:if test="$display='yes'">
			<tr align="left" valign="top">
				<td width="215" height="34" class="background_nav" style="background-image: url(../../../_templates/{$layout}/navigation/line_{$navline}.gif)">
					<p style="text-align:left; line-height: 100%; text-indent:-46px; margin-left:46px; margin-top: 0; margin-bottom: 12px;">
						<img src="../../../_templates/{$layout}/navigation/{$navicon}dreieck{$navact}.gif" height="15" width="41" alt="Unit Navigation Icon"/>
						<xsl:call-template name="elml:nav_item_link_gitta">
							<xsl:with-param name="filename" select="$filename"/>
							<xsl:with-param name="navact" select="$navact"/>
						</xsl:call-template>
					</p>
				</td>
				<td width="28" class="background"/>
			</tr>
			<xsl:if test="(name(.)='unit') and (($pagebreak_level='unit') or ($pagebreak_level='lo')) and (($filename = $filenameactual) or contains($filename,@label))">
				<xsl:apply-templates select="elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading" mode="navigation_lo">
					<xsl:with-param name="filename" select="$filename"/>
				</xsl:apply-templates>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="elml:learningObject | elml:selfAssessment | elml:summary | elml:furtherReading" mode="navigation_lo">
		<xsl:param name="filename"/>
		<xsl:param name="filenameactual">
			<xsl:call-template name="elml:Label_param"/>
		</xsl:param>
		<xsl:param name="navicon">
			<xsl:choose>
				<xsl:when test="(count(preceding-sibling::elml:learningObject)=number(0)) and (count(following-sibling::*)=number(0))">
					<xsl:text>einrueckone</xsl:text>
				</xsl:when>
				<xsl:when test="count(preceding-sibling::elml:learningObject)=number(0)">
					<xsl:text>einrueck</xsl:text>
				</xsl:when>
				<xsl:when test="count(following-sibling::*)=number(0)">
					<xsl:text>zurueck</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="navline">
			<xsl:choose>
				<xsl:when test="$navicon='zurueck' or $navicon='einrueckone'">
					<xsl:text>second</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>third</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="navact">
			<xsl:choose>
				<xsl:when test="$filename = $filenameactual">
					<xsl:text>_act</xsl:text>
				</xsl:when>
				<xsl:when test="(name(.)='entry') and ($filename = concat('unit_',parent::elml:unit/@label,$filename_suffix)) and ($pagebreak_level='lo')">
					<xsl:text>_act</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<tr align="left" valign="top">
			<td width="215" height="34" class="background_nav" style="background-image: url(../../../_templates/{$layout}/navigation/line_{$navline}.gif)">
				<p style="text-align:left; line-height: 100%; text-indent:-57px; margin-left:57px; margin-top: 0; margin-bottom: 12px;">
					<img src="../../../_templates/{$layout}/navigation/{$navicon}viereck{$navact}.gif" height="15" width="52" alt="LO Navigation Icon"/>
					<xsl:call-template name="elml:nav_item_link_gitta">
						<xsl:with-param name="filename" select="$filename"/>
						<xsl:with-param name="navact" select="$navact"/>
					</xsl:call-template>
				</p>
			</td>
			<td width="28" class="background"/>
		</tr>
	</xsl:template>
	<xsl:template name="elml:nav_item_link_gitta">
		<xsl:param name="navact"/>
		<xsl:param name="filename"/>
		<xsl:param name="filenameactual">
			<xsl:call-template name="elml:Label_param"/>
		</xsl:param>
		<xsl:choose>
			<xsl:when test="$navact='_act'">
				<span>
					<xsl:attribute name="class">
						<xsl:text>navigationActual</xsl:text>
					</xsl:attribute>
					<xsl:call-template name="elml:Kapitel">
						<xsl:with-param name="isnavigation">yes</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="contains($filenameactual, 'unit_') and contains($optional_units, substring-after(substring-before($filenameactual, $filename_suffix), 'unit_'))">
						<xsl:value-of select="$name_optionalunits_symbol"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<a>
					<xsl:attribute name="class">
						<xsl:text>navigationLink</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:if test="$multiple='on'">
							<xsl:text>../../../</xsl:text>
							<xsl:value-of select="/elml:lesson/@label"/>
							<xsl:text>/</xsl:text>
							<xsl:value-of select="$lang"/>
							<xsl:text>/html/</xsl:text>
						</xsl:if>
						<xsl:call-template name="elml:Label_param_withfilename"/>
					</xsl:attribute>
					<xsl:call-template name="elml:Kapitel">
						<xsl:with-param name="isnavigation">yes</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="contains($filenameactual, 'unit_') and contains($optional_units, substring-after(substring-before($filenameactual, $filename_suffix), 'unit_'))">
						<xsl:value-of select="$name_optionalunits_symbol"/>
					</xsl:if>
				</a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
