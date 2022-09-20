
# Table of Contents

1.  [Class-Schedule](#org19bb7bf)
    1.  [Usage](#orgd49376e)
        1.  [start server](#org5053d5d)
        2.  [API](#orgca59297)
    2.  [Installation](#org639c947)
    3.  [Author](#orgdb94fcf)
    4.  [Copyright](#orgbf462e1)


<a id="org19bb7bf"></a>

# Class-Schedule


<a id="orgd49376e"></a>

## Usage


<a id="org5053d5d"></a>

### start server

    (ql:quickload :class-schedule)
    (class-schedule:start-s)


<a id="orgca59297"></a>

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


<a id="org639c947"></a>

## Installation

    git clone https://github.com/lizqwerscott/class-schedule.git


<a id="orgdb94fcf"></a>

## Author

-   Lizqwer scott


<a id="orgbf462e1"></a>

## Copyright

Copyright (c) 2022 Lizqwer scott

