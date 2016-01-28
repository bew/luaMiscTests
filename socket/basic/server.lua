#!/usr/bin/env lua

-----------------------------------------------------------------------------
-- TCP sample: Little program to send text lines to a given host/port
-- LuaSocket sample files
-- Author: Diego Nehab
-----------------------------------------------------------------------------

local Socket = require("socket")
local MsgPack = require"MessagePack"

host = host or "localhost"
port = port or 1234
if arg then
	host = arg[1] or host
	port = tonumber(arg[2]) or port
end

print("Attempting connection to host '" ..host.. "' and port " ..port.. "...")

local tcp = assert(Socket.tcp())
assert(tcp:bind(host, port))
assert(tcp:listen(10))

if port == 0 then
	_, port = tcp:getsockname()
end

print("Server is ready, client can connect to " .. host .. ":" .. port)

local connectedClients = {}

local counter = 0

while true do

	local readSocks = Socket.select({tcp}, nil, 0)
	if readSocks and readSocks[1] == tcp then
		tcp:settimeout(0) -- non blocking accept
		local newClient = tcp:accept()
		if newClient then
			table.insert(connectedClients, newClient)
			print("We have a new client !!", newClient)
		end
	end

	local deadClients = {}
	for i, client in ipairs(connectedClients) do
		local _, status, err = client:send("Number is " .. counter .. "\n")

		if status == "closed" then
			print("A client disconnected..", client)
			table.insert(deadClients, i)
		end
	end

	for _, id in ipairs(deadClients) do
		table.remove(connectedClients, id)
	end
	deadClients = nil

	Socket.sleep(0.5) -- wait 1/2 sec

	counter = counter + 1

end

print("finish")
print("bye")
