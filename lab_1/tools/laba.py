import json
import lxml.etree as xml
import os.path as os
from sql import TSQLGenerator
from xml_analyzer import xml_analyzer
from xsl import generate_xsl


def create_sql(sql_file, table_name, parameters, create_seq=True):
    sql = TSQLGenerator(table_name)

    with open(sql_file, "w", encoding="utf-8") as f:
        sql.add(f, sql.gen_table(parameters), create_seq)

        if create_seq:
            seq_name = TSQLGenerator.gen_name("seq", table_name, "id")
            sql.add(f, TSQLGenerator.gen_sequence(seq_name, 1, 1))

            body = f'\tselect {seq_name}.nextval\n\tinto :new."id"\n\tfrom dual;'
            sql.add(f, sql.gen_trigger("before", "insert", body, "id"), False)


def add_inserts(xml_file, xsl_file, sql_file):
    transform = xml.XSLT(xml.parse(xsl_file))
    inserts = transform(xml.parse(xml_file)).find("body")

    with open(sql_file, "a", encoding="utf-8") as f:
        f.write("\n\n")
        if inserts.text:
            f.write(inserts.text + "\n")
        tail = ""
        for insert in inserts.iter("dl"):
            f.write("".join(insert.itertext()) + "\n")
            tail = insert.tail
        if tail:
            f.write(tail + "\n")


def create_xsl(xsl_file, **kwargs):
    with open(xsl_file, "w", encoding="utf-8") as f:
        f.write(generate_xsl(**kwargs))


def run_all(xml_file, xsl_file, sql_file, **kwargs):
    parameters, root, element = xml_analyzer(xml_file)

    with open("task_2.json", "w", encoding="utf-8") as f:
        json.dump(parameters, f, indent=4, ensure_ascii=False)

    table = os.splitext(os.basename(xml_file))[0]

    create_sql(sql_file, table, parameters, kwargs.get("create_seq", True))

    kwargs.pop("create_seq", None)
    kwargs["root_tag"] = kwargs.get("root_tag", root)
    kwargs["element_tag"] = kwargs.get("element_tag", element)
    kwargs["table_name"] = kwargs.get("table_name", table)
    kwargs["element_fields"] = kwargs.get("element_fields", set(parameters.keys()) - set(["id"]))
    
    create_xsl(xsl_file, **kwargs)
    add_inserts(xml_file, xsl_file, sql_file)