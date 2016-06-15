-- TurboWebdis config

return { 
	["turbo"] = { ["port"] = 8888, ["logging"] = false, ["CORS"] = false, ["JSONP"] = true },
	["redis"] = { ["host"] = "127.0.0.1", ["port"] = 6379, ["auth"] = "", ["db"] = "0"}
}
