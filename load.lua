
function get(code)
	local f, e = load(code)
	if f then
		local results = { pcall(f) }
		if not results[1] then
			return "error", results[2]
		end
		table.remove(results, 1)

		local retvals = {}
		for _, v in ipairs(results) do
			local t = type(v)
			if t == "boolean" then
				table.insert(retvals, "b")
				table.insert(retvals, v)
			elseif t == "number" then
				table.insert(retvals, "d")
				table.insert(retvals, v)
			else
				table.insert(retvals, "s")
				table.insert(retvals, tostring(v))
			end
		end
		return unpack(retvals)
	elseif e then
		return "syntax error", e
	end
end

local awesome = {}

print(get("return 3 + nil"))


