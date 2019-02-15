<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Вставка данных в таблицу specialities</title>
            </head>
            <body>
                <dl>
                    <xsl:apply-templates select="objects/object"/>
                </dl>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="object">
        <dl>
            insert into specialities (
                <dd>
                    <xsl:for-each select="./*[position() > 1]">
                        "<xsl:value-of select="name()"/>"<xsl:if test="position() &lt; last()">,</xsl:if>
                    </xsl:for-each>
                </dd>
            ) values (
                <xsl:for-each select="./*[position()>1]">
                    <dd>
                        <xsl:if test="@type = 'string' or not(@type)">'</xsl:if>
                        <xsl:value-of select="."/>
                        <xsl:if test="@type = 'string' or not(@type)">'</xsl:if>
                        <xsl:if test="position() &lt; last()">,</xsl:if>
                    </dd>
                </xsl:for-each>
            );
        </dl>
    </xsl:template>
</xsl:stylesheet>
