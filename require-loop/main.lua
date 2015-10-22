local Foo = require("foo")
local Bar = require("bar")

-- This to check that the native require still works
local socket = require("socket")

print("socket is at " .. tostring(socket))

Foo.printSomething()
Bar.printSomething()
