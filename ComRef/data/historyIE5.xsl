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

<xsl:template match="/">
	<HTML>
	<HEAD>
		<TITLE><xsl:value-of select="/commandreference/comref/commandlist/name"/></TITLE>
	</HEAD>
	<BODY bgcolor="#ffffff">
		Commands added or modified after
		<xsl:value-of select="/commandreference/comref/versionFrom"/>
		:
	<!--Main TABLE -->
		
<!-- Command index -->
		
		<p>
		<base target="full"/>
 		<xsl:for-each select="/commandreference/comref/commandlist/command">
			<xsl:if test="since">
				<a>
					<xsl:attribute name="href">
						fullIE5.xml#<xsl:value-of select="lopertype"/><xsl:value-of select="name"/><xsl:value-of select="ropertype"/>
					</xsl:attribute>
					<i><xsl:value-of select="loper"/></i>
					<xsl:value-of select="name"/>
					<i><xsl:value-of select="roper"/></i>
				</a>
				Added in <i><xsl:value-of select="since"/></i>

				<br/>
			</xsl:if>
			<xsl:if test="changed">
				<a>
					<xsl:attribute name="href">
						fullIE5.xml#<xsl:value-of select="lopertype"/><xsl:value-of select="name"/><xsl:value-of select="ropertype"/>
					</xsl:attribute>
					<i><xsl:value-of select="loper"/></i>
					<xsl:value-of select="name"/>
					<i><xsl:value-of select="roper"/></i>
				</a>
				Changed in <i><xsl:value-of select="changed"/></i>
				<br/>
			</xsl:if>
		</xsl:for-each>
		</p>

	</BODY>
	</HTML>
</xsl:template>


</xsl:stylesheet>
