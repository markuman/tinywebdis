# tinywebdis

# Version 1.0

Rework of tinywebdis - now with luajit and turbo.lua! It supports now CORS.

## requirements

* luajit
* luarocks

... install both with you package manager (when you're using linux).

## install

1. `git clone --recursive https://github.com/markuman/tinywebdis`
2. `cp resp/resp.lua ./`
3. `luarocks install turbo lsocket`
4. _optional:_ change redis settings in `tinywebdis.lua`
5. execute `tinywebdis.lua` with luajit


## TODO

* create config file
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





## Version 0.x

__See in branch tinywebdis_0.x__

Is a lean [webdis](https://github.com/nicolasff/webdis) replacement using [luadyad](https://github.com/markuman/luadyad).

## requirements

* lua 5.2.x _(liblua is sufficient)_
* C compiler _(tcc is sufficient)_




