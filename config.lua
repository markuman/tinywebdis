-- TurboWebdis config

-- http port
httpPort = 8888

-- redis connection settings
host = "127.0.0.1"
port = 6379
auth = "" -- leave it empty when no authentification is needed.
db   = "0"

-- lua search path 
-- uncomment and set absolute path to luarocks share and lib path when luajit can't find 'turbo' or 'lsocket'
-- package.path  = "/home/markus/.luarocks/share/lua/5.1/?.lua;" .. package.path
-- package.cpath = "/home/markus/.luarocks/lib/lua/5.1/?.so;" .. package.cpath

-- to disable success logging set to false (false will be faster)
successLogging = true
