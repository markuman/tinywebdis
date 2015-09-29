-- TurboWebdis config

-- http port
httpPort = 8888

-- redis connection settings
host = "127.0.0.1"
port = 6379
auth = "" -- leave it empty when no authentification is needed.
db   = "0"

-- lua search path 
package.path  = os.getenv ( "HOME" ) .. "/.luarocks/share/lua/5.1/?.lua;" .. package.path
package.cpath = os.getenv ( "HOME" ) .. "/.luarocks/lib/lua/5.1/?.so;" .. package.cpath


-- to disable success logging set to false (false will be faster)
successLogging = true
