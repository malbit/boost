<?xml version='1.0' encoding='iso-8859-1'?>
<!--
XSL transformation from the XML files generated by Doxygen into XHTML source
code documentation of the circular_buffer_space_optimized.

Copyright (c) 2003-2008 Jan Gaspar

Use, modification, and distribution is subject to the Boost Software
License, Version 1.0. (See accompanying file LICENSE_1_0.txt or copy at
http://www.boost.org/LICENSE_1_0.txt)
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="doxygen2html.xslt"/>

  <xsl:output method="xml" version="1.0" encoding="iso-8859-1" indent="yes" media-type="text/xml"/>

  <xsl:variable name="link-prefix" select="'circular_buffer.html'"/>
  <xsl:variable name="circular_buffer-ref" select="//compound[name='boost::circular_buffer' and @kind='class']/@refid"/>
  <xsl:variable name="circular_buffer-file" select="concat($xmldir, '/', $circular_buffer-ref, '.xml')"/>
  <xsl:variable name="circular_buffer-reimplemented" select="document($circular_buffer-file)/doxygen/compounddef[@id = $circular_buffer-ref and @kind = 'class']//reimplementedby"/>
  <xsl:variable name="standalone-functions" select="document(concat($xmldir, '/namespaceboost.xml'))/doxygen/compounddef/sectiondef[@kind='func']"/>

  <xsl:template name="reference">
    <xsl:variable name="refid" select="$circular_buffer-reimplemented[@refid=current()/@refid and text()!='capacity_type']/../@id"/>
    <xsl:value-of select="concat(substring(concat($link-prefix, '#', $refid), 1 div (string-length($refid) &gt; 0)), substring(concat('#', @refid), 1 div (string-length($refid) = 0)))"/>
  </xsl:template>

  <xsl:template name="template-parameters">
    <xsl:apply-templates select="templateparamlist/param" mode="synopsis">
      <xsl:with-param name="link-prefix" select="$link-prefix"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template name="public-types">
    <xsl:for-each select="sectiondef[@kind='public-type']/memberdef">
      <xsl:if test="string-length(normalize-space(briefdescription)) &gt; 0">
        <xsl:choose>
          <xsl:when test="document($circular_buffer-file)/doxygen/compounddef[@id = $circular_buffer-ref and @kind = 'class']/sectiondef[@kind='public-type']/memberdef[name=current()/name]/briefdescription = briefdescription">
            <xsl:apply-templates select="document($circular_buffer-file)/doxygen/compounddef[@id = $circular_buffer-ref and @kind = 'class']/sectiondef[@kind='public-type']/memberdef[name=current()/name]" mode="synopsis">
              <xsl:with-param name="link-prefix" select="$link-prefix"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="." mode="synopsis"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="constructors">
    <xsl:for-each select="sectiondef[@kind='public-func']/memberdef[type = '']">
      <xsl:variable name="briefdescription" select="normalize-space(briefdescription)"/>
      <xsl:if test="string-length($briefdescription) &gt; 0">
        <xsl:apply-templates select="." mode="synopsis"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="member-functions">
    <xsl:variable name="current" select="sectiondef[@kind='public-func']/memberdef[type != '']"/>
    <xsl:for-each select="document($circular_buffer-file)/doxygen/compounddef[@id = $circular_buffer-ref and @kind = 'class']/sectiondef[@kind='public-func']/memberdef[type != '']">
      <xsl:if test="count($current[name=current()/name and string-length(normalize-space(briefdescription)) &gt; 0]) = 0">
        <xsl:apply-templates select="." mode="synopsis">
          <xsl:with-param name="link-prefix" select="$link-prefix"/>
        </xsl:apply-templates>
      </xsl:if>
    </xsl:for-each>
    <xsl:for-each select="$current[string-length(normalize-space(briefdescription)) &gt; 0 and normalize-space(briefdescription) != 'no-comment']">
      <xsl:apply-templates select="." mode="synopsis"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="standalone-functions">
    <xsl:for-each select="$standalone-functions/memberdef[contains(argsstring, 'circular_buffer_space_optimized&lt;')]">
      <xsl:apply-templates select="." mode="synopsis">
        <xsl:with-param name="indent" select="''"/>
        <xsl:with-param name="link-prefix" select="$link-prefix"/>
        <xsl:with-param name="link" select="$standalone-functions/memberdef[contains(argsstring, 'circular_buffer&lt;') and name=current()/name]/@id"/>
      </xsl:apply-templates>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="template-parameters-details"/>

  <xsl:template name="public-types-details">
    <xsl:apply-templates select="sectiondef[@kind='public-type']/memberdef[not(contains(type, 'circular_buffer&lt;'))]" mode="description"/>
  </xsl:template>

  <xsl:template name="constructors-details">
    <xsl:for-each select="sectiondef[@kind='public-func']/memberdef[type = '' and string-length(normalize-space(briefdescription)) &gt; 0]">
      <xsl:apply-templates select="." mode="description"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="member-functions-details">
    <xsl:for-each select="sectiondef[@kind='public-func']/memberdef[type != '' and string-length(normalize-space(briefdescription)) &gt; 0 and normalize-space(briefdescription) != 'no-comment']">
      <xsl:apply-templates select="." mode="description"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="standalone-functions-details"/>

</xsl:stylesheet>
