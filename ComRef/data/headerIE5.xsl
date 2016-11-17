<?xml version="1.0"?>
<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/TR/WD-xsl"
 xmlns="http://www.w3.org/TR/REC-html40"
>

<xsl:template match="text()">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="*">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="header/name">
</xsl:template>

<xsl:template match="/">
<HTML>
<HEAD>
	<TITLE><xsl:value-of select="/header/name"/></TITLE>
</HEAD>
<BODY bgcolor="#ffffff">

<table>
<tr><td valign="top" width="220">

	<xsl:for-each select="/header/toc/tocentry">
		<a>
			<xsl:attribute name="href">indexIE5.xml#<xsl:value-of select="link"/></xsl:attribute>
			<xsl:attribute name="target">index</xsl:attribute>
			<xsl:value-of select="name"/>
		</a>
		<br/>
	</xsl:for-each>
</td>
<td>
	<base target="_blank"/>
	<h6><font size="2">
		<xsl:value-of select="/header/copyright"/>
	</font><br/>
	This document provides reference of all scripting commands
	<xsl:value-of select="/header/version"/>
	.
	<br/>Latest version of this document can be
	found at
	<a>
		<xsl:attribute name="href">
			http://
			<xsl:value-of select="/header/link"/>
		</xsl:attribute>
		<xsl:value-of select="/header/link"/>
	</a> in Editing section.
	</h6>
</td>
</tr>
</table>


</BODY>
</HTML>

</xsl:template>

</xsl:stylesheet>
