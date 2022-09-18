import requests

data = {"person": "李志鹏"}
url = "http://127.0.0.1:8089/todayclass"

res = requests.post(url, json=data)
print(res.text)
