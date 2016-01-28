#!/usr/bin/env lua

local Socket = require"socket"
local MsgPack = require"MessagePack"



host = host or "localhost"
port = port or 1234
if arg then
	host = arg[1] or host
	port = arg[2] or port
end

local tcp = assert(Socket.tcp())
local success, status = tcp:connect(host, port)
if status == "connection refused" then
	print()
	print("Cannot connect to server on " .. host .. ":" .. port)
	print("You must first start the server.lua")
	print()
	os.exit(false)
end

while true do
	local msg, status, err = tcp:receive();

	if status == "closed" then
		break
	end

	if err then
		print(err)
	else

		print(msg)

	end
end

print("finish")
