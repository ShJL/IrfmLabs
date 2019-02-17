__all__ = ["generate_xsl"]


__DOC_XSL = """\
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    {body}
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
"""


__DOC_TEMPLATE = """
<xsl:template match="{match}">
    {body}
</xsl:template>
"""


__DOC_KEY = """
<xsl:key name="{name}"
    match="{match}"
    use="{use}"
/>
"""


__DOC_MAIN_BODY = """
<html>
    <head>
        <meta charset="UTF-8"/>
        <title>Вставка данных в таблицу {table}</title>
    </head>
    <body>
        {body}
    </body>
</html>
"""


__DOC_APPLY_TEMPLATE = """
<xsl:apply-templates select="{path}"/>
"""


__DOC_SINGLE_INSERT_WRAPPER = """
<xsl:text>insert all</xsl:text>
    {text}
<xsl:text>from dual;</xsl:text>
"""


__DOC_SINGLE_INSERT = """
<dl>
    <xsl:text>into {table} (</xsl:text>
    <xsl:for-each select="{path}">
        {name}
    </xsl:for-each>
    <xsl:text>) values (</xsl:text>
    <xsl:for-each select="{path}">
        {value}
    </xsl:for-each>
    <xsl:text>)</xsl:text>
</dl>
"""


__DOC_INDIVIDUAL_INSERT = """
<dl>
    <xsl:text>insert into {table} (</xsl:text>
        <dd>
            <xsl:for-each select="{path}">
                {name}
            </xsl:for-each>
        </dd>
    <xsl:text>) values (</xsl:text>
        <xsl:for-each select="{path}">
            <dd>
                {value}
            </dd>
        </xsl:for-each>
    <xsl:text>);</xsl:text>
</dl>
"""


__DOC_FIELD_NAME = """
<xsl:text>"</xsl:text>
<xsl:call-template name="replace">
    <xsl:with-param name="string" select="name()"/>
    <xsl:with-param name="search" select="'-'"/>
    <xsl:with-param name="replacement" select="'_'"/>
</xsl:call-template>
<xsl:text>"</xsl:text>
<xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
"""


__DOC_FIELD_VALUE = """
<xsl:choose>
    <xsl:when test="@nil = 'true' or not(text())">
        <xsl:text>null</xsl:text>
    </xsl:when>
    {id}
    <xsl:when test="@type = 'dateTime'">
        <xsl:text>date'</xsl:text>
        <xsl:value-of select="substring-before(., 'T')"/>
        <xsl:text>'</xsl:text>
    </xsl:when>
    <xsl:otherwise>
        <xsl:if test="@type = 'string' or not(@type)"><xsl:text>'</xsl:text></xsl:if>
        <xsl:call-template name="replace">
            <xsl:with-param name="string" select="."/>
            <xsl:with-param name="search" select="'&#xA;'"/>
            <xsl:with-param name="replacement" select="' '"/>
        </xsl:call-template>
        <xsl:if test="@type = 'string' or not(@type)"><xsl:text>'</xsl:text></xsl:if>
    </xsl:otherwise>
</xsl:choose>
<xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
"""


__DOC_ID_VALUE = """
<xsl:when test="name() = 'id'">
    <xsl:value-of select=". + {inc}"/>
</xsl:when>
"""


def __shift(text, level=1):
    return " " * level * 4 + ("\n" + " " * level * 4).join(text.split("\n"))


def __clear(text):
    return "\n".join(filter(lambda x : x.strip(), text.split("\n")))


def generate_xsl(
    root_tag, element_tag, table_name,
    insert="multi", duplicates=True, element_fields=None, id=False, inc=None
):
    if insert not in ["multi", "single"] or not duplicates and element_fields is None or id and inc is None:
        raise ValueError()

    key_tag = ""
    current_element = element_tag
    if not duplicates:
        fields = ", ".join(element_fields)
        key_tag = __DOC_KEY.format(name="unique", match=element_tag, use=f"concat({fields})")
        current_element = f"{element_tag}[count(. | key('unique', concat({fields}))[1]) = 1]"

    apply_template = __DOC_APPLY_TEMPLATE.format(path=current_element)
    if insert == "single":
        apply_template = __DOC_SINGLE_INSERT_WRAPPER.format(text=__shift(apply_template))

    main_body = __DOC_MAIN_BODY.format(table=table_name, body=__shift(apply_template, 2))

    main_template = __DOC_TEMPLATE.format(match="/" + root_tag, body=__shift(main_body))

    indent = 4 if insert == "multi" else 2
    insert_body = (__DOC_INDIVIDUAL_INSERT if insert == "multi" else __DOC_SINGLE_INSERT).format(
        table=table_name,
        path="*" if id else "*[position() > 1]",
        name=__shift(__DOC_FIELD_NAME, indent),
        value=__shift(__DOC_FIELD_VALUE.format(id=__shift(__DOC_ID_VALUE.format(inc=inc) if id else "")), indent)
    )

    insert_template = __DOC_TEMPLATE.format(match=element_tag, body=__shift(insert_body))

    return __clear(__DOC_XSL.format(body=__shift(key_tag + main_template + insert_template)))
