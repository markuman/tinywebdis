# tinywebdis

# Version 1.2

Rework of tinywebdis - now with luajit and turbo.lua! It supports CORS too.

## requirements

* luajit
* luarocks

... install both with you package manager (when you're using linux).

## install

1. `git clone --recursive https://github.com/markuman/tinywebdis`
2. `cp resp/resp.lua ./`
3. `luarocks install turbo lsocket`
4. _optional:_ make changes in `config.lua`
5. execute `turbowebdis.lua` with luajit


## TODO

* implement method POST for authentification


#### curl examples



    $ curl -w '\n' http://127.0.0.1:1234/get/foo
    {"get": 42 }

    $ curl -w '\n' http://127.0.0.1:1234/set/foo/gnupower
    {"set": "OK" }

    $ curl -w '\n' http://127.0.0.1:1234/get/foo
    {"get": "gnupower" }

    $ curl -w '\n' http://127.0.0.1:1234/type/foo
    {"type": "string" }

    $ curl -w '\n' http://127.0.0.1:1234/type/mylist
    {"type": "list" }

    $ curl -w '\n' http://127.0.0.1:1234/llen/mylist
    {"llen": 4 }

    $ curl -w '\n' http://127.0.0.1:1234/lrange/mylist/0/-1
    { "lrange":[ "hello", "oi", "oi", "a"]  }

    $ curl -w '\n' http://127.0.0.1:1234/keys/*
    { "keys":[ "mylist", "a:c", "foo", "a:b", "string"]  }

    $ curl -w '\n' http://127.0.0.1:8000/rpush/tinywebdis/redis
    {"rpush": 3 }

    curl -w '\n' http://127.0.0.1:8000/llen/tinywebdis
    {"llen": 3 }

    curl -w '\n' http://127.0.0.1:8000/lrange/tinywebdis/0/-1
    { "lrange":[ "lua", "dyad", "redis"] }





## TurboWebdis, TinyWebdis & CherryWebdis

Go here for detailed install instructions: [Installation](https://github.com/markuman/tinywebdis/wiki/Installation)


* TurboWebdis is currently the main version (and the fastest).
* TinyWebdis is currently not maintained but stable (and the tiniest installation).
* CherryWebdis is maybe the easiest to install version (but incomplete!)



