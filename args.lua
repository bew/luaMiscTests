#!/usr/bin/env lua

print(arg[-1])
if #arg == 0 then return end
for k, v in pairs(arg) do
	print(v)
end
