<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="text()">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="*">
	<xsl:apply-templates/>
</xsl:template>

<!-- use f to link to other functions -->
<xsl:template match="f">
	<a>
		<xsl:attribute name="href">
			#<xsl:value-of select="."/>
		</xsl:attribute>
	<xsl:apply-templates/>
	</a>
</xsl:template>

<!-- use i and b to get simple formatting -->
<xsl:template match="i">
	<i><xsl:apply-templates/></i>
</xsl:template>

<xsl:template match="b">
	<b><xsl:apply-templates/></b>
</xsl:template>

<xsl:template match="br">
	<br/>&#160;&#160;&#160;
</xsl:template>

<xsl:template match="tab">
	&#160;&#160;&#160;
</xsl:template>

<xsl:template match="nibr">
	<br/>
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

<!-- use cl to link to classes -->
<xsl:template match="cl">
	<a>
		<xsl:attribute name="href">
			#c_<xsl:value-of select="."/>
		</xsl:attribute>
	<xsl:apply-templates/>
	</a>
</xsl:template>

<xsl:template match="/">
	<HTML>
	<HEAD>
		<TITLE><xsl:value-of select="/commandreference/commandlist/name"/></TITLE>
	</HEAD>
	<BODY bgcolor="#ffffff">

	<!--Main TABLE -->
	<xsl:apply-templates/>

	</BODY>
	</HTML>
</xsl:template>

<xsl:template match="commandlist">
	<xsl:apply-templates>
		<xsl:sort select="name"/>
	</xsl:apply-templates>
	<hr/>
</xsl:template>

<xsl:template match="typelist">
	<xsl:apply-templates>
		<xsl:sort select="name"/>
	</xsl:apply-templates>
	<hr/>
</xsl:template>

<xsl:template match="arraylist">
	<xsl:apply-templates>
		<xsl:sort select="name"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="scripting">
	<xsl:apply-templates>
		<xsl:sort select="name"/>
	</xsl:apply-templates>
</xsl:template>

<!-- define how each field is displayed -->
<xsl:template match="description">
	<b>Description:</b><br/>&#160;&#160;&#160;
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="since">
	<b>Compatibility:</b><br/>&#160;&#160;&#160;
	Version <xsl:value-of select="."/> required.<br/>
</xsl:template>

<xsl:template match="returntype">
	<b>Type of returned value:</b><br/>&#160;&#160;&#160;
	<a><xsl:attribute name="href">#t_<xsl:value-of select="."/></xsl:attribute>
		<xsl:value-of select="."/></a>
	<br/>
</xsl:template>

<xsl:template match="example">
	<br/><br/><b>Example:</b><br/>&#160;&#160;&#160;
	<i><xsl:value-of select="."/></i>
</xsl:template>

<xsl:template match="category">
	<br/><br/><b>Category:</b><br/>&#160;&#160;&#160;
	<i><xsl:value-of select="."/></i>
</xsl:template>


<xsl:template match="exResult">
	, result is <i><xsl:value-of select="."/></i>
</xsl:template>

<xsl:template match="changed">
	<!-- changed is currently not shown
	<b>Changed:</b><br/>&#160;&#160;&#160;
	Version <xsl:value-of select="."/><br/>
	-->
</xsl:template>

<xsl:template match="command/roper">
	<b>Operand types:</b>
	<xsl:if test="../loper">
		<br/>&#160;&#160;&#160;
		<xsl:value-of select="../loper"/>:
		<a>
			<xsl:attribute name="href">#t_<xsl:value-of select="../lopertype"/></xsl:attribute>
			<xsl:value-of select="../lopertype"/></a>
	</xsl:if>
	<br/>&#160;&#160;&#160;
	<xsl:value-of select="."/>:
	<a>
		<xsl:attribute name="href">#t_<xsl:value-of select="../ropertype"/></xsl:attribute>
		<xsl:value-of select="../ropertype"/></a>
	<br/>
</xsl:template>

<xsl:template match="name | loper | lopertype | ropertype"/>


<xsl:template match="command">
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
	<xsl:text> </xsl:text>
	<xsl:value-of select="name"/>
	<xsl:text> </xsl:text>
	<i><xsl:value-of select="roper"/></i>
	</h3>
	<p>
		<xsl:apply-templates/>
	</p>
	<hr/>
</xsl:template>

<xsl:template match="type">
	<a>
		<xsl:attribute name="name">t_<xsl:value-of select="name"/></xsl:attribute>
	</a>
	<h3><xsl:value-of select="name"/></h3>
	<p>
	<xsl:apply-templates select="description"/>
	</p>
	<hr/>
</xsl:template>

<xsl:template match="class/value">
	<tr>
	<a>
		<xsl:attribute name="name">sv_<xsl:value-of select="../name"/>_<xsl:value-of select="name"/></xsl:attribute>
	</a>
		<td>
			<xsl:choose>
				<xsl:when test="scope='abstract'">
					-
				</xsl:when>
				<xsl:otherwise>
					+
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<td>
			<xsl:value-of select="name"/>
		</td>
		<td>
			<xsl:value-of select="description"/>
		</td>
	</tr>
</xsl:template>

<xsl:template match="class">
	<a>
		<xsl:attribute name="name">c_<xsl:value-of select="name"/></xsl:attribute>
	</a>
	<h3><xsl:value-of select="description"/></h3>
	<p>
	Config entry: <i><xsl:value-of select="name"/></i>
	</p>
	<table border="1" cellspacing="0">
	<tr>
		<td bgcolor="#F0F0F0" width="30">
			&#160;
		</td>
		<td bgcolor="#F0F0F0" width="100">
			Value
		</td>
		<td bgcolor="#F0F0F0" width="300">
			Description
		</td>
	</tr>
	<xsl:apply-templates select="value">
		<!-- xsl:sort select="name"/ -->
	</xsl:apply-templates>
	</table>
	<hr/>
</xsl:template>

<xsl:template match="classlist">
	<xsl:apply-templates>
		<xsl:sort select="name"/>
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="topic">
	<a>
		<xsl:attribute name="name">scr_<xsl:value-of select="name"/></xsl:attribute>
	</a>
	<h3><xsl:value-of select="name"/></h3>
	<p>
	<xsl:apply-templates select="description"/>
	</p>
	<hr/>
</xsl:template>

<xsl:template match="topic/description">
	&#160;&#160;&#160;
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="format">
	<b>Format:</b><br/>&#160;&#160;&#160;
	<xsl:value-of select="."/>
	<br/>
</xsl:template>

<xsl:template match="array">
	<a>
		<xsl:attribute name="name">ar_<xsl:value-of select="name"/></xsl:attribute>
	</a>
	<h3><xsl:value-of select="name"/></h3>
	<p>
	<xsl:apply-templates/>
	</p>
	<hr/>
</xsl:template>

</xsl:stylesheet>


