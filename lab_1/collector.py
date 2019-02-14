import csv
import html5lib
import requests


URL = "https://admission.mephi.ru/admission/baccalaureate-and-specialty/education/programs#СЃРїРµС†"
MAGISTRACY = "/admission/magistracy/education/programs"
POSTGRADUATE = "/postgraduate/education/programs"


def get_request(url):
    r = requests.get(url)
    r.raise_for_status()
    return r.text


def tag_name(name):
    return "{http://www.w3.org/1999/xhtml}" + name


def get_text(element):
    return next((x.split("(")[0].strip() for x in element.itertext() if x.strip()))


def parse_tables(tables, level, fd):
    for table in tables:
        skip_speciality = 0
        skip_department = 0
        for tr in table[0][1:]:
            if skip_speciality == 0:
                skip_speciality = int(tr[0].get("rowspan", 1))
                cur_speciality = list(map(get_text, tr[:2]))
                skip_department = int(tr[2].get("rowspan", 1))
                cur_department = get_text(tr[2])
                fd.writerow([*cur_speciality, cur_department, level])
            if skip_department == 0:
                skip_department = int(tr[0].get("rowspan", 1))
                cur_department = get_text(tr[0])
                fd.writerow([*cur_speciality, cur_department, level])
            skip_department -= 1
            skip_speciality -= 1


baccalaureate, speciality = html5lib.parse(get_request(URL))[1].iter(tag_name("table"))
magistracy = html5lib.parse(get_request(URL + MAGISTRACY))[1].iter(tag_name("table"))
postgraduate = html5lib.parse(get_request(URL + POSTGRADUATE))[1].iter(tag_name("table"))


with open("specialities.csv", "w", encoding="utf-8", newline='') as f:
    writer = csv.writer(f, delimiter=";")
    parse_tables([baccalaureate], "Бакалавриат", writer)
    parse_tables([speciality], "Специалитет", writer)
    parse_tables(magistracy, "Магистратура", writer)
    parse_tables(postgraduate, "Аспирантура", writer)
