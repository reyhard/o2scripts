<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="text()">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="*">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="tocdoc/name">
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
	<xsl:for-each select="comref/commandlist/command">
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
		<xsl:when test="target">
			<a>
				<xsl:attribute name="href">
					<xsl:value-of select="link"/>
				</xsl:attribute>
				<xsl:attribute name="target">
					<xsl:value-of select="target"/>
				</xsl:attribute>
				<xsl:value-of select="name"/>
			</a>
			<br/>
		</xsl:when>
		<xsl:when test="commandreference">
			<xsl:apply-templates select="commandreference"/>
			<br/>
		</xsl:when>
		<xsl:when test="href">
			<a>
				<xsl:attribute name="href"><xsl:value-of select="href"/></xsl:attribute>
				<xsl:attribute name="target">index</xsl:attribute>
				<xsl:value-of select="name"/>
			</a>
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
	<TITLE><xsl:value-of select="/tocdoc/name"/></TITLE>
</HEAD>
<BODY bgcolor="#ffffff">
  <xsl:for-each select="/tocdoc/toc/tocentry">
    <xsl:apply-templates select="."/>
  </xsl:for-each>
  <hr/>
  Sort by: <a href="index.xml" target="index">name</a>, <a href="indexCategory.xml" target="index">category</a>
</BODY>
</HTML>

</xsl:template>

</xsl:stylesheet>
