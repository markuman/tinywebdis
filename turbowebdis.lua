-- tinywebdis 1.2 powered by turbo.lua

local config = require("config")
local turbo  = require("turbo")

turbo.log.categories.success = successLogging

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
  local client = resp.new(host, port)
  local args = splitIntoArgs(string)
  local key = args[1]

  -- execute command
  local unpack = table.unpack
  if #auth > 0 then client:call("AUTH", auth) end
  if db ~= 0 then client:call("SELECT", db) end
  local value = client:call(unpack(args))
  
  local ret = {}
  ret[key] = value
  return ret
  
end -- function callRedis


local IndexHandler = class("IndexHandler", turbo.web.RequestHandler)

  -- Method POST not implemented yet
  -- This is needed for e.g. authentification
  --function IndexHandler:post()
  --  self:add_header('Access-Control-Allow-Origin','*')
  --  local json = self:get_json(true)
  --  for key,value in pairs(json) do print(key,value) end -- output in terminal!
  -- end -- POST
  
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
      self:write(callRedis(input))
    end -- if  
  end -- GET
  
  -- CORS preflight request
  -- necessary for POST method
  function IndexHandler:options()
    self:add_header('Access-Control-Allow-Methods', 'POST')
    self:add_header('Access-Control-Allow-Headers', 'content-type')
    self:add_header('Access-Control-Allow-Origin', '*')
  end -- CORS preflight
  
  
local app = turbo.web.Application:new({
    -- parse arguments
    {"/(.*)$", IndexHandler},
})

app:listen(httpPort)
turbo.ioloop.instance():start()