1. скачать всю папку ./tools
2. написать скрипт(аналог var_*/tools/main.py)


    пример: (если main.py в папке ./tools)

    import laba


    laba.run_all(
        "path-to-file.xml",  # путь до xml файла
        "path-to-file.xsl",  # путь для создания файла xsl
        "path-to-file.sql",  # путь для создания файла sql
        create_seq=False,    # создать последовательность в sql, default: True
        insert="single",     # создать один insert для всех записей(insert all), default: "multi"
        duplicates=False,    # оставить дубликаты записей, default: True
        id=True,             # брать значение поля id из xml, default: False
        inc=10000            # на сколько увеличивать id, если id=True
    )


3. после его запуска, появятся все нужные файлы
4. добавить в xml привязку к xsl