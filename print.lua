
local function returnPrint(...)
	local nb_args = select("#", ...)
	local ret = ""
	for i = 1, nb_args do
		local arg = select(i, ...)
		ret = ret .. tostring(arg) .. "\t"
	end
	ret = ret .. "\n"
	return ret
end


io.write(returnPrint(1, 2, nil, returnPrint))



local t = {
	1,
	2,
	nil,
	returnPrint,
}


io.write(returnPrint(unpack(t)))
