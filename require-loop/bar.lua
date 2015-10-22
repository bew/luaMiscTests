require("require")

local Bar = {}
require.register(Bar)

local Foo = require("foo")


Bar.whoami = "Bar"

function Bar.printSomething()
	print("printing from Bar with my friend " .. Foo.whoami .. " at " .. tostring(Foo))
end

return Bar
