local metametatable = {
	__index = function (self, key)
		if key == "__index" then
			return function()
				return "bla"
			end
		end
	end,
}
local metatable = setmetatable({}, metametatable)

local aTable = {}
setmetatable(aTable, metatable)


print(aTable.unknownkey)
