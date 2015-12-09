local obj = {}

local metatable = {
	__index = function(self, key)
		return "bla for " .. key
	end,
}

setmetatable(obj, metatable)

print(obj.unknownKey)

metatable.__call = function(self, ...)
	print("Calling with", ...)
end

obj("arg1", "arg2")
