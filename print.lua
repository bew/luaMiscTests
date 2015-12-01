
function returnPrint(...)
	local args = {...}
	local ret = ""
	for i, v in ipairs(args) do
		ret = ret .. tostring(v) .. "\t"
	end
	ret = ret .. "\n"
	return ret
end


io.write(returnPrint(1, 2, 3, returnPrint))



local t = {
	1,
	2,
	3,
	returnPrint,
}


io.write(returnPrint(unpack(t)))
