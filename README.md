
# Table of Contents

1.  [Class-Schedule](#orgb1c4d55)
    1.  [Usage](#org40efbfb)
        1.  [start server](#org7c78df0)
        2.  [API](#orge2fa02c)
    2.  [Installation](#org72fd371)
    3.  [Author](#org5bad9f3)
    4.  [Copyright](#org1cf8253)


<a id="orgb1c4d55"></a>

# Class-Schedule


<a id="org40efbfb"></a>

## Usage


<a id="org7c78df0"></a>

### start server

    (ql:quickload :class-schedule)
    (class-schedule:start-s)


<a id="orge2fa02c"></a>

### API

如果jsonp为真则返回json数据格式

1.  今天的课程

    url: /todayclass
    data:

        {
            "person": "张三",
            "jsonp": True
        }

    res:

        {
            "msg": 200,
            "result": "balbal"
        }

    或者
    balbal

2.  现在的课程

    url: /nowclass
    data:

        {
            "person": "张三",
            "jsonp": True
        }

    res:

        {
            "msg": 200,
            "result": "balbal"
        }

    or
    balbal

3.  rc4加密

    url: /rc4encrypt
    data:

        {
            "src": "hello",
            "passwd": "12138",
            "jsonp": True
        }

    res:

        {
            "msg": 200,
            "result": "88544814fa"
        }

    or
    88544814fa

4.  时间戳加密

    url: /timeencrypt
    data:

        {
            "pwd": "12138",
            "jsonp": True
        }

    res:

        {
            "msg": 200,
            "result": {
                "res":"d107124ba0c2bd35a074",
                "time":"1663576390"
            }
        }

    or
    d107124ba0c3bb3ead74


<a id="org72fd371"></a>

## Installation

    git clone https://github.com/lizqwerscott/class-schedule.git


<a id="org5bad9f3"></a>

## Author

-   Lizqwer scott


<a id="org1cf8253"></a>

## Copyright

Copyright (c) 2022 Lizqwer scott

