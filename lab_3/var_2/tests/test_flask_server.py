import requests


TEST_REGISTER = []


def test_register(func):
    TEST_REGISTER.append(func)
    def wrapper(*args, **kwargs):
        return func(*args, **kwargs)
    return wrapper


API_URL = "http://localhost:5000/api/gtd"


def _failed(r):
    return r.status_code != 200


@test_register
def test_gtd_index():
    r = requests.get(API_URL)
    if _failed(r):
        print(r.text)
        return
    ans = r.json()
    print(f"total: {ans['total']}\nrows[100]: {ans['rows'][100]}")


@test_register
def test_gtd_show():
    r = requests.get(API_URL + "/13")
    if _failed(r):
        print(r.text)
        return
    print(f"[13]: {r.json()}")

    r = requests.get(API_URL + "/-1")
    print(f"[-1]: {r.text}")


@test_register
def test_gtd_create():
    params = {"iday": 10, "imonth": 10, "iyear": 2010, "country_txt": "Karaganda"}

    #1
    r = requests.post(API_URL, params=params)
    if _failed(r):
        print(r.text)
        return
    added_id = r.json()["id"]
    r = requests.get(f"{API_URL}/{added_id}")
    print(f"[{added_id}]: {r.json()}")

    #2
    r = requests.post(API_URL + "/1", params=params)
    if _failed(r):
        print(r.text)
        return
    r = requests.get(API_URL + "/1")
    print(f"[1]: {r.json()}")


@test_register
def test_gtd_update():
    params = {"iday": 1, "imonth": 1, "region_txt": "Mdaa"}

    r = requests.put(API_URL + "/1302", params=params)
    if _failed(r):
        print(r.text)
        return
    r = requests.get(API_URL + "/1302")
    print(f"[1302]: {r.json()}")

    r = requests.put(API_URL + "/-1", params=params)
    print(f"[-1]: {r.text}")


@test_register
def test_gtd_destroy():
    r = requests.delete(API_URL + "/27")
    if _failed(r):
        print(r.text)
        return
    print(f"[27]: was deleted")
    r = requests.get(API_URL + "/27")
    print(f"[27]: {r.text}")


@test_register
def test_gtd_number_of_attacks():
    r = requests.get(API_URL + "/number/5")
    if _failed(r):
        print(r.text)
        return
    print(f"count[5]: {r.json()}")


if __name__ == "__main__":
    for func in TEST_REGISTER:
        print(func.__name__)
        func()
        print()