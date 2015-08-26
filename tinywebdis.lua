-- tinywebdis 1.0 powered by turbo.lua

-- optional, when luajit can't find the dependencies installed by luarocks
-- package.path  = "/home/markus/.luarocks/share/lua/5.1/?.lua;" .. package.path
-- package.cpath = "/home/markus/.luarocks/lib/lua/5.1/?.so;" .. package.cpath

local turbo = require("turbo")

local function splitIntoArgs(path)
  local args = {}
  for arg in string.gmatch(path, "[^/]+") do
    table.insert(args, arg)
  end
  return args
end -- function splitIntoArgs


local function string2json(key, value)
  if tonumber(value) ~= nil then
    return '{"' .. key .. '": ' .. tonumber(value) .. ' }'
  elseif (value == nil) then
    return '{"' .. key .. '": null }'
  else
    return '{"' .. key .. '": "' .. value .. '" }'
  end
end -- function key2json


local function list2json(var)
  -- get values of a list
  local js = ''
  for l = 1,(#var) do
    if (type(var[l]) == "table") then
      -- recursive call
      js = js .. '[ ' .. list2json(var[l]) .. ']'
    elseif tonumber(var[l]) ~= nil then
      js = js .. ' ' .. tonumber(var[l])
    else
      js = js .. ' "' .. var[l] .. '"'
    end -- if

    -- separate list values
    if l < (#var) then
      js = js .. ','
    end -- if
  end -- for l
  return js
end -- function list2json

local function callRedis(string)
  -- make redis connection using https://github.com/soveran/resp
  local resp = require("resp")
  -- enter redis connection details here
  local client = resp.new("127.0.0.1", 6379)

  local args = splitIntoArgs(string)
  local key = args[1]

  -- execute command
  local unpack = table.unpack
  local value = client:call(unpack(args))
  -- differentate between nil, type string and table (list in redis)
  if (value == nil) then
    return string2json(key, value)
  elseif (type(value) == "string") or (type(value) == "number")  then
    return string2json(key,value)
  else
    return '{' .. ' "' .. key .. '":[' .. list2json(value) .. '] }'
  end -- if (redis return type)
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
      ret = callRedis(input)
      self:write(ret)
    -- return redis2json(string.gsub(input, '%%', '%%%%'))
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

app:listen(8888)
turbo.ioloop.instance():start()