import requests


TEST_REGISTER = []


def test_register(func):
    TEST_REGISTER.append(func)
    def wrapper(*args, **kwargs):
        return func(*args, **kwargs)
    return wrapper


API_URL = "http://localhost:5000/api/housesale"


def _failed(r):
    return r.status_code != 200


@test_register
def test_housesale_index():
    r = requests.get(API_URL)
    if _failed(r):
        print(r.text)
        return
    ans = r.json()
    print(f"total: {ans['total']}\nrows[100]: {ans['rows'][100]}")


@test_register
def test_housesale_show():
    r = requests.get(API_URL + "/13")
    if _failed(r):
        print(r.text)
        return
    print(f"[13]: {r.json()}")

    r = requests.get(API_URL + "/-1")
    print(f"[-1]: {r.text}")


@test_register
def test_housesale_create():
    params = {"price": 100000.0, "yr_built": 1010, "yr_renovated": 2020}

    r = requests.post(API_URL + "/2", params=params)
    if _failed(r):
        print(r.text)
        return
    r = requests.get(API_URL + "/2")
    print(f"[2]: {r.json()}")


@test_register
def test_housesale_update():
    params = {"price": 999999.9, "sqft_living": 3025, "condition": 10}

    r = requests.put(API_URL + "/20", params=params)
    if _failed(r):
        print(r.text)
        return
    r = requests.get(API_URL + "/20")
    print(f"[20]: {r.json()}")

    r = requests.put(API_URL + "/-1", params=params)
    print(f"[-1]: {r.text}")


@test_register
def test_housesale_destroy():
    r = requests.delete(API_URL + "/4")
    if _failed(r):
        print(r.text)
        return
    print(f"[4]: was deleted")
    r = requests.get(API_URL + "/4")
    print(f"[4]: {r.text}")


@test_register
def test_housesale_cost():
    r = requests.get(API_URL + "/cost/5")
    if _failed(r):
        print(r.text)
        return
    print(f"sum_price[5]: {r.json()}")


if __name__ == "__main__":
    for func in TEST_REGISTER:
        print(func.__name__)
        func()
        print()