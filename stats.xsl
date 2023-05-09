<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Find all Pokemon that fit particular attack/defense/speed values -->

<!-- The below rule will generate a comma-separated list from the 'type' nodes -->
<xsl:template match="type[position() != last()]"><xsl:value-of select="text()"/>, </xsl:template>
<xsl:template match="type[position() = last()]">
  <xsl:value-of select="text()"/>
</xsl:template>

<!--
  These rules will generate text output rather than text; these are useful for more easily
  figuring out if you got the "select" queries correct. Once you have that figured out,
  then update the HTML version of these rules below (and comment these out!) to see a nicely-
  formatted HTML file.
  -->
  <!--
<xsl:template match="/pokedex">
    Strong attackers:
    <xsl:apply-templates select="pokemon[attack/text() > 150]" />
    Strong defenders:
    <xsl:apply-templates select="pokemon[defense/text() > 150]" />
    Fast:
    <xsl:apply-templates select="pokemon[speed/text() > 150]" />
</xsl:template>

<xsl:template match="pokemon">
    <xsl:value-of select="./name" /> (<xsl:value-of select="@pokedexNumber" />): <xsl:apply-templates select="type" />
</xsl:template>
  -->

<!--
  These rules will generate HTML output rather than text. This is to demonstrate
  the power of using XSLT to create pretty output from XML sources.
  -->
<xsl:template match="/pokedex">
  <html>
    <body>
      <h2>Pokemon with HP=55, Attack=50, Defense=45, Speed=90, Sp. Attack=65, and Sp. Defense=80</h2>
      <table border="1">
        <tr bgcolor="#9acd32">
          <th>Name</th>
          <th>Type(s)</th>
          <th>HP</th>
          <th>Attack</th>
          <th>Defense</th>
          <th>Speed</th>
          <th>Sp. Attack</th>
          <th>Sp. Defense</th>
          <th>Height (m)</th>
          <th>Weight (kg)</th>
        </tr>
        <xsl:apply-templates select="pokemon[hp=55 and attack=50 and defense=45 and speed=90 and sp_attack=65 and sp_defense=80]"/>
      </table>
    </body>
  </html>
</xsl:template>

<xsl:template match="pokemon">
  <tr>
    <td><xsl:value-of select="./name" /></td>
    <td><xsl:apply-templates select="type" /></td>
    <td><xsl:value-of select="./hp" /></td>
    <td><xsl:value-of select="./attack" /></td>
    <td><xsl:value-of select="./defense" /></td>
    <td><xsl:value-of select="./speed" /></td>
    <td><xsl:value-of select="./sp_attack" /></td>
    <td><xsl:value-of select="./sp_defense" /></td>
    <td><xsl:value-of select="./height/m" /></td>
    <td><xsl:value-of select="./weight/kg" /></td>
  </tr>
</xsl:template>

</xsl:stylesheet>
