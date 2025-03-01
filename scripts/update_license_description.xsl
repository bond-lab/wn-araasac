<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dc="https://globalwordnet.github.io/schemas/dc/"
                exclude-result-prefixes="dc">

  <!-- Output settings with DOCTYPE -->
  <xsl:output method="xml" encoding="UTF-8" indent="yes" doctype-system="http://globalwordnet.github.io/schemas/WN-LMF-1.1.dtd"/>

  <!-- Identity transform: copy everything by default -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Update the Lexicon node -->
  <xsl:template match="Lexicon">
    <xsl:copy>
      <!-- Update the license attribute -->
      <xsl:attribute name="license">https://creativecommons.org/licenses/by-nc-sa/4.0/</xsl:attribute>
      <!-- Add the dc:description attribute -->
      <xsl:attribute name="dc:description">Wordnet made from the pictographic symbols and accompanying data created by ARASAAC (https://www.arasaac.org) owned by the Government of Aragón</xsl:attribute>
      <!-- Copy existing attributes and child nodes -->
      <xsl:apply-templates select="@*[not(name()='license')] | node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
