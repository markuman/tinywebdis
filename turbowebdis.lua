#!/usr/bin/luajit
-- tinywebdis 1.3 powered by turbo.lua

local config = require("config")
local turbo  = require("turbo")
local escape = require("turbo.escape")

turbo.log.categories.success = config.turbo.logging

local function splitIntoArgs(path)
  local args = {}
  for arg in string.gmatch(path, "[^/]+") do
    table.insert(args, arg)
  end
  return args
end -- function splitIntoArgs


local function callRedis(string)
  -- make redis connection using https://github.com/soveran/resp
  local resp = require("resp")
  -- enter redis connection details here
  local client = resp.new(config.redis.host, config.redis.port)
  local args = splitIntoArgs(string)
  local key = args[1]

  -- execute command
  local unpack = unpack or table.unpack
  if #config.redis.auth > 0 then client:call("AUTH", config.redis.auth) end
  if config.redis.db ~= "0" then client:call("SELECT", config.redis.db) end
  local value = client:call(unpack(args))
  
  local ret = {}
  ret[key] = value
  return ret
  
end -- function callRedis


local IndexHandler = class("IndexHandler", turbo.web.RequestHandler)

  -- Method POST
  -- Sending json like this   JSON.stringify({"auth": "", "db": 1, "command": ["GET", "SOME", "VALUE"]}) 
  function IndexHandler:post()
    self:add_header('Access-Control-Allow-Origin','*')
    local json = self:get_json(true)

    auth = json['auth'] or auth
    db   = tostring(json['db'] or db) -- make sure that the db number is a string
    local cmd  = json['command']

    self:write(callRedis(table.concat(cmd,'/')))
  end -- POST
  
  -- Method GET
  function IndexHandler:get(input)
    -- add cors header
    self:add_header('Access-Control-Allow-Origin','*')
    self:add_header('Content-Type', 'application/json')
    
    -- count arguments
    input,argCount = string.gsub(input, "/", "%1")
    if ((argCount <= 1) and (#input <= 1)) then
      self:write({usage="command/key/option[1]/option[2]/..."})
    else
      -- get/a?callback=mycallback
      -- jsonp return
       
      local callback = self:get_argument("callback", -1)
      if ((config.turbo.JSONP) and (type (callback) == "string")) then
        local retval = callRedis (input)
        self:write (callback .. "(" .. escape.json_encode (retval) .. ")")	    
	  else
        self:write (callRedis (input))
      end
    end -- if  
  end -- GET
  
  -- CORS preflight request
  -- necessary for POST method
  function IndexHandler:options()
    if (config.turbo.CORS) then
      self:add_header('Access-Control-Allow-Methods', 'POST')
      self:add_header('Access-Control-Allow-Headers', 'content-type')
      self:add_header('Access-Control-Allow-Origin', '*')
    end
  end -- CORS preflight
  
  
local app = turbo.web.Application:new({
    -- parse arguments
    {"/(.*)$", IndexHandler},
})

app:listen(config.turbo.port)
turbo.ioloop.instance():start()
