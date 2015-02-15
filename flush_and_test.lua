-- test main.lua


-- --------------------
-- THIS WILL FLUSH YOUR
-- REDIS DATABASE - LOL
-- --------------------


require "main"




-- set and get
assert('{"flushdb": "OK" }'  == main("/flushdb"))
assert('{"get": null }' == main("/get/noexisting"))
assert('{"set": "OK" }' == main("/set/noexisting/42"))
assert('{"get": 42 }'   ==  main("/get/noexisting"))
assert('{"set": "OK" }' == main("/set/a:a/42"))
assert('{"set": "OK" }' == main("/set/a:b/string"))

-- scan
assert('{ "scan":[ 0,[  "a:b", "a:a"]] }' == main("/scan/0/match/a:*"))

-- rpush, llen and lrange
assert('{"rpush": 1 }' == main("/rpush/tinywebdis/lua"))
assert('{"rpush": 2 }' == main("/rpush/tinywebdis/dyad"))
assert('{"rpush": 3 }' == main("/rpush/tinywebdis/redis"))
assert('{"llen": 3 }'  == main("llen/tinywebdis"))
assert('{ "lrange":[ "lua", "dyad", "redis"] }' == main("lrange/tinywebdis/0/-1"))






