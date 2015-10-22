#!/usr/bin/env lua

-- Some Utils

local utils = {}

function utils.dump(data, shift, tag)
	local result = ""

	if tag then
		result = result .. tostring(tag) .. " : "
	end

	if type(data) ~= "table" then
		return result .. tostring(data) .. " (" .. type(data) .. ")"
	end

	shift = (shift or "") .. "  "
	for k, v in pairs(data) do
		result = result .. "\n" .. shift .. utils.dump(v, shift, k)
	end

	return result
end

function utils.merge(base, options)
	for k, v in pairs(options) do
		base[k] = v
	end
	return base
end

-- Some Objects

local Object = {}
local Obj2 = {}

function Object.new(base, str)
	local str = str and str or "no string given"
	local obj = {
		[str] = str,
	}
	return utils.merge(base or {}, obj)
end

setmetatable(Object, {
	__call = function(_, ...)
		return Object.new(...)
	end
})

function Obj2.new(base, str1, str2, options)
	local babyobj = {
		bigstr = str1,
		littlestr = str2,
		options = options,
	}
	return utils.merge(base or {}, babyobj)
end




-- NEW System
function new(tblClasses, baseInstance)

	local base = baseInstance or {}

	for func, args in pairs(tblClasses) do
		local t, ta = type(func), type(args)
		if t == "function" or t == "table" then
			func(base, unpack(args))
		elseif t == "number" and (ta == "function" or ta == "table") then
			func = args
			func(base)
		end
	end

	return base
end

-- NEW Test

local newobj = new({
	[Object] = { "blabla" },
	[Obj2.new] = { "BigSTR", "LittleSTR", {
		option1 = "opt1",
		option2 = "opt2",
		option3 = "opt3",
	} },
	Object,
}, { base = "base" })

-- NEW Debug

print("========= final =========")
print(utils.dump(newobj))
