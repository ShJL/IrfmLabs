import lxml.etree as xml


def xml_analyzer(file_name):
    default_parametrs = {
        "Type": "string",
        "Null": "not null"
    }

    parameters = {}
    unique_values = {}

    objects = xml.parse(file_name).getroot()
    for obj in objects:
        for field in obj:
            cur_params = parameters.get(field.tag, default_parametrs.copy())
            if not field.text or field.get("nil", "false") == "true":
                cur_params["Null"] = "null"
            elif field.get("type", "string") == "string":
                cur_params["MaxLen"] = max(cur_params.get("MaxLen", 0), len(field.text))
            cur_params["Type"] = field.get("type", "string")
            unique_values[field.tag] = unique_values.get(field.tag, set()) | set([field.text])
            parameters[field.tag] = cur_params.copy()

    for field, vals in filter(lambda kv: 2 <= len(kv[1]) <= 5, unique_values.items()):
        parameters[field]["Check"] = sorted(vals)

    return parameters, objects.tag, objects[0].tag
