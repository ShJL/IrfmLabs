import pandas as pd
import requests


АДРЕС_API = "https://damia.ru/api-rs/balance"


############################ ДАННЫЕ ДЛЯ ЗАПОЛНЕНИЯ ############################

параметры_запроса = {
    "key": "....."
}


НАЗВАНИЕ_EXCEL_ФАЙЛА = "....."


ИНН_КОМПАНИЯ = {
    2460066195: "ПАО РусГидро",
}


ДАННЫЕ_КОМПАНИИ = {
    2460066195: (1, "A"), # (номер строки, буква столбца)
}


ЧИСТАЯ_ПРИБЫЛЬ_КОМПАНИИ = {
    2460066195: (5, "C"), # (номер строки, буква столбца)
}

#################################### КОНЕЦ ####################################


ПОКАЗАТЕЛЬ_КОД = {
    "Дебиторская задолженность": 1230,
    "Выручка": 2110,
    "Себестоимость": 2120,
    "Активы": 1600,
    "Оборотные активы": 1200,
    "Оборотные средства": 1150,
    "Амортизация": -1,
    "Коммерческие расходы": 2210,
    "Управленческие расходы": 2220,
    "Долгосрочные обязательства": 1400,
    "Краткосрочные обязательства": 1500,
    "Денежные средства": 1250,
    "Задолженность по уплате налога на прибыль": -1,
    "Краткосрочная часть долгосрочных кредитов и займов": -1
}


def сделать_запрос(адрес, параметры={}):
    r = requests.get(адрес, params=параметры)
    r.raise_for_status()
    return r.json()


def номер_столбца(s):
    return sum((ord(c) - 64) * 26**i for i, c in enumerate(s.upper()[::-1])) - 1


данные = {}
чистая_прибыль = {}

for инн in ИНН_КОМПАНИЯ.keys():
    параметры_запроса["inn"] = инн
    баланс = сделать_запрос(АДРЕС_API, параметры_запроса)[str(инн)]

    данные[инн] = pd.DataFrame()
    чистая_прибыль[инн] = pd.DataFrame()
    for год in ("2015", "2016", "2017"):
        данные[инн][год] = pd.Series({
            показатель: float(баланс[год].get(str(код), "NaN")) for показатель, код in ПОКАЗАТЕЛЬ_КОД.items()
        })
        чистая_прибыль[инн][год] = [float(баланс[год].get("2400", "NaN"))]


with pd.ExcelWriter(НАЗВАНИЕ_EXCEL_ФАЙЛА) as writer:
    pd.Series(ИНН_КОМПАНИЯ).to_excel(
        writer,
        sheet_name="Бениш и Роксас (US)",
        header=False,
        index=False,
        startrow=1,
        startcol=11
    )

    for инн in ИНН_КОМПАНИЯ.keys():
        данные[инн].to_excel(
            writer,
            sheet_name="Бениш и Роксас (US)",
            header=False,
            index=False,
            startrow=ДАННЫЕ_КОМПАНИИ[инн][0] - 1,
            startcol=номер_столбца(ДАННЫЕ_КОМПАНИИ[инн][1])
        )
        чистая_прибыль[инн].to_excel(
            writer,
            sheet_name="ДДС",
            header=False,
            index=False,
            startrow=ЧИСТАЯ_ПРИБЫЛЬ_КОМПАНИИ[инн][0] - 1,
            startcol=номер_столбца(ЧИСТАЯ_ПРИБЫЛЬ_КОМПАНИИ[инн][1])
        )