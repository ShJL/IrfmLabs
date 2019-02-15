class TSQLGenerator:
    def __init__(self, table_name):
        self.table_name = table_name


    @staticmethod
    def _clear_name(name):
        return name.replace("-", "_")


    @staticmethod
    def gen_name(prefix, table_name, field_name=""):
        return "_".join(
            (x for x in map(TSQLGenerator._clear_name, [prefix, table_name, field_name]) if x)
        )


    def _get_name(self, prefix, field_name=""):
        return self.gen_name(prefix, self.table_name, field_name)


    def _get_type(self, field):
        if field["Type"] == "string":
            return f'varchar2({field["MaxLen"]})'
        elif field["Type"] == "integer":
            return "number"
        elif field["Type"] == "dateTime":
            return "date"
        return field["Type"]


    def _get_check(self, field_name, constraint):
        return 'constraint {} check ("{}" in {})'.format(
            self.gen_name("check", self.table_name, field_name),
            TSQLGenerator._clear_name(field_name),
            repr(tuple(constraint))
        )


    def add(self, file, value, skip=True):
        file.write(value + "\n")
        if skip:
            file.write("\n\n")


    def gen_table(self, fields):
        constraints = []
        attribs = []
        for field, params in fields.items():
            attribs.append(f'"{TSQLGenerator._clear_name(field)}" {self._get_type(params)} {params["Null"]}')
            if "Check" in params:
                constraints.append(self._get_check(field, params["Check"]))
        return f"create table {self.table_name} (\n\t" + ",\n\t".join(attribs + constraints) + "\n);"


    @staticmethod
    def gen_sequence(name, start, inc, max_value=None):
        return "create sequence {}\nstart with {}\nincrement by {}\n{};".format(
            name,
            start,
            inc,
            max_value if max_value is not None else "nomaxvalue"
        )


    def gen_trigger(self, when, cmd, body, name_suffix=""):
        if when not in ["before", "after"]:
            raise ValueError()
        return "create or replace trigger {}\n{} {} on {}\nfor each row\nbegin\n{}\nend;".format(
            self._get_name("trig", name_suffix),
            when,
            cmd,
            self.table_name,
            body
        )
