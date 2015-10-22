-- read environment variables as if they were global variables

setmetatable(_G, {
	__index = function (t,i)
		return "#> " .. tostring(i) .. " is " .. tostring(os.getenv(i))
	end
})

-- an example
print(a)
print(USER)
print(PATH)
