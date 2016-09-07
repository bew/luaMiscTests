
local function named_explode(names, ...)
	if not names or type(names) ~= "table" then
		return
	end

	local nb_args = select('#', ...)
	local max = math.min(nb_args, #names)

	local result = {select(max + 1, ...)}

	for i = 1, max do
		local key = names[i]
		result[key] = select(i, ...)
	end

	return result
end


local function get_somethings()
	return 1, 2, 3, 4, 5, "Some", "other", "args"
end

local tbl = named_explode({"one", "two", "three", "four", "five"}, get_somethings())

print(tbl.one)
print(tbl.two)
print(tbl.three)
print(tbl.four)
print(tbl.five)

for i, value in ipairs(tbl) do
	print("pos:" .. i .. "> " .. value)
end
