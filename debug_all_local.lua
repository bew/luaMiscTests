



local function get_all_local(func_level)
	local local_level = 1

	local locals = {}

	local var, value
	while true do
		var, value = debug.getlocal(func_level + 1, local_level)
		if not var then break end
		table.insert(locals, {name = var, value = value})
		local_level = local_level + 1
	end

	return locals
end

local function print_infos()
	local caller = debug.getinfo(2)
	caller.locals = get_all_local(2)

	print("In function: " .. tostring(caller.name))

	for _, var in ipairs(caller.locals) do
		print("  local " .. tostring(var.name) .. " = " .. tostring(var.value) )
	end
end



-- Use
local function do_something()
	local var1 = 2
	local var2 = 890
	local var3 = 32

	print_infos()
end

do_something()

