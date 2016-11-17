<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="text()">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="*">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="command">
	<xsl:if test="
	since &gt; /commandreference/versionFrom
	and
	since &lt;= /commandreference/versionTo
	or
	changed &gt; /commandreference/versionFrom
	and
	changed &lt;= /commandreference/versionTo
	">
		<xsl:if test="since">
			<a>
				<xsl:attribute name="href">
					full.xml#<xsl:value-of select="lopertype"/><xsl:value-of select="name"/><xsl:value-of select="ropertype"/>
				</xsl:attribute>
				<i><xsl:value-of select="loper"/></i>
				<xsl:text> </xsl:text>
				<xsl:value-of select="name"/>
				<xsl:text> </xsl:text>
				<i><xsl:value-of select="roper"/></i>
			</a>
			Added in <i><xsl:value-of select="since"/></i>

			<br/>
		</xsl:if>
		<xsl:if test="changed">
			<a>
				<xsl:attribute name="href">
					full.xml#<xsl:value-of select="lopertype"/><xsl:value-of select="name"/><xsl:value-of select="ropertype"/>
				</xsl:attribute>
				<i><xsl:value-of select="loper"/></i>
				<xsl:text> </xsl:text>
				<xsl:value-of select="name"/>
				<xsl:text> </xsl:text>
				<i><xsl:value-of select="roper"/></i>
			</a>
			Changed in <i><xsl:value-of select="changed"/></i>
			<br/>
		</xsl:if>
	</xsl:if>
</xsl:template>

<xsl:template match="commandlist">
	<xsl:apply-templates select="command">
		<xsl:sort select="concat(changed,since)"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="name"/>
<xsl:template match="versionFrom | versionTo"/>
<xsl:template match="typelist | arraylist"/>

<xsl:template match="/">
	<HTML>
	<HEAD>
		<TITLE><xsl:value-of select="/commandreference/comref/commandlist/name"/></TITLE>
	</HEAD>
	<BODY bgcolor="#ffffff">
		Commands added or modified after
		<xsl:value-of select="/commandreference/versionFrom"/>
		:
	<!--Main TABLE -->
		
<!-- Command index -->
		<p>
		<base target="full"/>
		<xsl:apply-templates/>
		</p>

	</BODY>
	</HTML>
</xsl:template>


</xsl:stylesheet>
