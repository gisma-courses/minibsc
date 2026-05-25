<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2004/07/xpath-functions" xmlns:xdt="http://www.w3.org/2004/07/xpath-datatypes" xmlns:fox="http://xml.apache.org/fop/extensions">
    <!--DO NOT TOUCH ANYTHING IN THIS FILE! THESE ARE DEFAULT VALUES! -->
    <!--To personalize use the config and templates file of your project. See documentation. -->
    <!--The name of the file with the default titles (and other) names -->
    <xsl:import href="../terms.xsl"/>
    <xsl:import href="../params.xsl"/>
    <!--The name of the default bibliography file (in LaTeX the style is defined in the .tex file and via transformation. Therefore you should not change this option as you do in the online or print version) -->
    <xsl:import href="biblio.xsl"/>
    <!--The name of the default metadata file. Do change it in your online.xsl if you want to use another one! -->
    <xsl:import href="metadata_elml.xsl"/>
    <xsl:output method="text" indent="yes" omit-xml-declaration="yes" name="latex" encoding="UTF-8" use-character-maps="latex"/>
    <xsl:strip-space elements="*"/>
    <!--Special pathRoot definition for Latex because the "file:" in front of path does not work in Latex -->
    <xsl:param name="pathRoot">
        <xsl:choose>
            <xsl:when test="contains(base-uri(), '\')">
                <xsl:value-of select="substring-after(substring-before(base-uri(), concat('\', /elml:lesson/@label)),'file:')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="substring-after(substring-before(base-uri(), concat('/', /elml:lesson/@label)),'file:')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:variable name="filename_suffix">
        <xsl:text>.tex</xsl:text>
    </xsl:variable>
    <xsl:character-map name="latex">
        <!-- Quote for ZapfDingbats character -->
        <xsl:output-character character="&#xE004;" string="&quot;"/>
        <xsl:output-character character="&lt;" string="\ensuremath{&lt;}"/>
        <xsl:output-character character="&gt;" string="\ensuremath{&gt;}"/>
        <!-- ASCII characters -->
        <xsl:output-character character="&quot;" string="''"/>
        <xsl:output-character character="’" string="'"/>
        <xsl:output-character character="‘" string="'"/>
        <xsl:output-character character="$" string="\$"/>
        <xsl:output-character character="#" string="\#"/>
        <xsl:output-character character="%" string="\%"/>
        <xsl:output-character character="~" string="\char`\~"/>
        <xsl:output-character character="&amp;" string="\&amp;"/>
        <xsl:output-character character="^" string="\char`\^"/>
        <xsl:output-character character="„" string="\glqq "/>
        <xsl:output-character character="“" string="\grqq "/>
        <xsl:output-character character="…" string="..."/>
        <!-- Latin 1 Chars -->
        <xsl:output-character character="—" string="-"/>
        <xsl:output-character character="–" string="-"/>
        <xsl:output-character character="¡" string="\textexclamdown "/>
        <xsl:output-character character="¢" string="\textcent "/>
        <xsl:output-character character="£" string="\textsterling "/>
        <xsl:output-character character="¤" string="\textcurrency "/>
        <xsl:output-character character="¥" string="\textyen "/>
        <xsl:output-character character="¦" string="\textbrokenbar "/>
        <xsl:output-character character="§" string="\textsection "/>
        <xsl:output-character character="¨" string="\textasciidieresis "/>
        <xsl:output-character character="©" string="\copyright "/>
        <xsl:output-character character="ª" string="\textordfeminine "/>
        <xsl:output-character character="«" string="\guillemotleft "/>
        <xsl:output-character character="¬" string="\textlnot "/>
        <xsl:output-character character="®" string="\textregistered "/>
        <xsl:output-character character="¯" string="\textasciimacron "/>
        <xsl:output-character character="°" string="\textdegree "/>
        <xsl:output-character character="±" string="\textpm "/>
        <xsl:output-character character="²" string="\texttwosuperior "/>
        <xsl:output-character character="³" string="\textthreesuperior "/>
        <xsl:output-character character="´" string="\textasciiacute "/>
        <xsl:output-character character="µ" string="\textmu "/>
        <xsl:output-character character="¶" string="\textparagraph "/>
        <xsl:output-character character="·" string="\textbullet "/>
        <xsl:output-character character="¹" string="\textonesuperior "/>
        <xsl:output-character character="º" string="\textordmasculine "/>
        <xsl:output-character character="»" string="\guillemotright "/>
        <xsl:output-character character="¼" string="\textonequarter "/>
        <xsl:output-character character="½" string="\textonehalf "/>
        <xsl:output-character character="¾" string="\textthreequarters "/>
        <xsl:output-character character="¿" string="\textquestiondown "/>
        <xsl:output-character character="À" string="\`A"/>
        <xsl:output-character character="Á" string="\'A"/>
        <xsl:output-character character="Â" string="\^A"/>
        <xsl:output-character character="Ã" string="\~A"/>
        <xsl:output-character character="Ä" string="\&quot;A"/>
        <xsl:output-character character="Å" string="\AA"/>
        <xsl:output-character character="Æ" string="\AE"/>
        <xsl:output-character character="Ç" string="\c C"/>
        <xsl:output-character character="È" string="\`E"/>
        <xsl:output-character character="É" string="\'E"/>
        <xsl:output-character character="Ê" string="\^E"/>
        <xsl:output-character character="Ë" string="\&quot;E"/>
        <xsl:output-character character="Ì" string="\`I"/>
        <xsl:output-character character="Í" string="\'I"/>
        <xsl:output-character character="Î" string="\^I"/>
        <xsl:output-character character="Ï" string="\&quot;I"/>
        <xsl:output-character character="Ñ" string="\~N"/>
        <xsl:output-character character="Ò" string="\`O"/>
        <xsl:output-character character="Ó" string="\'O"/>
        <xsl:output-character character="Ô" string="\^O"/>
        <xsl:output-character character="Õ" string="\~O"/>
        <xsl:output-character character="Ö" string="\&quot;O"/>
        <xsl:output-character character="×" string="\texttimes "/>
        <xsl:output-character character="Ø" string="\O"/>
        <xsl:output-character character="Ù" string="\`U"/>
        <xsl:output-character character="Ú" string="\'U"/>
        <xsl:output-character character="Û" string="\^U"/>
        <xsl:output-character character="Ü" string="\&quot;U"/>
        <xsl:output-character character="Ý" string="\'Y"/>
        <xsl:output-character character="ß" string="\ss "/>
        <xsl:output-character character="à" string="\`a"/>
        <xsl:output-character character="á" string="\'a"/>
        <xsl:output-character character="â" string="\^a"/>
        <xsl:output-character character="ã" string="\~a"/>
        <xsl:output-character character="ä" string="\&quot;a"/>
        <xsl:output-character character="å" string="\aa"/>
        <xsl:output-character character="æ" string="\ae"/>
        <xsl:output-character character="ç" string="\c c"/>
        <xsl:output-character character="è" string="\`e"/>
        <xsl:output-character character="é" string="\'e"/>
        <xsl:output-character character="ê" string="\^e"/>
        <xsl:output-character character="ë" string="\&quot;e"/>
        <xsl:output-character character="ì" string="\`i"/>
        <xsl:output-character character="í" string="\'i"/>
        <xsl:output-character character="î" string="\^i"/>
        <xsl:output-character character="ï" string="\&quot;i"/>
        <xsl:output-character character="ñ" string="\~n"/>
        <xsl:output-character character="ò" string="\`o"/>
        <xsl:output-character character="ó" string="\'o"/>
        <xsl:output-character character="ô" string="\^o"/>
        <xsl:output-character character="õ" string="\~o"/>
        <xsl:output-character character="ö" string="\&quot;o"/>
        <xsl:output-character character="÷" string="\textdiv"/>
        <xsl:output-character character="ø" string="\o"/>
        <xsl:output-character character="ù" string="\`u"/>
        <xsl:output-character character="ú" string="\'u"/>
        <xsl:output-character character="û" string="\^u"/>
        <xsl:output-character character="ü" string="\&quot;u"/>
        <xsl:output-character character="ý" string="\'y"/>
        <xsl:output-character character="ÿ" string="\&quot;y"/>
        <xsl:output-character character="•" string="\textbullet "/>
        <xsl:output-character character="_" string="\_"/>
        <xsl:output-character character="&#0160;" string=" "/>
        <xsl:output-character character="→" string="\rightarrow"/>
        <!-- Greek Characters -->
        <xsl:output-character character="α" string="\alpha"/>
        <xsl:output-character character="θ" string="\theta"/>
        <xsl:output-character character="τ" string="\tau"/>
        <xsl:output-character character="β" string="\beta"/>
        <xsl:output-character character="ϑ" string="\vartheta"/>
        <xsl:output-character character="π" string="\pi"/>
        <xsl:output-character character="υ" string="\upsilon"/>
        <xsl:output-character character="γ" string="\gamma"/>
        <xsl:output-character character="ι" string="\iota"/>
        <xsl:output-character character="ϖ" string="\varpi"/>
        <xsl:output-character character="φ" string="\phi"/>
        <xsl:output-character character="δ" string="\delta"/>
        <xsl:output-character character="κ" string="\kappa"/>
        <xsl:output-character character="ρ" string="\rho"/>
        <xsl:output-character character="ϕ" string="\varphi"/>
        <xsl:output-character character="ϵ" string="\epsilon"/>
        <xsl:output-character character="λ" string="\lambda"/>
        <xsl:output-character character="ϱ" string="\varrho"/>
        <xsl:output-character character="χ" string="\chi"/>
        <xsl:output-character character="ε" string="\varepsilon"/>
        <xsl:output-character character="µ" string="\mu"/>
        <xsl:output-character character="σ" string="\sigma"/>
        <xsl:output-character character="ψ" string="\psi"/>
        <xsl:output-character character="ζ" string="\zeta"/>
        <xsl:output-character character="ν" string="\nu"/>
        <xsl:output-character character="ς" string="\varsigma"/>
        <xsl:output-character character="ω" string="\omega"/>
        <xsl:output-character character="η" string="\eta"/>
        <xsl:output-character character="ξ" string="\xi"/>
        <xsl:output-character character="Γ" string="\Gamma"/>
        <xsl:output-character character="Λ" string="\Lambda"/>
        <xsl:output-character character="Σ" string="\Sigma"/>
        <xsl:output-character character="Ψ" string="\Psi"/>
        <xsl:output-character character="∆" string="\Delta"/>
        <xsl:output-character character="Ξ" string="\Xi"/>
        <xsl:output-character character="Υ" string="\Upsilon"/>
        <xsl:output-character character="Ω" string="\Omega"/>
        <xsl:output-character character="Θ" string="\Theta"/>
        <xsl:output-character character="Π" string="\Pi"/>
        <xsl:output-character character="Φ" string="\Phi"/>
        <xsl:output-character character="ο" string="o"/>
        <!-- Problemfälle:
            
            <xsl:output-character character="_" string="\_"/>
            <xsl:output-character character="\" string="\textbackslash"/>
            <xsl:output-character character="{" string="\{"/>
            <xsl:output-character character="}" string="\}"/>
        -->
    </xsl:character-map>
    <xsl:param name="textwidth" select="12"/>
    <!-- Beginning with template definitions -->
    <xsl:template match="/">
        <xsl:result-document href="{$pathRoot}/{/elml:lesson/@label}/{$lang}/latex/{/elml:lesson/@label}{$filename_suffix}" format="latex">
            <xsl:text>\documentclass[11pt,a4paper]{</xsl:text>
            <xsl:value-of select="$documentclass"/>
            <xsl:text>}
			</xsl:text>
            <xsl:choose>
                <xsl:when test="$lang='de'">
                    <xsl:text>\usepackage{ngerman}
					</xsl:text>
                </xsl:when>
                <xsl:when test="$lang='fr'">
                    <xsl:text>\usepackage[french]{babel}
					</xsl:text>
                </xsl:when>
                <xsl:when test="$lang='it'">
                    <xsl:text>\usepackage[italian]{babel}
					</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>\usepackage[english]{babel}
					</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="not($chapter_numeration='yes')">
                <xsl:text>\setcounter{secnumdepth}{-1}
				</xsl:text>
            </xsl:if>
            <xsl:text disable-output-escaping="yes">
				\usepackage{textcomp}
				\usepackage{makeidx}
				\usepackage{tabularx}
				\usepackage{multicol}
				\usepackage{multirow}
				\usepackage{longtable}
				\usepackage{color}
				\usepackage{soul}
				\usepackage{boxedminipage}
				\usepackage{shadow}
				\usepackage{framed}			
				\usepackage{array}
				\usepackage{url}
				\usepackage{ragged2e}
				\ifx\pdfoutput\undefined
					\usepackage{graphicx}
				\else
					\usepackage[pdftex]{graphicx}
				\fi
				\usepackage[a4paper, hyperfigures=true, colorlinks, linkcolor=black, citecolor=blue,urlcolor=blue, pagebackref=true, bookmarks=true, bookmarksopen=true,bookmarksnumbered=true,
                pdfauthor={</xsl:text>
            <xsl:choose>
                <xsl:when test="$multiple='on' and document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/@authors">
                    <xsl:value-of select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/@authors" disable-output-escaping="yes"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:contribute/elml:person">
                        <xsl:value-of select="@name" disable-output-escaping="yes"/>
                        <xsl:if test="not(position()=last())">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>}, pdftitle={</xsl:text>
            <xsl:choose>
                <xsl:when test="$multiple='on' and document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/@title">
                    <xsl:value-of select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/@title"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="/elml:lesson/@title" disable-output-escaping="yes"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>}, pdfkeywords={</xsl:text>
            <xsl:value-of select="/elml:lesson/@title"/>, <xsl:for-each select="/elml:lesson/elml:metadata/elml:keywords/elml:keywordItem">
                <xsl:value-of select="." disable-output-escaping="yes"/>
                <xsl:if test="not(position()=last())">, </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="/elml:lesson/elml:glossary/elml:definition">
                <xsl:value-of select="@term" disable-output-escaping="yes"/>, </xsl:for-each>
            <xsl:text disable-output-escaping="yes">},pdfpagemode=UseOutlines,pdfpagetransition=Dissolve,nesting=true,
				backref, pdffitwindow=true, bookmarksnumbered=true]{hyperref}
				\usepackage{supertabular}
				\usepackage[table]{xcolor}
				\usepackage{url}
				\usepackage{caption} 
				\setlength{\parskip}{1.3ex plus 0.2ex minus 0.2ex}
				\setlength{\parindent}{0pt}
				
				\makeatletter
				\def\url@leostyle{ \@ifundefined{selectfont}{\def\UrlFont{\sf}}{\def\UrlFont{\footnotesize\ttfamily}}}
				\makeatother
				\urlstyle{leo}
				
				\definecolor{examplecolor}{rgb}{0.156,0.333,0.443}
				\definecolor{definitioncolor}{rgb}{0.709,0.784,0.454}
				\definecolor{exercisecolor}{rgb}{0.49,0.639,0}
				\definecolor{hintcolor}{rgb}{0.941,0.674,0.196}
				\definecolor{tableHeadercolor}{rgb}{0.709,0.784,0.454}
				\definecolor{tablerowAltcolor}{rgb}{.866,.905,.737}
				\definecolor{tablerowAlt2color}{rgb}{.968,.976,.933}
				
				\newenvironment{fshaded}{
				\def\FrameCommand{\fcolorbox{framecolor}{shadecolor}}
				\MakeFramed {\FrameRestore}}
				{\endMakeFramed}
				
				\newenvironment{fexample}[1][]{\definecolor{shadecolor}{rgb}{.913,.913,.913}
				\definecolor{framecolor}{rgb}{.156,.333,.443}
				\begin{fshaded}}{\end{fshaded}} 
				
				\newenvironment{fdefinition}{\definecolor{shadecolor}{rgb}{.913,.913,.913}
				\definecolor{framecolor}{rgb}{.709,.784,.454}
				\begin{fshaded}}{\end{fshaded}}
				
				\newenvironment{fexercise}{\definecolor{shadecolor}{rgb}{.913,.913,.913}
				\definecolor{framecolor}{rgb}{.49,.639,0}
				\begin{fshaded}}{\end{fshaded}}
				
				\newenvironment{fhint}{\definecolor{shadecolor}{rgb}{.913,.913,.913}
				\definecolor{framecolor}{rgb}{.941,.674,.196}
				\begin{fshaded}}{\end{fshaded}}	
				
				\newcommand{\PreserveBackslash}[1]{
				\let\temp=\\#1\let\\=\temp
				}
				\let\PBS=\PreserveBackslash
				\newcolumntype{A}{>{\PBS\raggedright\small\hspace{0pt}}X}
				\newcolumntype{L}[1]{>{\PBS\raggedright\small\hspace{0pt}}p{#1}}
				\newcolumntype{R}[1]{>{\PBS\raggedleft\small\hspace{0pt}}p{#1}}
				\newcolumntype{C}[1]{>{\PBS\centering\small\hspace{0pt}}p{#1}}
				
				\makeindex
				
				\title{</xsl:text>
            <xsl:choose>
                <xsl:when test="$multiple='on' and document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/@title">
                    <xsl:value-of select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/@title"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="/elml:lesson/@title"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>}	
				\author{</xsl:text>
            <xsl:choose>
                <xsl:when test="$multiple='on' and document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/@authors">
                    <xsl:value-of select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/@authors"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:for-each select="/elml:lesson/elml:metadata/elml:lessonInfo/elml:lifecycle/elml:contribute/elml:person">
                        <xsl:value-of select="@name"/>
                        <xsl:text>\thanks{</xsl:text>
                        <xsl:value-of select="@institute"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="@department"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="@email"/>
                        <xsl:if test="@responsible">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="@responsible"/>
                        </xsl:if>
                        <xsl:text>}</xsl:text>
                        <xsl:if test="not(position()=last())">
                            <xsl:text> \and </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>}
				\date{\today}
				
				\begin{document}
				
				\maketitle
				\clearpage
                \addcontentsline{toc}{</xsl:text>
            <xsl:choose>
                <xsl:when test="$documentclass='book'">
                    <xsl:text>chapter</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>section</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>}{</xsl:text>
            <xsl:value-of select="$name_content"/>
            <xsl:text>}
                \tableofcontents
                
                \pagestyle{headings}
            </xsl:text>
            <xsl:choose>
                <xsl:when test="$multiple='on'">
                    <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                        <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson"/>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="/elml:lesson/elml:bibliography" mode="multiple"/>
            <xsl:call-template name="elml:index"/>
            <xsl:if test="/elml:lesson/elml:listOfFigures[not(@visible='online') and not(@visible='none')] and (not(count(//elml:multimedia) = 0) or $multiple='on')">
                <xsl:if test="$pagebreak_level='unit' or $pagebreak_level='lo'">
                    <xsl:text>
                        \clearpage
                    </xsl:text>
                </xsl:if>
                <xsl:text>
                    \listoffigures
                    \addcontentsline{toc}{</xsl:text>
                <xsl:choose>
                    <xsl:when test="$documentclass='book'">
                        <xsl:text>chapter</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>section</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>}{</xsl:text>
                <xsl:value-of select="$name_figures"/>
                <xsl:text>}
                </xsl:text>
            </xsl:if>
            <xsl:if test="/elml:lesson/elml:listOfTables[not(@visible='online') and not(@visible='none')] and (not(count(//elml:table) = 0) or $multiple='on')">
                <xsl:if test="$pagebreak_level='unit' or $pagebreak_level='lo'">
                    <xsl:text>
                        \clearpage
                    </xsl:text>
                </xsl:if>
                <xsl:text>
                    \listoftables
                    \addcontentsline{toc}{</xsl:text>
                <xsl:choose>
                    <xsl:when test="$documentclass='book'">
                        <xsl:text>chapter</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>section</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>}{</xsl:text>
                <xsl:value-of select="$name_tables"/>
                <xsl:text>}
                </xsl:text>
            </xsl:if>
            <xsl:text>
				\end{document}
			</xsl:text>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="elml:lesson">
        <xsl:call-template name="elml:generate_Title"/>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template name="elml:generate_Title">
        <xsl:param name="factor">
            <xsl:choose>
                <xsl:when test="name()='lesson'">
                    <xsl:text>2.5</xsl:text>
                </xsl:when>
                <xsl:when test="name()='unit' or name()='glossary' or name()='index' or name()='bibliography' or name()='metadata' ">
                    <xsl:text>2.0</xsl:text>
                </xsl:when>
                <xsl:when test="name()='learningObject'">
                    <xsl:text>1.5</xsl:text>
                </xsl:when>
                <xsl:when test="name()='clarify' or name()='look' or name()='act'">
                    <xsl:text>1.0</xsl:text>
                </xsl:when>
                <xsl:when test="name()='entry' or name()='goals' or name()='summary' or name()='selfAssessment' or name()='furtherReading'">
                    <xsl:choose>
                        <xsl:when test="name(parent::*)='lesson'">
                            <xsl:text>2.0</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>1.5</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0.5</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$pagebreak_level='lo' and $factor&gt;1.1 and not(name()='entry' or name()='goals')">
                <xsl:text>
					\clearpage
				</xsl:text>
            </xsl:when>
            <xsl:when test="$pagebreak_level='unit' and $factor&gt;1.6 and not(name()='entry' or name()='goals')">
                <xsl:text>
					\clearpage
				</xsl:text>
            </xsl:when>
            <xsl:when test="$pagebreak_level='lesson' and $factor&gt;2.1 and not(name()='entry' or name()='goals')">
                <xsl:text>
					\clearpage
				</xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:text>
			
		</xsl:text>
        <xsl:choose>
            <xsl:when test="$documentclass='book'">
                <xsl:choose>
                    <xsl:when test="name()='lesson'">
                        <xsl:text>\chapter{</xsl:text>
                    </xsl:when>
                    <xsl:when test="name()='glossary' or name()='index' or name()='bibliography' or name()='metadata' ">
                        <xsl:text>\section*{</xsl:text>
                    </xsl:when>
                    <xsl:when test="name()='unit'">
                        <xsl:text>\section{</xsl:text>
                    </xsl:when>
                    <xsl:when test="name()='learningObject'">
                        <xsl:text>\subsection{</xsl:text>
                    </xsl:when>
                    <xsl:when test="name()='clarify' or name()='look' or name()='act'">
                        <xsl:text>\subsubsection*{</xsl:text>
                    </xsl:when>
                    <xsl:when test="name()='entry' or name()='goals'">
                        <xsl:choose>
                            <xsl:when test="name(parent::*)='lesson'">
                                <xsl:text>\section*{</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>\subsection*{</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="name()='summary' or name()='selfAssessment' or name()='furtherReading'">
                        <xsl:choose>
                            <xsl:when test="name(parent::*)='lesson'">
                                <xsl:text>\section{</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>\subsection{</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>\paragraph{</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="name()='lesson'">
                        <xsl:text>\section{</xsl:text>
                    </xsl:when>
                    <xsl:when test="name()='glossary' or name()='index' or name()='bibliography' or name()='metadata' ">
                        <xsl:text>\subsection*{</xsl:text>
                    </xsl:when>
                    <xsl:when test="name()='unit'">
                        <xsl:text>\subsection{</xsl:text>
                    </xsl:when>
                    <xsl:when test="name()='learningObject'">
                        <xsl:text>\subsubsection{</xsl:text>
                    </xsl:when>
                    <xsl:when test="name()='clarify' or name()='look' or name()='act'">
                        <xsl:text>\paragraph{</xsl:text>
                    </xsl:when>
                    <xsl:when test="name()='entry' or name()='goals'">
                        <xsl:choose>
                            <xsl:when test="name(parent::*)='lesson'">
                                <xsl:text>\subsection*{</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>\subsubsection*{</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="name()='summary' or name()='selfAssessment' or name()='furtherReading'">
                        <xsl:choose>
                            <xsl:when test="name(parent::*)='lesson'">
                                <xsl:text>\subsection{</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>\subsubsection{</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>\subparagraph{</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="elml:Kapitel"/>
        <xsl:text>} 
		</xsl:text>
        <xsl:if test="$factor&gt;0.6">
            <xsl:call-template name="elml:Label"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:unit">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:call-template name="elml:generate_Title"/>
            <xsl:if test="name(.)='unit' and contains($optional_units, @label)">
                <xsl:text>\textsc{</xsl:text>
                <xsl:value-of select="$name_optionalunits_text"/>
                <xsl:text>}
				\par
				</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:learningObject">
        <xsl:call-template name="elml:generate_Title"/>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="elml:clarify | elml:look | elml:act">
        <xsl:if test="@title">
            <xsl:call-template name="elml:generate_Title"/>
            <xsl:text>
                \textcolor{white}{.} \par
            </xsl:text>
        </xsl:if>
        <xsl:if test="@metaSetUpInfo and not(@metaSetUpInfo ='none') and not(@metaSetUpInfo='nothing') and    ($role='tutor')">
            <xsl:text>\textsc{</xsl:text>
            <xsl:value-of select="$name_metaSetUpInfo"/>
            <xsl:text>}
				\textbf{</xsl:text>
            <xsl:value-of select="@metaSetUpInfo"/>
            <xsl:text>}
				\par
			</xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="elml:entry">
        <xsl:if test="@title">
            <xsl:call-template name="elml:generate_Title"/>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="elml:goals">
        <!-- The following table hack is needed to keep the goals on one page -->
        <xsl:if test="elml:lObjective">
            <xsl:call-template name="elml:generate_Title"/>
            <xsl:choose>
                <xsl:when test="@presentation='table'">
                    <!-- use tabularx with new column type instead -->
                    <!-- <xsl:text>\begin{tabular}[t]{|l|} -->
                    <xsl:text>\begin{tabularx}{\linewidth}{|A|} \hline
					</xsl:text>
                    <xsl:if test="@intStatement">
                        <xsl:text>\textbf{</xsl:text>
                        <xsl:value-of select="@intStatement"/>
                        <xsl:text>}\\
							</xsl:text>
                    </xsl:if>
                    <xsl:text>\hline </xsl:text>
                    <xsl:for-each select="elml:lObjective">
                        <xsl:if test="(@role='student') or (@role=$role) or (not (@role))">
                            <xsl:apply-templates/>
                            <xsl:text>\\ \hline
								</xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                    <!-- use tabularx with new column type instead -->
                    <xsl:text>\end{tabularx}
					<!-- <xsl:text>\end{tabular} -->
					</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="@intStatement">
                        <xsl:value-of select="@intStatement"/>
                        <xsl:text>\\</xsl:text>
                    </xsl:if>
                    <xsl:text>
						\begin{itemize}
					</xsl:text>
                    <xsl:for-each select="elml:lObjective">
                        <xsl:if test="(@role='student') or (@role=$role) or (not (@role))">
                            <xsl:if test="(@role='student') or (@role=$role) or (not (@role))">
                                <xsl:text>
									\item </xsl:text>
                                <xsl:apply-templates/>
                            </xsl:if>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:text>
						\end{itemize}
					</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:selfAssessment">
        <xsl:call-template name="elml:generate_Title"/>
        <xsl:if test="@metaSetUpInfo and not(@metaSetUpInfo ='none') and not(@metaSetUpInfo='nothing') and    ($role='tutor')">
            <xsl:text>\textsc{</xsl:text>
            <xsl:value-of select="$name_metaSetUpInfo"/>
            <xsl:text>}
				\textbf{</xsl:text>
            <xsl:value-of select="@metaSetUpInfo"/>
            <xsl:text>}
				\par
			</xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="elml:summary">
        <xsl:call-template name="elml:generate_Title"/>
        <xsl:apply-templates/>
    </xsl:template>
    <!-- ***** Glossary and Index Elements *****-->
    <xsl:template match="elml:glossary">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:call-template name="elml:generate_Title"/>
            <xsl:text>
                \addcontentsline{toc}{</xsl:text>
            <xsl:choose>
                <xsl:when test="$documentclass='book'">
                    <xsl:text>section</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>subsection</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>}{</xsl:text>
            <xsl:call-template name="elml:Kapitel"/>
            <xsl:text>}
            </xsl:text>
            <xsl:text>
				\begin{description}
			</xsl:text>
            <xsl:apply-templates>
                <xsl:sort select="@term" order="ascending" lang="{$lang}"/>
            </xsl:apply-templates>
            <xsl:text>
				\end{description}
			</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:definition">
        <xsl:param name="term"/>
        <xsl:text>
			\item[</xsl:text>
        <xsl:choose>
            <xsl:when test="$term">
                <xsl:value-of select="$term"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@term"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>:] </xsl:text>
        <xsl:text>\index{</xsl:text>
        <xsl:choose>
            <xsl:when test="$term">
                <xsl:value-of select="$term"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@term"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>}</xsl:text>
        <xsl:apply-templates/>
        <xsl:call-template name="elml:BibliographyRef"/>
        <xsl:text>
</xsl:text>
    </xsl:template>
    <xsl:template match="elml:definition" mode="icon">
        <xsl:param name="term"/>
        <xsl:text>
			\item[</xsl:text>
        <xsl:choose>
            <xsl:when test="$term">
                <xsl:value-of select="$term"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@term"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>:] </xsl:text>
        <xsl:text>\index{</xsl:text>
        <xsl:choose>
            <xsl:when test="$term">
                <xsl:value-of select="$term"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@term"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>}</xsl:text>
        <xsl:apply-templates mode="#default"/>
        <xsl:call-template name="elml:BibliographyRef"/>
        <xsl:text>
		</xsl:text>
    </xsl:template>
    <xsl:template match="elml:index"/>
    <xsl:template name="elml:index">
        <xsl:if test="//elml:indexItem or $multiple='on'">
            <xsl:if test="$pagebreak_level='unit' or $pagebreak_level='lo'">
                <xsl:text>
                    \clearpage
                </xsl:text>
            </xsl:if>
            <xsl:text>
                \printindex
                \addcontentsline{toc}{</xsl:text>
            <xsl:choose>
                <xsl:when test="$documentclass='book'">
                    <xsl:text>chapter</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>section</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>}{</xsl:text>
            <xsl:value-of select="$name_index"/>
            <xsl:text>}
            </xsl:text>
        </xsl:if>
    </xsl:template>
    <!-- ***** Bibliography Elements (most stuff in external file biblio_*.xsl) *****-->
    <xsl:template name="elml:BibliographyRef">
        <xsl:if test="@bibIDRef">
            <xsl:text> \cite</xsl:text>
            <xsl:if test="@pageNr">
                <xsl:text>[p. </xsl:text>
                <xsl:value-of select="@pageNr"/>
                <xsl:text>]</xsl:text>
            </xsl:if>
            <xsl:text>{</xsl:text>
            <xsl:value-of select="elml:transform_key(@bibIDRef)" disable-output-escaping="yes"/>
            <xsl:text>} </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:furtherReading">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:call-template name="elml:generate_Title"/>
            <xsl:choose>
                <xsl:when test="@sorting='off'">
                    <xsl:text>
                        \begin{itemize}
                    </xsl:text>
                    <xsl:apply-templates/>
                    <xsl:text>
                        \end{itemize}
                    </xsl:text>
                </xsl:when>
                <xsl:when test="@sorting='byYear'">
                    <xsl:text>
                        \begin{itemize}
                    </xsl:text>
                    <xsl:apply-templates>
                        <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@publicationYear" order="descending" lang="{$lang}"/>
                    </xsl:apply-templates>
                    <xsl:text>
                        \end{itemize}
                    </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>
                    \begin{itemize}
                </xsl:text>
                    <xsl:apply-templates>
                        <xsl:sort select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@author" order="ascending" lang="{$lang}"/>
                    </xsl:apply-templates>
                    <xsl:text>
                        \end{itemize}
                    </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:resItem">
        <xsl:text>
            \item \textsc{</xsl:text>
        <xsl:choose>
            <xsl:when test="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@author">
                <xsl:value-of select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@author"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$name_anon"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>}</xsl:text>
        <xsl:if test="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@publicationYear">
            <xsl:text>, </xsl:text>
            <xsl:value-of select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@publicationYear"/>
        </xsl:if>
        <xsl:text> \textit{</xsl:text>
        <xsl:choose>
            <xsl:when test="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@titleOfContribution">
                <xsl:value-of select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@titleOfContribution"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="/elml:lesson/elml:bibliography/*[@bibID=current()/@bibIDRef]/@title"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>}  \cite</xsl:text>
        <xsl:if test="text()">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </xsl:if>
        <xsl:text>{</xsl:text>
        <xsl:value-of select="elml:transform_key(@bibIDRef)" disable-output-escaping="yes"/>
        <xsl:text>} </xsl:text>
    </xsl:template>
    <xsl:template match="elml:bibliography"/>
    <xsl:template match="elml:bibliography" mode="multiple">
        <xsl:for-each select="node()">
            <xsl:if test="@bibID">
                <xsl:text>
                \nocite{</xsl:text>
                <xsl:value-of select="elml:transform_key(@bibID)" disable-output-escaping="yes"/>
                <xsl:text>}
            </xsl:text>
            </xsl:if>
        </xsl:for-each>
        <xsl:if test="$pagebreak_level='unit' or $pagebreak_level='lo'">
            <xsl:text>
                \clearpage
            </xsl:text>
        </xsl:if>
        <xsl:text>
            \bibliographystyle{plain}
            \bibliography{</xsl:text>
        <xsl:value-of select="/elml:lesson/@label"/>
        <xsl:text>}
            \addcontentsline{toc}{</xsl:text>
        <xsl:choose>
            <xsl:when test="$documentclass='book'">
                <xsl:text>chapter</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>section</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>}{</xsl:text>
        <xsl:call-template name="elml:Kapitel"/>
        <xsl:text>}
        </xsl:text>
        <xsl:result-document href="{$pathRoot}/{$transformlesson_label}/{$lang}/latex/{/elml:lesson/@label}.bib" format="latex">
            <xsl:choose>
                <xsl:when test="$multiple='on'">
                    <xsl:for-each select="document($config_file)/elml:config/elml:modules/elml:course[child::node()=$transformlesson_label]/elml:labelname">
                        <xsl:apply-templates select="document(concat(substring-before($config_file,'_config'),text(),'/',$lang,'/text/',text(),'.xml'))/elml:lesson/elml:bibliography/*"/>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:result-document>
    </xsl:template>
    <!-- ***** "Paragraph" Elements like colum, table, multimedia, link etc. *****-->
    <xsl:template match="elml:column">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:choose>
                <xsl:when test="descendant::node()/name()='table' or descendant::node()/name()='multimedia'">
                    <xsl:for-each select="child::node()">
                        <xsl:apply-templates/>
                        <xsl:text>
                        \par
                    </xsl:text>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>
                \begin{multicols}</xsl:text>
                    <xsl:choose>
                        <xsl:when test="elml:columnMiddle">
                            <xsl:text>{3}
                            {</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>{2}
                            {</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:call-template name="elml:Label"/>
                    <xsl:apply-templates/>
                    <xsl:text>}
                    \end{multicols}
                </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:columnLeft | elml:columnMiddle">
        <xsl:apply-templates/>
        <xsl:text>
            \textcolor{white}{ } \columnbreak \newline
        </xsl:text>
    </xsl:template>
    <xsl:template match="elml:columnRight">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="elml:table | elml:list | elml:popup | elml:box | elml:term | elml:paragraph | elml:citation | elml:multimedia">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:if test="@title and not(name()='table')">
                <xsl:call-template name="elml:generate_Title"/>
                <xsl:text>
					\textcolor{white}{.} \par
				</xsl:text>
            </xsl:if>
            <xsl:apply-templates select="." mode="icon"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:columncreate">
        <xsl:param name="columnamount"/>
        <xsl:param name="columnwidth"/>
        <xsl:text>|</xsl:text>
        <xsl:choose>
            <xsl:when test="@align='left'">
                <xsl:text>L</xsl:text>
            </xsl:when>
            <xsl:when test="@align='center'">
                <xsl:text>C</xsl:text>
            </xsl:when>
            <xsl:when test="@align='right'">
                <xsl:text>R</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>L</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="@width and not(@units='percent')">
                <xsl:text>{</xsl:text>
                <xsl:value-of select="@width * $converter_pixel_mm"/>
                <xsl:text>mm}</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <!--				<xsl:value-of select="$columnamount"/>
-->
                <xsl:text>{</xsl:text>
                <!--				<xsl:value-of select="1 div 1 + count(./elml:tablerow[1]/child::node())"/>
				<xsl:text>\linewidth}</xsl:text>
-->
                <xsl:value-of select="$columnwidth"/>
                <!--<xsl:value-of select="$columnwidth * $converter_pixel_mm"/>-->
                <!--<xsl:text>cm}</xsl:text>		-->
                <xsl:text>cm}</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <!--		<xsl:if test="@width and not(@units='percent')">
			<xsl:text>{</xsl:text>
			<xsl:value-of select="@width * $converter_pixel_mm"/>
			<xsl:text>mm}</xsl:text>
		</xsl:if> 
		<xsl:if test="@units='percent'">
			<xsl:text>{</xsl:text>
			<xsl:value-of select="$columnwidth * $converter_pixel_mm"/>
			<xsl:text>mm}</xsl:text>
		</xsl:if> 
-->
        <xsl:if test="not($columnamount=1)">
            <xsl:call-template name="elml:columncreate">
                <xsl:with-param name="columnamount" select="$columnamount - 1"/>
                <xsl:with-param name="columnwidth" select="$columnwidth"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:table" mode="icon">
        <xsl:param name="columnwidth" select="$textwidth div count(./elml:tablerow[1]/child::node())"/>
        <xsl:text>
				\par
                \begin{longtable}{</xsl:text>
        <xsl:for-each select="elml:tablerow[1]/*">
            <xsl:choose>
                <xsl:when test="@colspan">
                    <xsl:call-template name="elml:columncreate">
                        <xsl:with-param name="columnamount" select="@colspan"/>
                        <xsl:with-param name="columnwidth" select="$columnwidth"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="elml:columncreate">
                        <xsl:with-param name="columnamount" select="1"/>
                        <xsl:with-param name="columnwidth" select="$columnwidth"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <xsl:text>|}</xsl:text>
        <xsl:text>\hline
		\endhead
        </xsl:text>
        <xsl:choose>
            <xsl:when test="@title and @legend">
                <xsl:text>
                    \caption[</xsl:text>
                <xsl:value-of select="@legend"/>
                <xsl:text>]{</xsl:text>
                <xsl:value-of select="@title"/>
                <xsl:text>: </xsl:text>
                <xsl:value-of select="@legend"/>
                <xsl:if test="@bibIDRef">
                    <xsl:text> \protect</xsl:text>
                    <xsl:call-template name="elml:BibliographyRef"/>
                </xsl:if>
                <xsl:text>}
                </xsl:text>
            </xsl:when>
            <xsl:when test="@legend">
                <xsl:text>
                    \caption[</xsl:text>
                <xsl:value-of select="@legend"/>
                <xsl:text>]{</xsl:text>
                <xsl:value-of select="@legend"/>
                <xsl:if test="@bibIDRef">
                    <xsl:text> \protect</xsl:text>
                    <xsl:call-template name="elml:BibliographyRef"/>
                </xsl:if>
                <xsl:text>}
                </xsl:text>
            </xsl:when>
            <xsl:when test="@title">
                <xsl:text>
                    \caption[</xsl:text>
                <xsl:value-of select="@title"/>
                <xsl:text>]{</xsl:text>
                <xsl:value-of select="@title"/>
                <xsl:if test="@bibIDRef">
                    <xsl:text> \protect</xsl:text>
                    <xsl:call-template name="elml:BibliographyRef"/>
                </xsl:if>
                <xsl:text>}
                </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>
                    \caption[</xsl:text>
                <xsl:value-of select="$name_nolegend"/>
                <xsl:text>]{</xsl:text>
                <xsl:value-of select="$name_nolegend"/>
                <xsl:if test="@bibIDRef">
                    <xsl:text> \protect</xsl:text>
                    <xsl:call-template name="elml:BibliographyRef"/>
                </xsl:if>
                <xsl:text>}
                </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="elml:Label"/>
        <xsl:text>
			\endfoot
        </xsl:text>
        <xsl:apply-templates mode="#default"/>
        <xsl:text>
			\end{longtable}
		</xsl:text>
    </xsl:template>
    <!-- **** Template definition for the element "tablerow" *****-->
    <xsl:template match="elml:tablerow">
        <!--		<xsl:if test="elml:tableheading"> \rowcolor{tableHeadercolor} </xsl:if>-->
        <xsl:apply-templates/>
        <xsl:text>\\ \hline		
		</xsl:text>
    </xsl:template>
    <!-- **** Template definition for the element "tableheading" *****-->
    <xsl:template match="elml:tableheading">
        <xsl:param name="columnwidth" select="$textwidth div count(../../elml:tablerow[1]/child::node())"/>
        <xsl:if test="@colspan">
            <xsl:text>\multicolumn{</xsl:text>
            <xsl:value-of select="@colspan"/>
            <xsl:text>}{|p{</xsl:text>
            <xsl:value-of select="$columnwidth * @colspan"/>
            <xsl:text>cm}|}{</xsl:text>
        </xsl:if>
        <xsl:if test="@rowspan">
            <xsl:text>\multirow{</xsl:text>
            <xsl:value-of select="@rowspan"/>
            <xsl:text>}{*}{</xsl:text>
        </xsl:if>
        <xsl:text> \bfseries </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> \mdseries </xsl:text>
        <xsl:if test="@rowspan or @colspan">
            <xsl:text>}</xsl:text>
        </xsl:if>
        <xsl:if test="not(position()=last())">
            <xsl:text disable-output-escaping="yes">
				&amp;
			</xsl:text>
        </xsl:if>
    </xsl:template>
    <!-- **** Template definition for the element "tabledata" *****-->
    <xsl:template match="elml:tabledata">
        <xsl:param name="columnwidth" select="$textwidth div count(../../elml:tablerow[1]/child::node())"/>
        <xsl:if test="@colspan">
            <!--			<xsl:text>\multicolumn{</xsl:text>
			<xsl:value-of select="@colspan"/>
			<xsl:text>}{|p{</xsl:text>
			<xsl:value-of select="$columnwidth * @colspan"/>
			<xsl:text>cm}|}{</xsl:text>-->
            <xsl:text>\multicolumn{</xsl:text>
            <xsl:value-of select="@colspan"/>
            <xsl:text>}{|C{</xsl:text>
            <xsl:value-of select="$columnwidth * @colspan"/>
            <xsl:text>cm}|}{</xsl:text>
        </xsl:if>
        <xsl:if test="@rowspan">
            <xsl:text>\multirow{</xsl:text>
            <xsl:value-of select="@rowspan"/>
            <xsl:text>}{*}{</xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:if test="@rowspan or @colspan">
            <xsl:text>}</xsl:text>
        </xsl:if>
        <xsl:if test="not(position()=last())">
            <xsl:text disable-output-escaping="yes">
				&amp;
			</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:list" mode="icon">
        <xsl:choose>
            <xsl:when test="@listStyle='ordered'">
                <xsl:text>
					\begin{enumerate}
				</xsl:text>
                <xsl:call-template name="elml:Label"/>
                <xsl:apply-templates mode="#default"/>
                <xsl:text>
					\end{enumerate}
				</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>
					\begin{itemize}
				</xsl:text>
                <xsl:call-template name="elml:Label"/>
                <xsl:apply-templates mode="#default"/>
                <xsl:text>
					\end{itemize}
				</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="elml:Legend"/>
    </xsl:template>
    <xsl:template match="elml:item">
        <xsl:text>
			\item </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="elml:popup | elml:box" mode="icon">
        <xsl:call-template name="elml:Label"/>
        <xsl:text>
			\begin{boxedminipage}[h]{\linewidth}
		</xsl:text>
        <xsl:apply-templates mode="#default"/>
        <xsl:text>
			\end{boxedminipage}
</xsl:text>
    </xsl:template>
    <xsl:template match="elml:term" mode="icon">
        <xsl:param name="id" select="@glossRef"/>
        <xsl:param name="term">
            <xsl:choose>
                <xsl:when test="text()">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="/elml:lesson/elml:glossary/elml:definition[@term=$id]/@term"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="((boolean(name(preceding-sibling::node()[1])) or boolean(name(following-sibling::node()[1]))) and not(../text())) or (count(../*)=number('1') and     (name(parent::node())='look' or name(parent::node())='act' or name(parent::node())='clarify'))">
                <xsl:if test="not(name(preceding-sibling::*[1])='term')">
                    <xsl:text>
                        \begin{description}
                    </xsl:text>
                </xsl:if>
                <xsl:apply-templates select="/elml:lesson/elml:glossary/elml:definition[@term=$id]" mode="#default">
                    <xsl:with-param name="term" select="$term"/>
                </xsl:apply-templates>
                <xsl:if test="not(name(following-sibling::*[1])='term')">
                    <xsl:text>
                        \end{description}
                    </xsl:text>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\textit{</xsl:text>
                <xsl:call-template name="elml:Label"/>
                <xsl:value-of select="$term"/>
                <xsl:text>}</xsl:text>
                <xsl:text>\index{</xsl:text>
                <xsl:value-of select="$term"/>
                <xsl:text>}</xsl:text>
                <xsl:if test="not(preceding::elml:term[@glossRef=$id])">
                    <xsl:text>\footnote{</xsl:text>
                    <xsl:value-of select="/elml:lesson/elml:glossary/elml:definition[@term=$id]"/>
                    <xsl:text>}</xsl:text>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:annotation">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:if test="$display='yes'">
            <xsl:call-template name="elml:Label"/>
            <xsl:apply-templates/>
            <xsl:text>
            \par
        </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:paragraph" mode="icon">
        <xsl:call-template name="elml:Label"/>
        <xsl:apply-templates mode="#default"/>
        <xsl:text>
            \par
        </xsl:text>
    </xsl:template>
    <xsl:template match="elml:newLine">
        <xsl:choose>
            <xsl:when test="@space='long'">
                <xsl:text>\par
				</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\par
				</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:formatted">
        <xsl:choose>
            <xsl:when test="@style='bold'">
                <xsl:text> \textbf{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:when test="@style='subscript'">
                <xsl:text disable-output-escaping="yes">$_{</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text disable-output-escaping="yes">}$</xsl:text>
            </xsl:when>
            <xsl:when test="@style='superscript'">
                <xsl:text disable-output-escaping="yes">$^{</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text disable-output-escaping="yes">}$</xsl:text>
            </xsl:when>
            <xsl:when test="@style='italic'">
                <xsl:text> \textit{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:when test="@style='underlined'">
                <xsl:text> \underline{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:when test="@style='crossedOut'">
                <xsl:text> \st{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:when test="@style='upperCase'">
                <xsl:text> \MakeUppercase{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:when test="@style='lowerCase'">
                <xsl:text> \MakeLowercase{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:when test="@style='code'">
                <xsl:text> \texttt{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text> </xsl:text>
    </xsl:template>
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
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:text>unit</xsl:text>
                            <xsl:value-of select="@targetLabel"/>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:when>
                        <xsl:when test="name(//*[@label=$label])='learningObject'">
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:value-of select="//*[@label=$label]/../@label"/>
                            <xsl:value-of select="@targetLabel"/>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:when>
                        <xsl:when test="@targetLabel">
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:value-of select="//*[@label=$label]/../@label"/>
                            <xsl:value-of select="@targetLabel"/>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="/elml:lesson/@label"/>
                            <xsl:text>index</xsl:text>
                            <xsl:value-of select="$filename_suffix"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="((boolean(name(preceding-sibling::node()[1])) or boolean(name(following-sibling::node()[1]))) and not(../text())) or (count(../*)=number('1') and (name(parent::node())='look' or name(parent::node())='act' or name(parent::node())='clarify'))">
                <xsl:text>
					\par
				</xsl:text>
                <xsl:choose>
                    <xsl:when test="not((@role='student') or (@role=$role) or (not (@role))) or $display_links='no'">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="starts-with($TempURL, 'http') or starts-with($TempURL, 'mailto:')">
                                <xsl:apply-templates/>
                                <xsl:text>: \url{</xsl:text>
                                <xsl:value-of select="replace($TempURL,'http://','')"/>
                                <xsl:text>} </xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates/>
                                <xsl:text>: </xsl:text>
                                <xsl:value-of select="$name_page"/>
                                <xsl:text disable-output-escaping="yes">~</xsl:text>
                                <xsl:text>\pageref{</xsl:text>
                                <xsl:value-of select="replace($TempURL, '_','')" disable-output-escaping="yes"/>
                                <xsl:text>}. </xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="@size or @type or @legend">
                    <xsl:text> (</xsl:text>
                    <xsl:if test="@legend">
                        <xsl:value-of select="@legend"/>
                    </xsl:if>
                    <xsl:if test="@size or @type">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:if test="@size">
                        <xsl:value-of select="$name_size"/>
                        <xsl:text disable-output-escaping="yes">:~</xsl:text>
                        <xsl:value-of select="@size"/>
                        <xsl:if test="@type">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="@type">
                        <xsl:value-of select="$name_type"/>
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="@type"/>
                    </xsl:if>
                    <xsl:text>)</xsl:text>
                </xsl:if>
                <xsl:text>
					\par
				</xsl:text>
            </xsl:when>
            <xsl:when test="not((@role='student') or (@role=$role) or (not (@role))) or $display_links='no'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="starts-with($TempURL, 'http') or starts-with($TempURL, 'mailto:')">
                        <xsl:apply-templates/>
                        <xsl:text> (\url{</xsl:text>
                        <xsl:value-of select="replace($TempURL,'http://','')"/>
                        <xsl:text>})</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="$name_page"/>
                        <xsl:text disable-output-escaping="yes">~</xsl:text>
                        <xsl:text>\pageref{</xsl:text>
                        <xsl:value-of select="replace($TempURL, '_','')" disable-output-escaping="yes"/>
                        <xsl:text>})</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="$display_links='yes' and (@size or @type or @legend)">
                    <xsl:text>{\footnotesize </xsl:text>
                    <xsl:text> </xsl:text>
                    <xsl:if test="@legend">
                        <xsl:value-of select="@legend"/>
                        <xsl:text>. </xsl:text>
                    </xsl:if>
                    <xsl:if test="@size">
                        <xsl:value-of select="$name_size"/>
                        <xsl:text disable-output-escaping="yes">:~</xsl:text>
                        <xsl:value-of select="@size"/>
                        <xsl:text>. </xsl:text>
                    </xsl:if>
                    <xsl:if test="@type">
                        <xsl:value-of select="$name_type"/>
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="@type"/>
                        <xsl:text>. </xsl:text>
                    </xsl:if>
                    <xsl:text>}</xsl:text>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:image_width_height">
        <xsl:choose>
            <xsl:when test="@units='percent' and @width">
                <xsl:value-of select="@width / 100"/>
                <xsl:text>\linewidth,</xsl:text>
            </xsl:when>
            <xsl:when test="@width and ((@width * $converter_pixel_mm) &lt; (textwidth * 10))">
                <xsl:value-of select="@width * $converter_pixel_mm"/>
                <xsl:text>mm,</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0.8\linewidth,</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:selfCheck">
        <xsl:if test="@title">
            <xsl:call-template name="elml:generate_Title"/>
            <xsl:text>
                \textcolor{white}{.} \par
            </xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="elml:multipleChoice">
        <xsl:apply-templates select="elml:question"/>
        <xsl:text>
            \begin{itemize} 
        </xsl:text>
        <xsl:call-template name="elml:Label"/>
        <xsl:apply-templates select="elml:answer"/>
        <!-- Shuffle not implemented yet -->
        <xsl:text>
            \end{itemize} 
        </xsl:text>
        <xsl:apply-templates select="elml:solution"/>
    </xsl:template>
    <xsl:template match="elml:fillInBlanks">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="elml:question">
        <xsl:choose>
            <xsl:when test="name(parent::node())='multipleChoice'">
                <xsl:text>
                    \textbf{\textit{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}}
                </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:answer">
        <xsl:param name="itemicon">
            <xsl:text> \ding{&#xE004;</xsl:text>
            <xsl:choose>
                <xsl:when test="($role='tutor') and (@correct='yes')">33</xsl:when>
                <xsl:when test="$role='tutor'">37</xsl:when>
                <xsl:when test="count(../elml:answer[@correct='yes'])=1">6D</xsl:when>
                <xsl:otherwise>6F</xsl:otherwise>
            </xsl:choose>
            <xsl:text>} </xsl:text>
        </xsl:param>
        <xsl:text>
            \item[</xsl:text>
        <xsl:value-of select="$itemicon"/>
        <xsl:text>] </xsl:text>
        <xsl:apply-templates/>
        <xsl:if test="@feedback!='' and $role='tutor'">
            <xsl:text> \ding{&#xE004;DE} </xsl:text>
            <xsl:value-of select="$name_hint"/>
            <xsl:text>: </xsl:text>
            <xsl:value-of select="@feedback"/>
        </xsl:if>
        <xsl:text>
        </xsl:text>
    </xsl:template>
    <xsl:template match="elml:gapText">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="elml:gap">
        <xsl:choose>
            <xsl:when test="$role='tutor'">
                <xsl:text> \textit{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> ___________ </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:solution">
        <xsl:if test="$role='tutor'">
            <xsl:text> \ding{&#xE004;2B} </xsl:text>
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="elml:multimedia" mode="icon">
        <xsl:choose>
            <xsl:when test="@type='gif_doesnotwork'">
                <xsl:text disable-output-escaping="yes">
					\DeclareGraphicsRule{.gif}{eps}{*}{'convert #1 eps:#1.ps } 	</xsl:text>
                <xsl:text>				
					\includegraphics[width=0.8\linewidth,keepaspectratio=true]{</xsl:text>
                <xsl:value-of select="@src" disable-output-escaping="yes"/>
                <xsl:text>.ps}
				</xsl:text>
            </xsl:when>
            <xsl:when test="(@type='jpeg') or (@type='png') or ends-with(@thumbnail, 'jpg') or ends-with(@thumbnail, 'png')">
                <xsl:if test="not((ancestor::node()/name()='popup') or (ancestor::node()/name()='box') or (ancestor::node()/name()='table'))">
                    <xsl:text>\begin{figure}[hbt]
				    </xsl:text>
                </xsl:if>
                <xsl:text>\begin{center}
					\includegraphics[width=</xsl:text>
                <xsl:call-template name="elml:image_width_height"/>
                <xsl:text>height=0.8\textheight,keepaspectratio=true]{</xsl:text>
                <xsl:choose>
                    <xsl:when test="(@type='jpeg') or (@type='png')">
                        <xsl:value-of select="$pathRoot"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="/elml:lesson/@label"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$lang"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="substring-after(@src, '../')" disable-output-escaping="yes"/>
                        <xsl:text>}
						</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(@thumbnail, 'jpg') or ends-with(@thumbnail, 'png')">
                        <xsl:value-of select="$pathRoot"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="/elml:lesson/@label"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$lang"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="substring-after(@thumbnail, '../')" disable-output-escaping="yes"/>
                        <xsl:text>}
						</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:text>\end{center}
                </xsl:text>
                <xsl:call-template name="elml:multimediaLegend"/>
                <xsl:if test="not((ancestor::node()/name()='popup') or (ancestor::node()/name()='box') or (ancestor::node()/name()='table'))">
                    <xsl:text>\end{figure}
                    </xsl:text>
                </xsl:if>
            </xsl:when>
            <xsl:when test="(ancestor::node()/name()='popup') or (ancestor::node()/name()='box') or (ancestor::node()/name()='table')">
                <xsl:text>
                    \textbf{</xsl:text>
                <xsl:value-of select="$name_hint"/>
                <xsl:text>:}
                    \par
                </xsl:text>
                <xsl:value-of select="$name_notanimage"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="@legend"/>
                <xsl:text>
                    \par
                </xsl:text>
                <xsl:call-template name="elml:Label"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>
                    \begin{figure}[hbt]
					\begin{fhint}
					\colorbox{hintcolor}{\makebox[0.95\textwidth][l]{
                    {\large\textbf{\textcolor{white}{</xsl:text>
                <xsl:value-of select="$name_hint"/>
                <xsl:text>:}}}}{ }}
					\par
				</xsl:text>
                <xsl:value-of select="$name_notanimage"/>
                <xsl:text>
					\par
                    \end{fhint}</xsl:text>
                <xsl:call-template name="elml:multimediaLegend"/>
                <xsl:text>
					\end{figure}
				</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:multimediaLegend">
        <xsl:choose>
            <xsl:when test="not((ancestor::node()/name()='popup') or (ancestor::node()/name()='box') or (ancestor::node()/name()='table')) and @legend">
                <xsl:text>
                    \caption[</xsl:text>
                <xsl:value-of select="@legend"/>
                <xsl:text>]{</xsl:text>
                <xsl:value-of select="@legend"/>
                <xsl:if test="@bibIDRef">
                    <xsl:text> \protect</xsl:text>
                    <xsl:call-template name="elml:BibliographyRef"/>
                </xsl:if>
                <xsl:text>}
                </xsl:text>
                <xsl:call-template name="elml:Label"/>
            </xsl:when>
            <xsl:when test="not((ancestor::node()/name()='popup') or (ancestor::node()/name()='box') or (ancestor::node()/name()='table')) and (@src or @bibIDRef)">
                <xsl:text>
                    \caption[</xsl:text>
                <xsl:value-of select="tokenize(@src,'/')[last()]"/>
                <xsl:text>]{</xsl:text>
                <xsl:value-of select="tokenize(@src,'/')[last()]"/>
                <xsl:if test="@bibIDRef">
                    <xsl:text> \protect</xsl:text>
                    <xsl:call-template name="elml:BibliographyRef"/>
                </xsl:if>
                <xsl:text>}
                </xsl:text>
                <xsl:call-template name="elml:Label"/>
            </xsl:when>
            <xsl:when test="not((ancestor::node()/name()='popup') or (ancestor::node()/name()='box') or (ancestor::node()/name()='table')) and not(@legend)">
                <xsl:text>
                    \caption[</xsl:text>
                <xsl:value-of select="$name_nolegend"/>
                <xsl:text>]{</xsl:text>
                <xsl:value-of select="$name_nolegend"/>
                <xsl:if test="@bibIDRef">
                    <xsl:text> \protect</xsl:text>
                    <xsl:call-template name="elml:BibliographyRef"/>
                </xsl:if>
                <xsl:text>}
                </xsl:text>
                <xsl:call-template name="elml:Label"/>
            </xsl:when>
            <xsl:when test="@legend">
                <xsl:text>\begin{center}
                </xsl:text>
                <xsl:value-of select="@legend"/>
                <xsl:text>\end{center}
                </xsl:text>
                <xsl:call-template name="elml:Label"/>
            </xsl:when>
            <xsl:when test="@bibIDRef">
                <xsl:text>\begin{center}
                </xsl:text>
                <xsl:value-of select="$name_nolegend"/>
                <xsl:text> </xsl:text>
                <xsl:call-template name="elml:BibliographyRef"/>
                <xsl:text>\end{center}
                </xsl:text>
                <xsl:call-template name="elml:Label"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:citation" mode="icon">
        <xsl:choose>
            <xsl:when test="not(node())">
                <xsl:call-template name="elml:BibliographyRef"/>
            </xsl:when>
            <xsl:when test="((boolean(name(preceding-sibling::node()[1])) or boolean(name(following-sibling::node()[1]))) and not(../text())) or (count(../*)=number('1') and     (name(parent::node())='look' or name(parent::node())='act' or name(parent::node())='clarify'))">
                <xsl:call-template name="elml:Label"/>
                <xsl:text>
                    \begin{quote}
                    ''\itshape </xsl:text>
                <xsl:apply-templates mode="#default"/>
                <xsl:text>\normalfont'' </xsl:text>
                <xsl:call-template name="elml:BibliographyRef"/>
                <xsl:text>
                    \end{quote}
                </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="elml:Label"/>
                <xsl:choose>
                    <xsl:when test="@yearOnly='yes'">
                        <xsl:call-template name="elml:BibliographyRef"/>
                        <xsl:text> ''\itshape </xsl:text>
                        <xsl:apply-templates mode="#default"/>
                        <xsl:text>\normalfont'' </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> ''\itshape </xsl:text>
                        <xsl:apply-templates mode="#default"/>
                        <xsl:text>\normalfont'' </xsl:text>
                        <xsl:call-template name="elml:BibliographyRef"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="elml:indexItem">
        <xsl:text>\textit{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}\index{</xsl:text>
        <xsl:choose>
            <xsl:when test="@affiliatedTo">
                <xsl:value-of select="@affiliatedTo"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@mainEntry='yes'">
            <xsl:text>|textbf</xsl:text>
        </xsl:if>
        <xsl:text>}</xsl:text>
    </xsl:template>
    <!-- ***** General Functions used in various templates *****-->
    <xsl:template name="elml:display">
        <xsl:choose>
            <xsl:when test="((@role='student') or (@role=$role) or (not (@role))) and not(@visible='online') and not(@visible='none')">
                <xsl:text>yes</xsl:text>
            </xsl:when>
            <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="elml:Alignment">
        <xsl:choose>
            <xsl:when test="@align='center'">
                <xsl:text>c</xsl:text>
            </xsl:when>
            <xsl:when test="@align='left'">
                <xsl:text>l</xsl:text>
            </xsl:when>
            <xsl:when test="@align='right'">
                <xsl:text>r</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>l</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
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
                    <xsl:text>unit</xsl:text>
                    <xsl:value-of select="@label"/>
                </xsl:when>
                <xsl:when test="name(.)='lesson'">
                    <xsl:text>index</xsl:text>
                </xsl:when>
                <xsl:when test="@label">
                    <xsl:value-of select="../@label"/>
                    <xsl:value-of select="@label"/>
                </xsl:when>
                <xsl:when test="name()='glossary'">
                    <xsl:value-of select="../@label"/>
                    <xsl:text>glossary</xsl:text>
                </xsl:when>
                <xsl:when test="name()='index'">
                    <xsl:value-of select="../@label"/>
                    <xsl:text>index</xsl:text>
                </xsl:when>
                <xsl:when test="name()='bibliography'">
                    <xsl:value-of select="../@label"/>
                    <xsl:text>bibliography</xsl:text>
                </xsl:when>
                <xsl:when test="name()='metadata'">
                    <xsl:value-of select="../@label"/>
                    <xsl:text>metadata</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="../@label"/>
                    <xsl:value-of select="name(.)"/>
                    <xsl:if test="name(.)='learningObject' or name(.)='selfAssessment' ">
                        <xsl:number level="single" count="elml:selfAssessment | elml:learningObject"/>
                    </xsl:if>
                    <xsl:if test="name(.)='entry' and (preceding-sibling::node()[1]/name()='entry' or preceding-sibling::node()[2]/name()='entry')">
                        <xsl:number level="single" count="elml:entry"/>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="$filename_suffix"/>
        </xsl:param>
        <xsl:value-of select="replace(string(concat(/elml:lesson/@label,$Label_param_temp[1],$Label_param_temp[2],$Label_param_temp[3],$Label_param_temp[4],$Label_param_temp[5],$Label_param_temp[6],$Label_param_temp[7],$Label_param_temp[8])), '_','')"/>
    </xsl:template>
    <xsl:template name="elml:Label">
        <xsl:if test="@label or name(.)='entry' or name(.)='goals' or name(.)='summary' or name(.)='furtherReading' or name(.)='learningObject' or name(.)='selfAssessment' or name(.)='bibliography' or name(.)='glossary' or name(.)='index' or name(.)='metadata' ">
            <xsl:text>\label{</xsl:text>
            <xsl:call-template name="elml:Label_param"/>
            <xsl:text>}
			</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:Kapitel">
        <xsl:param name="isnavigation"/>
        <xsl:choose>
            <xsl:when test="($isnavigation='yes') and (@navTitle)">
                <xsl:value-of select="@navTitle"/>
            </xsl:when>
            <xsl:when test="@title">
                <xsl:value-of select="@title"/>
            </xsl:when>
            <xsl:when test="name()='index'">
                <xsl:value-of select="$name_index"/>
            </xsl:when>
            <xsl:when test="name()='glossary'">
                <xsl:value-of select="$name_glossary"/>
            </xsl:when>
            <xsl:when test="name()='entry'">
                <xsl:value-of select="$name_entry"/>
            </xsl:when>
            <xsl:when test="name()='index'">
                <xsl:value-of select="$name_index"/>
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
            <xsl:when test="name()='metadata'">
                <xsl:value-of select="$name_metadata"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>An ERROR occurred, please contact the webmaster! </xsl:text>
                <xsl:value-of select="$contact"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="(name()='unit') and contains($optional_units, @label)">
            <xsl:value-of select="$name_optionalunits_symbol"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="elml:Legend">
        <xsl:if test="@legend or @bibIDRef">
            <xsl:text>
			\textit{\footnotesize{</xsl:text>
            <xsl:value-of select="@legend"/>
            <xsl:call-template name="elml:BibliographyRef"/>
            <xsl:text>} }
			</xsl:text>
        </xsl:if>
    </xsl:template>
    <!-- ***** Templates used in the online but not the print version *****-->
    <xsl:template name="elml:navigation"/>
    <xsl:template name="elml:LayoutBodyContent"/>
    <xsl:template name="elml:prev_file"/>
    <xsl:template name="elml:next_file"/>
    <xsl:template name="elml:footer"/>
    <xsl:template name="elml:Label_param_withfilename"/>
</xsl:stylesheet>
