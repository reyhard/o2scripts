<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
			full.xml#<xsl:value-of select="."/>
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

<xsl:template match="@letter">
	<h3>
	<a>
		<xsl:attribute name="name">letter_<xsl:value-of select="."/></xsl:attribute>
	<xsl:value-of select="."/>
	</a>
	</h3>
</xsl:template>

<xsl:template match="/">
	<HTML>
	<HEAD>
		<TITLE><xsl:value-of select="/commandreference/commandlist/name"/></TITLE>
	</HEAD>
	<BODY bgcolor="#ffffff">

	<!--Main TABLE -->
		
		
		<a name="commandindex"></a><h2>Commands</h2>
		<base target="full"/>
		
<!-- Command index -->
		
		<p>
		<xsl:for-each select="/commandreference/commandlist/command">
			<xsl:variable name="prev" select="position()-1"/>
			<xsl:choose>
				<xsl:when test="position()=1">
					<xsl:apply-templates select="@letter"/>
				</xsl:when>
				<xsl:when test="../command[position()=$prev]/@letter!=@letter">
					<xsl:apply-templates select="@letter"/>
				</xsl:when>
			</xsl:choose>
			<a>
				<xsl:attribute name="href">
					full.xml#<xsl:value-of select="lopertype"/><xsl:value-of select="name"/><xsl:value-of select="ropertype"/>
				</xsl:attribute>
				<i><xsl:value-of select="loper"/></i>
				<xsl:text> </xsl:text>
				<xsl:value-of select="name"/>
				<xsl:text> </xsl:text>
				<i><xsl:value-of select="roper"/></i>
				<br/>
			</a>
		</xsl:for-each>
		</p>
<!-- Type reference -->
		<a name="typeindex"></a><h2>Types</h2>
		
		<p>
		<xsl:for-each select="/commandreference/typelist/type">
			<xsl:sort select="name"/>
			<a>
				<xsl:attribute name="href">
				full.xml#t_<xsl:value-of select="name"/></xsl:attribute>
				<xsl:value-of select="name"/>
			</a>
			<br/>
		</xsl:for-each>
		</p>

<!-- Array reference -->
		<a name="arrayindex"></a><h2>Common array formats</h2>
		
		<p>
		<xsl:for-each select="/commandreference/arraylist/array">
			<xsl:sort select="name"/>
			<a>
				<xsl:attribute name="href">
				full.xml#ar_<xsl:value-of select="name"/></xsl:attribute>
				<xsl:value-of select="name"/>
			</a>
			<br/>
		</xsl:for-each>
		</p>

<!-- Scripting topics -->
		<a name="scripting"></a><h2>Scripting topics</h2>
		
		<p>
		<xsl:for-each select="/commandreference/scripting/topic">
			<xsl:sort select="name"/>
			<a>
				<xsl:attribute name="href">
				full.xml#scr_<xsl:value-of select="name"/></xsl:attribute>
				<xsl:value-of select="name"/>
			</a>
			<br/>
		</xsl:for-each>
		</p>

<!-- Class names -->
		<a name="class"></a><h2>String values</h2>
		
		<p>
		<xsl:for-each select="/commandreference/classlist/class">
			<xsl:sort select="name"/>
			<a>
				<xsl:attribute name="href">
				full.xml#c_<xsl:value-of select="name"/></xsl:attribute>
				<xsl:value-of select="description"/>
			</a>
			<br/>
		</xsl:for-each>
		</p>

<!-- End of all references -->
	</BODY>
	</HTML>
</xsl:template>


</xsl:stylesheet>
