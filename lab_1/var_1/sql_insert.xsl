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
                    <xsl:apply-templates select="specialities/speciality"/>
                </dl>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="speciality">
        <dl>
            insert into specialities
                <dd>(code, "name", department, "level")</dd>
            values (
                <dd>'<xsl:value-of select="//code"/>',</dd>
                <dd>'<xsl:value-of select="//name"/>',</dd>
                <dd>'<xsl:value-of select="//department"/>',</dd>
                <dd>'<xsl:value-of select="//level"/>'</dd>
            );
        </dl>
    </xsl:template>
</xsl:stylesheet>
