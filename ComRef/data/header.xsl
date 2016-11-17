<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="text()">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="*">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="header/name">
</xsl:template>

<xsl:template match="@letter">
	<a target="index">
		<xsl:attribute name="href">
			index.xml#letter_<xsl:value-of select="."/>
		</xsl:attribute>
	<xsl:value-of select="."/>
	</a>
</xsl:template>

<xsl:template match="commandreference">
	<!-- Alphabet index -->
	<font size="1">
	<xsl:for-each select="commandlist/command">
		<xsl:variable name="prev" select="position()-1"/>
		<xsl:choose>
			<xsl:when test="position()=1">
				<xsl:apply-templates select="@letter"/>
				<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:when test="../command[position()=$prev]/@letter!=@letter">
				<xsl:apply-templates select="@letter"/>
				<xsl:text> </xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:for-each>
	</font>

</xsl:template>

<xsl:template match="tocentry">
	<xsl:choose>
		<xsl:when test="commandreference">
			<xsl:apply-templates select="commandreference"/>
			<br/>
		</xsl:when>
		<xsl:when test="link">
			<a>
				<xsl:attribute name="href">index.xml#<xsl:value-of select="link"/></xsl:attribute>
				<xsl:attribute name="target">index</xsl:attribute>
				<xsl:value-of select="name"/>
			</a>
			<br/>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="/">
<HTML>
<HEAD>
	<TITLE><xsl:value-of select="/header/name"/></TITLE>
</HEAD>
<BODY bgcolor="#ffffff">

<base target="_blank"/>

<h3><xsl:value-of select="/header/name"/></h3>

<h5>
	<xsl:value-of select="/header/copyright"/>
	<xsl:text> </xsl:text>
	<a>
		<xsl:attribute name="href">
			http://
			<xsl:value-of select="/header/companyUrl"/>
		</xsl:attribute>
	<xsl:value-of select="/header/companyUrl"/>
	</a>
</h5>
<p>
This document provides reference of all scripting commands
<xsl:value-of select="/header/version"/>
.
</p>
<p>
Latest version of this document can be
found at
<a>
	<xsl:attribute name="href">
		http://
		<xsl:value-of select="/header/link"/>
	</xsl:attribute>
	<xsl:value-of select="/header/link"/>
</a> in Editing section.
</p>


</BODY>
</HTML>

</xsl:template>

</xsl:stylesheet>
