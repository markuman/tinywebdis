# tinywebdis

Version 0.2

A lean [webdis](https://github.com/nicolasff/webdis) replacement using [luadyad](https://github.com/markuman/luadyad).

## requirements

* lua 5.2.x _(liblua is sufficient)_
* C compiler _(tcc is sufficient)_

## how to

* get the source `git clone --recursive https://github.com/markuman/tinywebdis`
* run `./build.sh` _(you can add a c-compiler you want to use as an argument, `./build.sh tcc`)_
* change redis connection details in `main.lua` if necessary
* run `./tinywebdis` _(default port is 8000. To start tinywebdis on another port, run `./tinywebdis 8888`)_


### About

`tinywebdis` is path-based _(slash separated arguments)_.

#### curl examples



    [markus@arch ~]$ curl -w '\n' http://127.0.0.1:1234/get/foo
    {"get": 42 }
    [markus@arch ~]$ curl -w '\n' http://127.0.0.1:1234/set/foo/gnupower
    {"set": "OK" }
    [markus@arch ~]$ curl -w '\n' http://127.0.0.1:1234/get/foo
    {"get": "gnupower" }
    [markus@arch ~]$ curl -w '\n' http://127.0.0.1:1234/type/foo
    {"type": "string" }
    [markus@arch ~]$ curl -w '\n' http://127.0.0.1:1234/type/mylist
    {"type": "list" }
    [markus@arch ~]$ curl -w '\n' http://127.0.0.1:1234/llen/mylist
    {"llen": 4 }
    [markus@arch ~]$ curl -w '\n' http://127.0.0.1:1234/lrange/mylist/0/-1
    { "lrange":[ "hello", "oi", "oi", "a"]  }
    [markus@arch ~]$ curl -w '\n' http://127.0.0.1:1234/keys/*
    { "keys":[ "mylist", "a:c", "foo", "a:b", "string"]  }
    [markus@arch ~]$



## debugging

You can use the `main.lua` file directly in lua for debugging, hacking, expanding and improving _(pull requests are welcome!)_.

    Lua 5.3.0  Copyright (C) 1994-2015 Lua.org, PUC-Rio
    > require "main"
    true
    > main("/get/foo")
     {"foo": 42 }
    >


At least, this is the very first version and needs some improvements ...whitespaces in keys or unicode stuff can be a problem which possibly can easy be solved using lua 5.3.x only _( ignore, returned_string, errorcode = utf8.codes(returned_resp_string) )_




