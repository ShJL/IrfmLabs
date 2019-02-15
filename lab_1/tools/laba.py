import json
import os
from sql import TSQLGenerator
from xml_analyzer import xml_analyzer


def process(xml_file, sql_file, create_seq=True):
    parameters = xml_analyzer(xml_file)

    with open("parameters.json", "w", encoding="utf-8") as f:
        json.dump(parameters, f, indent=4, ensure_ascii=False)

    table_name = os.path.splitext(os.path.basename(xml_file))[0]
    sql = TSQLGenerator(table_name)

    with open(sql_file, "w", encoding="utf-8") as f:
        sql.add(f, sql.gen_table(parameters), create_seq)

        if create_seq:
            seq_name = TSQLGenerator.gen_name("seq", table_name, "id")
            sql.add(f, TSQLGenerator.gen_sequence(seq_name, 1, 1))

            body = f'\tselect {seq_name}.nextval\n\tinto :new."id"\n\tfrom dual;'
            sql.add(f, sql.gen_trigger("before", "insert", body, "id"), False)
