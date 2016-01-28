#!/usr/bin/env lua

print("exec     : " .. arg[-1])
print("script   : " .. arg[0])
print("nb args  : " .. #arg)

if #arg == 0 then
	return
end

print("===== ARGS =====")
for k, v in ipairs(arg) do
	print(k .. " → " .. v)
end
