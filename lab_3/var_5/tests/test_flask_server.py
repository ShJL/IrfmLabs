import requests


TEST_REGISTER = []


def test_register(func):
    TEST_REGISTER.append(func)
    def wrapper(*args, **kwargs):
        return func(*args, **kwargs)
    return wrapper


API_URL = "http://localhost:5000/api/survey"


def _failed(r):
    return r.status_code != 200


@test_register
def test_survey_index():
    r = requests.get(API_URL)
    if _failed(r):
        print(r.text)
        return
    ans = r.json()
    print(f"total: {ans['total']}\nrows[100]: {ans['rows'][100]}")


@test_register
def test_survey_show():
    r = requests.get(API_URL + "/100")
    if _failed(r):
        print(r.text)
        return
    print(f"[100]: {r.json()}")

    r = requests.get(API_URL + "/-1")
    print(f"[-1]: {r.text}")


@test_register
def test_survey_create():
    params = {
        "Gender": "male",
        "MaritalStatus": "married",
        "Income": 1000,
        "EmploymentStatus": "master"
    }

    #1
    r = requests.post(API_URL, params=params)
    if _failed(r):
        print(r.text)
        return
    added_id = r.json()["Id"]
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
def test_survey_update():
    params = {
        "Gender": "female",
        "Income": 100000,
    }

    r = requests.put(API_URL + "/505", params=params)
    if _failed(r):
        print(r.text)
        return
    r = requests.get(API_URL + "/505")
    print(f"[505]: {r.json()}")

    r = requests.put(API_URL + "/-1", params=params)
    print(f"[-1]: {r.text}")


@test_register
def test_survey_destroy():
    r = requests.delete(API_URL + "/1069")
    if _failed(r):
        print(r.text)
        return
    print(f"[1069]: was deleted")
    r = requests.get(API_URL + "/1069")
    print(f"[1069]: {r.text}")


@test_register
def test_survey_number_of_people():
    r = requests.get(API_URL + "/number/female")
    if _failed(r):
        print(r.text)
        return
    print(f"count[female]: {r.json()}")


if __name__ == "__main__":
    for func in TEST_REGISTER:
        print(func.__name__)
        func()
        print()