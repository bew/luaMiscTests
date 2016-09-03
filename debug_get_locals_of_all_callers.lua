-- luacheck: ignore global_var local_var get_all_infos
global_var = 21

local function d(w)
	if not w then print("nothing") return end
	for k,v in pairs(w) do print(k, " → ", v) end
end

function get_all_locals(level)
	level = level and level + 1 or 2

	local all_locals = {}

	while debug.getinfo(level) do
		print("Function level " .. level)

		local local_level = 1

		local var, value
		while true do
			var, value = debug.getlocal(level, local_level)
			if not var then break end
			print("local " .. var, value)
			if var:sub(1, 1) ~= "(" then
				table.insert(all_locals, {name = var, value = value})
			else
				print("  ↪ not usable")
			end
			local_level = local_level + 1
		end
		level = level + 1
		print()
	end

	return all_locals
end

local file_local_var = 84

local function eval_with_all_local_access(eval_str)
	local local_var = 42
	print("=========== Eval setup ==========================")
	local all_locals = get_all_locals()

	local eval_env = {}
	-- copy global env
	for k, v in pairs(_ENV) do
		eval_env[k] = v
	end

	-- locals must override globals
	for _, local_var in ipairs(all_locals) do
		eval_env[local_var.name] = local_var.value
	end

	print("=================================================")
	print()
	return load(eval_str, nil, nil, eval_env)
end

local function call()
	local call_local = 22
	local f = eval_with_all_local_access([[print("ENV I have access:"); d(_ENV)]])
	f()
end

call()
