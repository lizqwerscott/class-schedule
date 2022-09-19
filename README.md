
# Table of Contents

1.  [Class-Schedule](#org358b8a2)
    1.  [Usage](#org7c1b165)
        1.  [start server](#org6a15f88)
        2.  [API](#org07973bc)
    2.  [Installation](#org7bd2f1c)
    3.  [Author](#org9e0ee24)
    4.  [Copyright](#org526b6a2)


<a id="org358b8a2"></a>

# Class-Schedule


<a id="org7c1b165"></a>

## Usage


<a id="org6a15f88"></a>

### start server

    (ql:quickload :class-schedule)
    (class-schedule:start-s)


<a id="org07973bc"></a>

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
            "result": "d107124ba0c3bb3ead74"
        }

    or
    d107124ba0c3bb3ead74


<a id="org7bd2f1c"></a>

## Installation

    git clone https://github.com/lizqwerscott/class-schedule.git


<a id="org9e0ee24"></a>

## Author

-   Lizqwer scott


<a id="org526b6a2"></a>

## Copyright

Copyright (c) 2022 Lizqwer scott

