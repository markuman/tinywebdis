# tinywebdis

Version 0.1

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

`tinywebdis` is path-based _(slash separated arguments)_. Currently only 2, 3 or 4 arguments are supported.


* get a non-existing key

![getkey-null](https://raw.githubusercontent.com/markuman/tinywebdis/master/doc/getkey-null.jpg)

* set key value

![getkey-null](https://raw.githubusercontent.com/markuman/tinywebdis/master/doc/setkey.jpg)

* get key with number as value

![getkey-null](https://raw.githubusercontent.com/markuman/tinywebdis/master/doc/getkey.jpg)

* get key with string as value

![getkey-null](https://raw.githubusercontent.com/markuman/tinywebdis/master/doc/getstring.jpg)

* rpush a list

![getkey-null](https://raw.githubusercontent.com/markuman/tinywebdis/master/doc/rpush.jpg)

* type of a key

![getkey-null](https://raw.githubusercontent.com/markuman/tinywebdis/master/doc/type.jpg)

* llen of a key

![getkey-null](https://raw.githubusercontent.com/markuman/tinywebdis/master/doc/llen.jpg)

* lrange a list

![getkey-null](https://raw.githubusercontent.com/markuman/tinywebdis/master/doc/lrange.jpg)



## debugging

You can use the `main.lua` file directly in lua for debugging, hacking, expanding and improving _(pull requests are welcome!)_.

    Lua 5.3.0  Copyright (C) 1994-2015 Lua.org, PUC-Rio
    > require "main"
    true
    > main("/get/foo")
     {"foo": 42 }
    >





