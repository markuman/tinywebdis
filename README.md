# tinywebdis

Webdis replacement using TurboLua.

## requirements

* luajit
* luarocks 5.1
* redis
* gcc (to build TurboLua)

... install both with you package manager (when you're using linux).

## install

E.g. if you're on a fresh Ubuntu

1. just install `git` and `make`
2. `git clone --recursive https://github.com/markuman/tinywebdis`
3. `make ubuntu`
4. `make start`


		$ make
		arch                           Install system dependencies on arch linux
		install                        Install turbowebdis dependencies locally
		start                          Start turbowebdis
		stop                           Stop turbowebdis
		tabularasa                     Tabula rasa
		ubuntu                         Install system dependencies on ubuntu
		uninstall                      Uninstall turbo dependencies


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



#### HTML JQUERY CORS example

You can send a json object to turbowebdis like this.

    {
        "auth": "foobar",
        "db": "0",
        "command": [
            "SET",
            "SOME",
            "VALUE"
        ]
    }


The key/value pairs `auth` and/or `db` are not a must have. When they are missed, the default values from `config.lua` file are taken.  
`db` should be a string. But you can pass it as a number too. Turbowebdis will take care of it.  
See `json_example.html` as a standalone example (open the file directly in your webbrowser).


## TurboWebdis, TinyWebdis & CherryWebdis

Go here for detailed install instructions: [Installation](https://github.com/markuman/tinywebdis/wiki/Installation)


* TurboWebdis is currently the main version (and the fastest).
* TinyWebdis is currently not maintained but stable (and the tiniest installation).
* CherryWebdis is maybe the easiest to install version (but incomplete!)


#### Alternatively

* Rust-Webdis by [badboy](https://github.com/badboy/webdis-rs)
* Origin Webdis by [nicolasff](https://github.com/nicolasff/webdis)

