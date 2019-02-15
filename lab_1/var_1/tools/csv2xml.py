import csv
import lxml.etree as xml


root = xml.Element("specialities")

with open("specialities.csv", "r", encoding="utf-8", newline="") as f:
    reader = csv.DictReader(f, delimiter=";")
    for id, row in enumerate(reader):
        new_speciality = xml.Element("speciality")
        xml.SubElement(new_speciality, "id").text = str(id + 1)
        xml.SubElement(new_speciality, "code").text = row["Code"]
        xml.SubElement(new_speciality, "name").text = row["Name"]
        xml.SubElement(new_speciality, "department").text = row["Department"]
        xml.SubElement(new_speciality, "level").text = row["Level"]
        root.append(new_speciality)

xml.ElementTree(root).write(
    file="../specialities.xml",
    encoding="utf-8",
    pretty_print=True,
    xml_declaration=True
)

