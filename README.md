
# Table of Contents

1.  [Class-Schedule](#orgc9b23df)
    1.  [Usage](#org5542d2f)
        1.  [start server](#org486dc51)
        2.  [API](#orga660a2e)
    2.  [Installation](#org9860b7f)
    3.  [Author](#orgba860d7)
    4.  [Copyright](#org0bb860b)


<a id="orgc9b23df"></a>

# Class-Schedule


<a id="org5542d2f"></a>

## Usage


<a id="org486dc51"></a>

### start server

    (ql:quickload :class-schedule)
    (class-schedule:start-s)


<a id="orga660a2e"></a>

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


<a id="org9860b7f"></a>

## Installation

    git clone https://github.com/lizqwerscott/class-schedule.git


<a id="orgba860d7"></a>

## Author

-   Lizqwer scott


<a id="org0bb860b"></a>

## Copyright

Copyright (c) 2022 Lizqwer scott

