#!/usr/bin/env lua

local inputTable = {
	a = "newAContent",
	b = "bContent",
	c = 42,
	y = "yContent",
	z = "zContent",
}


local myTable = {
	a = "aContent",
	b = "bContent",
	c = "cContent",
	d = "dContent",
}


local function tableDiff(input, base)
	-- the input & base tables has only one deepness

	local result = {
		add = {},
		remove = {},
		change = {},
	}

	for key, newValue in pairs(input) do
		if not (type(newValue) == "table") then
			local baseValue = base[key]

			if not baseValue then
				result.add[key] = newValue
			elseif not (newValue == baseValue) then
				result.change[key] = newValue
			end
		end
	end

	for key,_ in pairs(base) do
		if not input[key] then
			result.remove[key] = true
		end
	end

	return result
end


local function dump(data, shift, tag)
	local result = ""

	if tag then
		result = result .. tostring(tag) .. " : "
	end

	if type(data) ~= "table" then
		return result .. tostring(data) .. " (" .. type(data) .. ")"
	end

	shift = (shift or "") .. "  "
	for k, v in pairs(data) do
		result = result .. "\n" .. shift .. dump(v, shift, k)
	end

	return result
end

print("\n=> Starting with INPUT :")
print(dump(inputTable))
print("\n=> and BASE :")
print(dump(myTable))

local diffs = tableDiff(inputTable, myTable)

print("\n\n====== DIFF =====")
print(dump(diffs))
