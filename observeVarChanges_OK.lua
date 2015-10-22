local Config = {
	prototype = {},
}

local space = "                                        "

Config.prototype.mt = {
	__index = function(self, key)
		print(space .. "* Accessing key '" .. key .. "'")
		-- Check if it's a prototype field
		if Config.prototype[key] then
			return Config.prototype[key]
		end
		-- Check if it's a config key
		local keys = rawget(self, "__keys")
		if keys and keys[key] then
			return keys[key]
		end
		return nil
	end,

	__newindex = function(self, key, value)
		--Var.unlock(self, myUnlocker)
		if not self.__keys[key] then
			print(space .. "* Creating key '" .. key .. "' with default value '" .. value .. "'")
			self.__defaultValue[key] = value
		else
			print(space .. "* Updating key '" .. key .. "' with value '" .. value .. "'")
		end
		self.__keys[key] = value
		--Var.lock(self)
	end,
}





function Config.prototype:print()
	for key, value in pairs(self.__keys) do
		local t = type(value)
		if t == "number" or t == "string" then
			print(key .. " → " .. value)
		end
	end
end

function Config.prototype:reset(key)
	if self.__keys[key] then
		self.__keys[key] = self.__defaultValue[key]
	end
	return self.__keys[key]
end




function Config.new()
	local newConfig = {
		__keys = {},
		__defaultValue = {},
	}
	return setmetatable(newConfig, Config.prototype.mt)
end




local Keymap = {}

Keymap.config = Config.new()

local conf = Keymap.config

print("\n=> init preferences with default value")
conf.pref1 = "defaultValue1"

conf.pref2 = "defaultValue2"

conf.pref3 = "defaultValue3"

print("\n=> see prefs")
conf:print()

print("\n=> modif preferences")
conf.pref1 = "newValue1"
conf.pref2 = "newValue2"
conf.pref3 = "newValue3"

print("\n=> use prefs")
print("pref1 is " .. conf.pref1)
print("pref2 is " .. conf.pref2)
print("pref3 is " .. conf.pref3)

print("\n=> reset some prefs")
conf:reset("pref2")

print("\n=> see prefs")
conf:print()
