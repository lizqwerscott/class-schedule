import requests

data = {"person": "李志鹏", "jsonp": False}
url = "http://127.0.0.1:8089/todayclass"
# url = "http://127.0.0.1:8089/nowclass"
url = "http://8.219.190.193:8089/nowclass"

res = requests.post(url, json=data)
print(res.text)
