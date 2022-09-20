
# Table of Contents

1.  [Class-Schedule](#orgb0b9818)
    1.  [Usage](#org3f6eb7d)
    2.  [start server](#org93b1787)
    3.  [API](#orgc1ccd20)
        1.  [今天的课程](#orgf98660f)
        2.  [现在的课程](#org1eefafe)
        3.  [rc4加密](#org2713610)
        4.  [时间戳加密](#org82d610e)
    4.  [Installation](#orgfacae0f)
    5.  [Author](#org683c271)
    6.  [Copyright](#org1e16580)


<a id="orgb0b9818"></a>

# Class-Schedule


<a id="org3f6eb7d"></a>

## Usage


<a id="org93b1787"></a>

## start server

    (ql:quickload :class-schedule)
    (class-schedule:start-s)


<a id="orgc1ccd20"></a>

## API

如果jsonp为真则返回json数据格式


<a id="orgf98660f"></a>

### 今天的课程

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


<a id="org1eefafe"></a>

### 现在的课程

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


<a id="org2713610"></a>

### rc4加密

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


<a id="org82d610e"></a>

### 时间戳加密

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


<a id="orgfacae0f"></a>

## Installation

    git clone https://github.com/lizqwerscott/class-schedule.git


<a id="org683c271"></a>

## Author

-   Lizqwer scott


<a id="org1e16580"></a>

## Copyright

Copyright (c) 2022 Lizqwer scott

