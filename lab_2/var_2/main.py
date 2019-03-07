import laba
import matplotlib.pyplot as plt
import pandas as pd
import sqlite3


db_connection = sqlite3.connect("gtd.db")


used_columns = [
    "iyear", "imonth", "iday", "country_txt", "region_txt", "latitude", "longitude"
]

add_columns = {
    "accident_date": lambda df: pd.to_datetime(
        df[["iyear", "imonth", "iday"]].rename(columns=lambda x: x[1:]),
        errors="coerce"
    ).astype("str"),
}


# A, B
print("tasks A, B:")

table_name, data_size = laba.task_ab(
    db_connection, "gtd.csv", used_columns, add_columns
)
print(data_size)


# C
print("task C:")

table_size_c = laba.task_c(
    db_connection, table_name, condition="iday = 0 or iyear = 0 or imonth = 0"
)
print(table_size_c)


# D
print("task D:")

countries, counts = laba.task_d(db_connection, table_name, "country_txt")
plt.figure(1)
plt.bar(countries, counts)
plt.tick_params(axis="x", labelsize=7, labelrotation=90)


# E
print("task E:")

table_size_e = laba.task_e(db_connection, table_name, "country_txt", 5)
print(table_size_e)


# F
print("task F:")

x, y = laba.task_f(db_connection, table_name, "imonth")
plt.figure(2)
plt.plot(x, y)


# G
print("task G:")

smr, p_value = laba.task_g(x, y)
print(f"R = {smr:.3}, p_val = {p_value:.3}")


db_connection.close()


plt.show()