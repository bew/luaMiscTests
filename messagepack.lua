local MsgPack = require("MessagePack")

local data = {
	route = "/eval",
	"field",
	field1 = "value1",
	field2 = "value2",
}

local str = MsgPack.pack(data)

print(str, #str)

local dataBack = MsgPack.unpack(str)

for k, v in pairs(dataBack) do
	print(k .. " → " .. tostring(v))
end

