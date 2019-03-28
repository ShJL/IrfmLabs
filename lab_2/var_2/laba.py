import sys
sys.path.append("../utils")

import os.path
import pandas as pd
import scipy.stats as stats
import sql_utils


def task_ab(db, file_name, columns, add_columns):
    def python2sqlite(x):
        if x.startswith("int"):
            return "integer"
        if x.startswith("float"):
            return "real"
        return "text"

    data = pd.read_csv(file_name, usecols=columns)
    for col_name, gen_func in add_columns.items():
        data[col_name] = gen_func(data)

    table_name = os.path.splitext(os.path.basename(file_name))[0]
    body = "id integer primary key autoincrement," + ",".join(
        map(" ".join, zip(data.columns, data.dtypes.apply(lambda x: python2sqlite(x.name))))
    )

    db_cursor = db.cursor()
    db_cursor.execute(f"create table {table_name} ({body})")
    db_cursor.executemany(
        sql_utils.get_sql_insert_query(table_name, data.columns),
        data.values
    )

    db.commit()

    return table_name, sql_utils.get_size_table(db, table_name)


def task_c(db, table_name, condition="0"):
    columns = sql_utils.get_columns(db, table_name)

    sql_query_delete = "delete from {} where {} or {}".format(
        table_name,
        " or ".join(map(lambda x: x + " is null", columns)),
        condition
    )
    db.cursor().execute(sql_query_delete)

    db.commit()

    return sql_utils.get_size_table(db, table_name)


def task_d(db, table_name, attrib):
    db_cursor = db.cursor()
    db_cursor.execute(f"select {attrib}, count(*) from {table_name} group by {attrib}")
    return sql_utils.records2columns(db_cursor.fetchall())


def task_e(db, table_name, attrib, min_val=None):
    db_cursor = db.cursor()
    db_cursor.execute(
        f"select {attrib}, count(*) from {table_name} group by {attrib} order by count(*)"
    )

    rows = db_cursor.fetchall()
    general_scatter = rows[-1][1] - rows[0][1]
    n = len(rows)

    left_bound = 0
    for i in range((n - 1) // 2 - 1, -1, -1):
        if 10 * (rows[i + 1][1] - rows[i][1]) > general_scatter:
            left_bound = min(i, len(rows) // 10) + 1
            break
    if min_val is not None:
        while left_bound < n and rows[left_bound][1] < min_val:
            left_bound += 1

    right_bound = n
    for i in range(n // 2 + 1, n):
        if 10 * (rows[i][1] - rows[i - 1][1]) > general_scatter:
            right_bound = max(i, n - len(rows) // 10)
            break

    extra_countries = tuple(map(lambda x: x[0], rows[:left_bound] + rows[right_bound:]))
    db_cursor.execute(
        "delete from {} where {} in ({})".format(
            table_name,
            attrib,
            sql_utils.get_placeholders(len(extra_countries), ",") + ""
        ),
        extra_countries
    )

    db.commit()

    return sql_utils.get_size_table(db, table_name)


def task_f(db, table_name, x_col):
    db_cursor = db.cursor()
    db_cursor.execute(f"select {x_col}, count(*) from {table_name} group by {x_col}")
    return sql_utils.records2columns(db_cursor.fetchall())


def task_g(x, y):
    return stats.spearmanr(x, y)
