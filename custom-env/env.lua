global = "global"

local oldEnv = _ENV

local newEnv = {
	print = print,
	global = "little global",
}

print("Top level, env is at", _ENV)

--dofile("./script.lua", "f", newEnv)
local filechunk = assert(loadfile("./script.lua", "t", newEnv))
local _, err = pcall(filechunk)
if err then
	error(err)
end

print("Back to top level, env is at", _ENV)

