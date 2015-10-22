#!/usr/bin/env lua

local veryComplexData = {

	kMDItemAuthors = {
		{
			name = "Zubeldio",
			email = "email@yahoo.fr",
			adresse = {
				rue = "12 rue de la Fontaine",
				postal = 12345,
				town = "St Visual Studio",
			},
		}, {
			name = "Patrick",
			email = "email@hotmail.fr",
			adresse = {
				rue = "42 rue de Lua",
				postal = 97421,
				town = "St Vim",
			},
		}, {
			name = "Bill",
			adresse = {
				town = "St Emacs",
			},
			eretic = true,
		}
	},
	kMDItemComment = "some source code...",
	kMDItemContentType = "public.cpp",
	kMDItemCountry = "England",
	kMDItemFonts = "courier new",
	42,
}


function flatify(data)
	local flatDataTable = {}

	local function getkey(parentKey, childKey)
		local key
		if childKey and parentKey then
			key = parentKey .. ":" .. childKey
		else
			key = parentKey or childKey
		end
		if not key then
			key = "value"
		end
		return key
	end

	local function set(parentKey, childKey, value)
		local key = getkey(parentKey, childKey, value)
		flatDataTable[key] = value
	end

	local function flatifyThis(data, parentKey)
		if not (type(data) == "table") then
			set(parentKey, nil, data)
			return
		end

		for key, value in pairs(data) do
			if not type(value) == "table" then
				set(parentKey, key, value)
			else
				flatifyThis(value, getkey(parentKey, key))
			end
		end
	end

	flatifyThis(data)

	return flatDataTable
end


function dumpTable(tbl)
	for k, v in pairs(tbl) do
		print(k .. " → " .. tostring(v) .. " (" .. type(v) .. ")")
	end
end

local simpleData = flatify(veryComplexData)

print("---> Printing simple data ------------")

dumpTable(simpleData)

print("---> End -----------------------------")

dumpTable(flatify("bla"))
