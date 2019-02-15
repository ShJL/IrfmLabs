<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/another-students-db-a-groups">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Вставка данных в таблицу a_groups</title>
            </head>
            <body>
                <dl>
                    <xsl:for-each select="another-students-db-a-group[not(name=preceding-sibling::another-students-db-a-group/name and old-name=preceding-sibling::another-students-db-a-group/old-name and term-number=preceding-sibling::another-students-db-a-group/term-number and study-year=preceding-sibling::another-students-db-a-group/study-year and created-at=preceding-sibling::another-students-db-a-group/created-at and updated-at=preceding-sibling::another-students-db-a-group/updated-at)]">
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                </dl>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="another-students-db-a-group">
        <dl>
            <xsl:text>insert into a_groups (</xsl:text>
                <dd>
                    <xsl:for-each select="*[position()>1]">
                        <xsl:text>"</xsl:text>
                        <xsl:call-template name="replace">
                            <xsl:with-param name="string" select="name()"/>
                            <xsl:with-param name="search" select="'-'"/>
                            <xsl:with-param name="replacement" select="'_'"/>
                        </xsl:call-template>
                        <xsl:text>"</xsl:text>
                        <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
                    </xsl:for-each>
                </dd>
            <xsl:text>) values (</xsl:text>
                <xsl:for-each select="*[position()>1]">
                    <dd>
                        <xsl:choose>
                            <xsl:when test="@nil='true'">
                                <xsl:text>null</xsl:text>
                            </xsl:when>
                            <xsl:when test="@type='dateTime'">
                                <xsl:text>date'</xsl:text>
                                <xsl:value-of select="substring-before(., 'T')"/>
                                <xsl:text>'</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="@type='string' or not(@type)"><xsl:text>'</xsl:text></xsl:if>
                                <xsl:value-of select="."/>
                                <xsl:if test="@type='string' or not(@type)"><xsl:text>'</xsl:text></xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
                    </dd>
                </xsl:for-each>
            <xsl:text>);</xsl:text>
        </dl>
    </xsl:template>
    <xsl:template name="replace">
        <xsl:param name="string"/>
        <xsl:param name="search"/>
        <xsl:param name="replacement"/>
        <xsl:choose>
            <xsl:when test="contains($string, $search)">
                <xsl:value-of select="substring-before($string, $search)"/>
                <xsl:value-of select="$replacement"/>
                <xsl:call-template name="replace">
                    <xsl:with-param name="string" select="substring-after($string, $search)"/>
                    <xsl:with-param name="search" select="$search"/>
                    <xsl:with-param name="replacement" select="$replacement"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
