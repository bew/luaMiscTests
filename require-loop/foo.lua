require("require")

local Foo = {}
require.register(Foo)

local Bar = require("bar")


Foo.whoami = "Foo"

function Foo.printSomething()
	print("printing from Foo with my friend " .. Bar.whoami .. " at " .. tostring(Bar))
end

return Foo
