-- tinywebdis 0.2
function main(input)

  -- parsing number of arguments (path based)
  input,argCount = string.gsub(input, "/", "%1")
  if ((argCount == 1) and (#input == 1)) then

    return "<html><body><pre>" ..
    "usage: command/key/option[1]/option[2]/..." ..
    "</pre></body></html>"

  else
    -- arguments path based
    return redis2json(input, argCount)

  end -- if
end -- function main


function splitIntoArgs(path)
  local args = {}

  for arg in string.gmatch(path, "[^/]+") do
    table.insert(args, arg)
  end

  return args
end


function string2json(key, value)
  if tonumber(value) ~= nil then
    return '{"' .. key .. '": ' .. tonumber(value) .. ' }'
  elseif (value == nil) then
    return '{"' .. key .. '": null }'
  else
    return '{"' .. key .. '": "' .. value .. '" }'
  end
end -- function key2json


function list2json(key, var)

  -- get values of a list
  local js = '{' .. ' "' .. key .. '":['

  for l = 1,(#var) do

    if tonumber(var[l]) ~= nil then
      js = js .. ' ' .. tonumber(var[l])
    else
      js = js .. ' "' .. var[l] .. '"'
    end -- if

    -- separate list values
    if l < (#var) then
      js = js .. ','
    else
      js = js .. '] '
    end -- if

  end -- for l

  return js .. ' }'

end -- function list2json


function redis2json(string, argCount)

  -- make redis connection using https://github.com/soveran/resp
  local resp = require("resp")
  -- enter redis connection details here
  local client = resp.new("127.0.0.1", 6379)

  local args = splitIntoArgs(string)
  local key = args[1]

  -- execute command
  local value = client:call(unpack(args))

  -- differentate between nil, type string and table (list in redis)
  if (value == nil) then
    return string2json(key, value)
  elseif (type(value) == "string") or (type(value) == "number")  then
    return string2json(key,value)
  else
    return list2json(key,value)
  end -- if t (redis type)
end -- function rediscall

