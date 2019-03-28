DATABASE = "db\\gtd.db"

SQL_TABLE = "gtd"

SQL_COLUMNS = (
    "iyear",
    "imonth",
    "iday",
    "country_txt",
    "region_txt",
    "latitude",
    "longitude",
    "accident_date"
)

SQL_PLACEHOLDERS = tuple((f":{field}" for field in SQL_COLUMNS))

SQL_FULL_MATCHING = tuple(map("=".join, zip(SQL_COLUMNS, SQL_PLACEHOLDERS)))
