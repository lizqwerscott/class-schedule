import requests
import json
import threading

class getTask(threading.Thread):
    def __init__(self, threadId, delay):
        threading.Thread.__init__(self)
        self.data = {"person": "lizqwer", "jsonp": True}
        self.url = "http://hk.2002514.xyz:8089/nowclass"


    def run(self):
        print("开始线程:")
        res = requests.post(self.url, json=self.data)
        print(res.text)
        print("请求结束")


# data = {"person": "oxygen", "jsonp": True}
# data = {"pwd": "12138", "jsonp": True}
# url = "http://127.0.0.1:8089/todayclass"
# url = "http://127.0.0.1:8089/nowclass"
# url = "http://127.0.0.1:8089/tomorrowclass"
# url = "http://8.219.190.193:8089/nowclass"
# url = "http://8.219.190.193:8089/todayclass"
# url = "http://8.219.190.193:8089/tomorrowclass"
# url = "http://127.0.0.1:8089/rc4encrypt"
# url = "http://127.0.0.1:8089/timeencrypt"
# url = "http://8.219.190.193:8089/timeencrypt"
# url = "http://hk.2002514.xyz:8089/nowclass"

# for i in range(100):
#     res = requests.post(url, json=data)
#     print(res.text)

def test_thread():
    id = 0
    thread_list = []
    for i in range(10000):
        task = getTask(id, 0)
        id += 1
        thread_list.append(task)
        task.start()
    for t in thread_list:
        t.join()
    print("结束")


if __name__ == "__main__":
    data = {"person": "lizqwer", "jsonp": True}
    url = "http://127.0.0.1:8089/todayclass"

    res = requests.post(url, json=data)
    print(res.text)
