import sys
sys.path.append("../../tools")

import json
from sql import TSQLGenerator
from xml_analyzer import xml_analyzer


parameters = xml_analyzer("../specialities.xml")

with open("parameters.json", "w", encoding="utf-8") as f:
    json.dump(parameters, f, indent=4, ensure_ascii=False)

table_name = "specialities"
sql = TSQLGenerator(table_name)

with open("../script.sql", "w", encoding="utf-8") as f:
    sql.add(f, sql.gen_table(parameters))

    seq_name = TSQLGenerator.gen_name("seq", table_name, "id")
    sql.add(f, TSQLGenerator.gen_sequence(seq_name, 1, 1))

    body = f'\tselect {seq_name}.nextval\n\tinto :new."id"\n\tfrom dual;'
    sql.add(f, sql.gen_trigger("before", "insert", body, "id"), False)
