import json
import lxml.etree as xml


DEFAULT_PARAMETRS = {"MaxLen": 0, "Constraint": "NOT NULL"}
IGNORE_FIELDS = ["id"]

parameters = {}

root = xml.parse("../specialities.xml").getroot()
for speciality in root:
    for field in filter(lambda f: f.tag not in IGNORE_FIELDS, speciality):
        cur_params = parameters.get(field.tag.capitalize(), DEFAULT_PARAMETRS.copy())
        if not field.text:
            cur_params["Constraint"] = "NULL"
        cur_params["MaxLen"] = max(cur_params["MaxLen"], len(field.text))
        parameters[field.tag.capitalize()] = cur_params.copy()

with open("parameters.json", "w") as f:
    json.dump(parameters, f, indent=4, ensure_ascii=False)

