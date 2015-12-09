local obj = {
	rawField = "some value",
}

setmetatable(obj, {
	__index = function(self, key)
		return "bla for " .. key
	end,
})

setmetatable(obj, {
	__call = function(self, ...)
		print("calling with", ...)
	end,
})



print(obj.unknownKey)

obj("arg1", "arg2")
