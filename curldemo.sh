#!/bin/bash

### !! this could inundate your redis db

# curl demo
# set and get
curl -w '\n' http://127.0.0.1:8000/get/noexisting
curl -w '\n' http://127.0.0.1:8000/set/noexisting/42
curl -w '\n' http://127.0.0.1:8000/get/noexisting
curl -w '\n' http://127.0.0.1:8000/set/a:a/42
curl -w '\n' http://127.0.0.1:8000/set/a:b/gnupower!
curl -w '\n' http://127.0.0.1:8000/get/a:b

# scan
curl -w '\n' http://127.0.0.1:8000/scan/0/match/a:*

# rpush, llen and lrange
curl -w '\n' http://127.0.0.1:8000/rpush/tinywebdis/lua
curl -w '\n' http://127.0.0.1:8000/rpush/tinywebdis/dyad
curl -w '\n' http://127.0.0.1:8000/rpush/tinywebdis/redis
curl -w '\n' http://127.0.0.1:8000/llen/tinywebdis
curl -w '\n' http://127.0.0.1:8000/lrange/tinywebdis/0/-1