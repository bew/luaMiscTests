



local function get_all_local(func_level)
	func_level = func_level or 1
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

local function string_interpolation(str, func_level)
	func_level = func_level or 1

	local function locals_to_kv(locals)
		local kv = {}

		for _, var in ipairs(locals) do
			kv[var.name] = var.value
		end

		return kv
	end

	local caller_locals = get_all_local(func_level + 1)
	local caller_locals_kv = locals_to_kv(caller_locals)


	local result_str = str:gsub('(#%b{})', function(w)
		local name = w:sub(3, -2)
		return caller_locals_kv[name] or _ENV[name] or name
	end)
	return result_str
end


local function printi(str)
	local interp_str = string_interpolation(str, 2)
	print(interp_str)
end

local name = "Benoit"
age = 20

printi "Hello, I'm #{name}, and I'm #{age}"


