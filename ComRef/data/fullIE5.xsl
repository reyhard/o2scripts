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

<!-- ignore all field but description -->
<xsl:template match="description">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="name | loper | roper | lopertype | ropertype"/>
<xsl:template match="returntype | example | since | changed"/>

<!-- use f to link to other functions -->
<xsl:template match="f">
	<a>
		<xsl:attribute name="href">
			#<xsl:value-of select="."/>
		</xsl:attribute>
	<xsl:apply-templates/>
	</a>
</xsl:template>

<!-- use t to link to types -->
<xsl:template match="t">
	<a><xsl:attribute name="href">
	#t_<xsl:value-of select="."/>
	</xsl:attribute><xsl:apply-templates/></a>
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
<!-- Main Command reference -->
		<xsl:for-each select="/commandreference/comref/commandlist/command">
			<!-- Long ref (including type) -->
			<a>
				<xsl:attribute name="name"><xsl:value-of select="lopertype"/><xsl:value-of select="name"/><xsl:value-of select="ropertype"/></xsl:attribute>
			</a>
			<!-- Short ref (name only) -->
			<a>
				<xsl:attribute name="name"><xsl:value-of select="name"/></xsl:attribute>
			</a>
			<h3>
			<i><xsl:value-of select="loper"/></i>
			<xsl:value-of select="name"/>
			<i><xsl:value-of select="roper"/></i>
			</h3>
			<p>
				<xsl:if test="roper">
					<b>Operand types:</b>
					<xsl:if test="loper">
						<br/>&#160;&#160;&#160;
						<xsl:value-of select="loper"/>:
						<a>
							<xsl:attribute name="href">#t_<xsl:value-of select="lopertype"/></xsl:attribute>
							<xsl:value-of select="lopertype"/></a>
					</xsl:if>
					<xsl:if test="roper">
						<br/>&#160;&#160;&#160;
						<xsl:value-of select="roper"/>:
						<a>
							<xsl:attribute name="href">#t_<xsl:value-of select="ropertype"/></xsl:attribute>
							<xsl:value-of select="ropertype"/></a>
					</xsl:if>
					<br/>
				</xsl:if>
				<b>Type of returned value:</b><br/>&#160;&#160;&#160;
				<a><xsl:attribute name="href">#t_<xsl:value-of select="returntype"/></xsl:attribute>
					<xsl:value-of select="returntype"/></a>
				<br/>
				<xsl:if test="since">
					<b>Compatibility:</b><br/>&#160;&#160;&#160;
					Version <xsl:value-of select="since"/> required.<br/>
				</xsl:if>
				<br/>
				<b>Description:</b><br/>&#160;&#160;&#160;
				<xsl:apply-templates/>
				<xsl:if test="example">
					<br/><br/><b>Example:</b><br/>&#160;&#160;&#160;
					<i><xsl:value-of select="example"/></i>
				</xsl:if>
				<xsl:if test="exResult">
					, result is
					<i><xsl:value-of select="exResult"/></i>
				</xsl:if>
			</p>
			<hr/>
		</xsl:for-each>

	<hr/>
<!-- Type reference -->

		<p>
		<xsl:for-each select="/commandreference/comref/typelist/type">
			<a>
				<xsl:attribute name="name">t_<xsl:value-of select="name"/></xsl:attribute>
			</a>
			<h3><xsl:value-of select="name"/></h3>
			<b>Description:</b><br/>&#160;&#160;&#160;
			<xsl:value-of select="description"/>
			<br/>
			<hr/>
		</xsl:for-each>
		</p>
	<hr/>


<!-- Array reference -->

		<p>
		<xsl:for-each select="/commandreference/comref/arraylist/array">
			<a>
				<xsl:attribute name="name">ar_<xsl:value-of select="name"/></xsl:attribute>
			</a>
			<h3><xsl:value-of select="name"/></h3>
			<b>Format:</b><br/>&#160;&#160;&#160;
			<xsl:value-of select="format"/>
			<br/>
			<b>Description:</b><br/>&#160;&#160;&#160;
			<xsl:value-of select="description"/>
			<br/>
			<hr/>
		</xsl:for-each>
		</p>

<!-- End of all references -->

	</BODY>
	</HTML>
</xsl:template>


</xsl:stylesheet>
