local native = {}

if type(require) == "function" then
	native.require = require
end

-- This will create : {
--	  name = <Current module name>,
--	  path = <Current file name>,
-- }
local module
do
	local args = {...}
	module = {
		name = args[1],
		path = args[2],
	}
end

local packageList = {
	[module.name] = true,
}


local stackOfPackageNames = {}

local function registerPackage(package)
	local currentPackage = #stackOfPackageNames ~= 0 and table.remove(stackOfPackageNames) or nil
	print("registering package, current required package is " .. tostring(currentPackage))
	if not currentPackage then
		return
	end

	print("registering package at " .. tostring(package) .. " for package " .. currentPackage)
	packageList[currentPackage] = package
	return package
end

local function doRequire(packageName, ...)
	print("\nrequiring package '" .. packageName .. "'")
	--print(debug.traceback())
	table.insert(stackOfPackageNames, packageName)

	-- do we already have it ?
	local package = packageList[packageName]
	if package then
		print("#++ We have it, return it !")
		table.remove(stackOfPackageNames)
		return package
	end

	-- no, load it with the native require
	print("#-- we don't have it, load with native.require")
	local resultRequire = native.require(packageName, ...)
	table.remove(stackOfPackageNames)
	return resultRequire
end

-- luacheck: ignore require
require = setmetatable({}, {
	__call = function(_, ...)
		return doRequire(...)
	end,
})

require.register = registerPackage

return require
