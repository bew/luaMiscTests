local Mpd = require("mpd")

local client = Mpd.new()

function dump(tbl)
	if not (type(tbl) == "table") then
		return tostring(tbl)
	end
	local str = ""
	for k, v in pairs(tbl) do
		str = str .. "   " .. k .. " → " .. tostring(v) .. "			(" .. type(v) .. ")" .. "\n"
	end
	return str
end


print("\nclient dump")
print("=============================")
print(dump(client))

print("\nmpd status")
print("=============================")
print(dump(client:send("status")))
