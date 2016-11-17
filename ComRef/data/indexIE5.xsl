<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/TR/WD-xsl"
	xmlns="http://www.w3.org/TR/REC-html40">

<xsl:template match="text()">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="*">
	<xsl:apply-templates/>
</xsl:template>

<!-- ignore all field but description -->
<xsl:template match="description">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="name | loper | roper | lopertype | ropertype"/>
<xsl:template match="returntype | example | since"/>

<!-- use f to link to other functions -->
<xsl:template match="f">
	<a>
		<xsl:attribute name="href">
			fullIE5.xml#<xsl:value-of select="."/>
		</xsl:attribute>
	<xsl:apply-templates/>
	</a>
</xsl:template>

<!-- use ar to link to arrays -->
<xsl:template match="ar">
	<a>
		<xsl:attribute name="href">
			#ar_<xsl:value-of select="."/>
		</xsl:attribute>
	<xsl:apply-templates/>
	</a>
</xsl:template>

<xsl:template match="indent">
	xx &#160;&#160;&#160; xx
</xsl:template>


<xsl:template match="/">
	<HTML>
	<HEAD>
		<TITLE><xsl:value-of select="/commandreference/comref/commandlist/name"/></TITLE>
	</HEAD>
	<BODY bgcolor="#ffffff">

	<!--Main TABLE -->
		
		
		<a name="commandindex"></a><h2>Commands</h2>
		<base target="full"/>
		
<!-- Command index -->
		
		<p>
		<xsl:for-each select="/commandreference/comref/commandlist/command">
			<a>
				<xsl:attribute name="href">
					fullIE5.xml#<xsl:value-of select="lopertype"/><xsl:value-of select="name"/><xsl:value-of select="ropertype"/>
				</xsl:attribute>
				<i><xsl:value-of select="loper"/></i>
				<xsl:value-of select="name"/>
				<i><xsl:value-of select="roper"/></i>
				<br/>
			</a>
		</xsl:for-each>
		</p>
<!-- Type reference -->
		<a name="typeindex"></a><h2>Types</h2>
		
		<p>
		<xsl:for-each select="/commandreference/comref/typelist/type">
			<a>
				<xsl:attribute name="href">
				fullIE5.xml#t_<xsl:value-of select="name"/></xsl:attribute>
				<xsl:value-of select="name"/>
			</a>
			<br/>
		</xsl:for-each>
		</p>

<!-- End of all references -->

		<a name="arrayindex"></a><h2>Common array formats</h2>
		
		<p>
		<xsl:for-each select="/commandreference/comref/arraylist/array">
			<a>
				<xsl:attribute name="href">
				fullIE5.xml#ar_<xsl:value-of select="name"/></xsl:attribute>
				<xsl:value-of select="name"/>
			</a>
			<br/>
		</xsl:for-each>
		</p>

	</BODY>
	</HTML>
</xsl:template>


</xsl:stylesheet>
