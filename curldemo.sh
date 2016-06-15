#!/bin/bash

### !! this could inundate your redis db

# curl demo
# set and get
curl -w '\n' http://127.0.0.1:8888/get/noexisting
curl -w '\n' http://127.0.0.1:8888/set/noexisting/42
curl -w '\n' http://127.0.0.1:8888/get/noexisting
curl -w '\n' http://127.0.0.1:8888/set/a:a/42
curl -w '\n' http://127.0.0.1:8888/set/a:b/gnupower!
curl -w '\n' http://127.0.0.1:8888/get/a:b

# scan
curl -w '\n' http://127.0.0.1:8888/scan/0/match/a:*

# rpush, llen and lrange
curl -w '\n' http://127.0.0.1:8888/rpush/tinywebdis/lua
curl -w '\n' http://127.0.0.1:8888/rpush/tinywebdis/dyad
curl -w '\n' http://127.0.0.1:8888/rpush/tinywebdis/redis
curl -w '\n' http://127.0.0.1:8888/llen/tinywebdis
curl -w '\n' http://127.0.0.1:8888/lrange/tinywebdis/0/-1

# jsonp
curl -w '\n' http://127.0.0.1:8888/get/a:b?callback=myfunc
