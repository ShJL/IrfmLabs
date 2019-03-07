def get_placeholders(n, delim):
    return delim.join(["?"] * n)


def get_sql_insert_query(table_name, columns):
    return "insert into {} ({}) values ({})".format(
        table_name,
        ",".join(columns),
        get_placeholders(len(columns), ",")
    )


def get_columns(db, table_name):
    db_cursor = db.cursor()
    db_cursor.execute(f"select * from {table_name} limit 1")
    return list(map(lambda x: x[0], db_cursor.description))


def get_size_table(db, table_name):
    db_cursor = db.cursor()
    db_cursor.execute(f"select count(*) from {table_name}")
    return db_cursor.fetchone()[0]


def records2columns(rows):
    if not rows:
        return []
    return [list(map(lambda x: x[i], rows)) for i in range(len(rows[0]))]
