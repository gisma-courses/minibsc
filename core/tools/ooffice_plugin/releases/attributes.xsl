<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
    xmlns:config="urn:oasis:names:tc:opendocument:xmlns:config:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
    xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
    xmlns:presentation="urn:oasis:names:tc:opendocument:xmlns:presentation:1.0"
    xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0"
    xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0"
    xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
    xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
    xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
    xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
    xmlns:anim="urn:oasis:names:tc:opendocument:xmlns:animation:1.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:xforms="http://www.w3.org/2002/xforms"
    xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
    xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
    xmlns:smil="urn:oasis:names:tc:opendocument:xmlns:smil-compatible:1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.elml.ch"
    exclude-result-prefixes="xsl office meta config text table draw presentation dr3d chart form
    script style number anim dc xlink math xforms fo svg smil">
    
    <!-- navTitle -->
    <xsl:template name="navTitle">
        <xsl:param name="navTitleNode"/>
        <xsl:if test="$navTitleNode/@office:string-value!=''">
        <xsl:attribute name="navTitle">
            <xsl:value-of select="$navTitleNode/@office:string-value"/>
        </xsl:attribute>
        </xsl:if>
    </xsl:template>
  
    <!-- label -->    
    <xsl:template name="label">
        <xsl:param name="labelNode"/>
        <xsl:if test="$labelNode/@text:name!=''">
        <xsl:attribute name="label">
            <xsl:value-of select="$labelNode/@text:name"/>
        </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- visible -->    
    <xsl:template name="visible">
        <xsl:param name="visibleNode"/>
        <xsl:if test="$visibleNode/@office:string-value!='all'">
            <xsl:attribute name="visible">
                <xsl:value-of select="$visibleNode/@office:string-value"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- sorting -->    
    <xsl:template name="sorting">
        <xsl:param name="sortingNode"/>
        <xsl:if test="$sortingNode/@office:string-value!='off'">
            <xsl:attribute name="sorting">
                <xsl:value-of select="$sortingNode/@office:string-value"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- style -->    
    <xsl:template name="style">
        <xsl:param name="style"/>
        <xsl:if test="$style!=''">
            <xsl:attribute name="style">
                <xsl:value-of select="$style"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- cssClass -->    
    <xsl:template name="cssClass">
        <xsl:param name="cssClass"/>
        <xsl:if test="$cssClass!=''">
            <xsl:attribute name="cssClass">
                <xsl:value-of select="$cssClass"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- listStyle -->    
    <xsl:template name="listStyle">
        <xsl:param name="listStyle"/>
        <xsl:if test="$listStyle='ordered'">
            <xsl:attribute name="listStyle">
                <xsl:text>ordered</xsl:text>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- label -->    
    <xsl:template name="simplelabel">
        <xsl:param name="label"/>
        <xsl:if test="$label!=''">
            <xsl:attribute name="label">
                <xsl:value-of select="$label"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- box title -->    
    <xsl:template name="boxTitle">
        <xsl:param name="boxTitle"/>
        <xsl:if test="$boxTitle!=''">
            <xsl:attribute name="title">
                <xsl:value-of select="$boxTitle"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- type -->    
    <xsl:template name="type">
        <xsl:param name="typeEnding"/>
        <xsl:if test="$typeEnding!=''">
            <xsl:variable name="newType">
                <xsl:choose>
                    <xsl:when test="$typeEnding='jpg'">
                        <xsl:text>jpeg</xsl:text>
                    </xsl:when>
                    <xsl:when test="$typeEnding='swf'">
                        <xsl:text>flash</xsl:text>
                    </xsl:when>
                    <xsl:when test="$typeEnding='mov'">
                        <xsl:text>quicktime</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$typeEnding"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:attribute name="type">
                <xsl:value-of select="$newType"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- legend -->    
    <xsl:template name="legend">
        <xsl:param name="legend"/>
        <xsl:if test="$legend!=''">
            <xsl:attribute name="legend">
                <xsl:value-of select="$legend"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- box title -->    
    <xsl:template name="alignment">
        <xsl:param name="align"/>
        <xsl:if test="$align!=''">
            <xsl:attribute name="align">
                <xsl:value-of select="$align"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- width -->    
    <xsl:template name="width">
        <xsl:param name="width"/>
        <xsl:if test="$width!=''">
            <xsl:attribute name="width">
                <xsl:value-of select="$width"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- height -->    
    <xsl:template name="height">
        <xsl:param name="height"/>
        <xsl:if test="$height!=''">
            <xsl:attribute name="height">
                <xsl:value-of select="$height"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- bibID -->    
    <xsl:template name="bibID">
        <xsl:param name="bibID"/>
        <xsl:if test="$bibID!=''">
            <xsl:attribute name="bibID">
                <xsl:value-of select="$bibID"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- author -->    
    <xsl:template name="author">
        <xsl:param name="author"/>
        <xsl:if test="$author!=''">
            <xsl:attribute name="author">
                <xsl:value-of select="$author"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- publicationYear -->    
    <xsl:template name="publicationYear">
        <xsl:param name="publicationYear"/>
        <xsl:if test="$publicationYear!=''">
            <xsl:attribute name="publicationYear">
                <xsl:value-of select="$publicationYear"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- bibTitle -->    
    <xsl:template name="bibTitle">
        <xsl:param name="bibTitle"/>
        <xsl:if test="$bibTitle!=''">
            <xsl:attribute name="title">
                <xsl:value-of select="$bibTitle"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- publisher -->    
    <xsl:template name="publisher">
        <xsl:param name="publisher"/>
        <xsl:if test="$publisher!=''">
            <xsl:attribute name="publisher">
                <xsl:value-of select="$publisher"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- publicationPlace -->    
    <xsl:template name="publicationPlace">
        <xsl:param name="publicationPlace"/>
        <xsl:if test="$publicationPlace!=''">
            <xsl:attribute name="publicationPlace">
                <xsl:value-of select="$publicationPlace"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- edition -->    
    <xsl:template name="edition">
        <xsl:param name="edition"/>
        <xsl:if test="$edition!=''">
            <xsl:attribute name="edition">
                <xsl:value-of select="$edition"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- contributionTitle -->    
    <xsl:template name="contributionTitle">
        <xsl:param name="contributionTitle"/>
        <xsl:if test="$contributionTitle!=''">
            <xsl:attribute name="titleOfContribution">
                <xsl:value-of select="$contributionTitle"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- journalTitle -->    
    <xsl:template name="journalTitle">
        <xsl:param name="journalTitle"/>
        <xsl:if test="$journalTitle!=''">
            <xsl:attribute name="journalTitle">
                <xsl:value-of select="$journalTitle"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- pageNr -->    
    <xsl:template name="pageNr">
        <xsl:param name="pageNr"/>
        <xsl:if test="$pageNr!=''">
            <xsl:attribute name="pageNr">
                <xsl:value-of select="$pageNr"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- volumeNr -->    
    <xsl:template name="volumeNr">
        <xsl:param name="volumeNr"/>
        <xsl:if test="$volumeNr!=''">
            <xsl:attribute name="volumeNr">
                <xsl:value-of select="$volumeNr"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- editor -->    
    <xsl:template name="editor">
        <xsl:param name="editor"/>
        <xsl:if test="$editor!=''">
            <xsl:attribute name="editor">
                <xsl:value-of select="$editor"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- url -->    
    <xsl:template name="url">
        <xsl:param name="url"/>
        <xsl:if test="$url!=''">
            <xsl:attribute name="url">
                <xsl:value-of select="$url"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- accessedDate -->    
    <xsl:template name="accessedDate">
        <xsl:param name="accessedDate"/>
        <xsl:if test="$accessedDate!=''">
            <xsl:attribute name="accessedDate">
                <xsl:value-of select="$accessedDate"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
 
</xsl:stylesheet>
