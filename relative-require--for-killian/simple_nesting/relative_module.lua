print("IN simple_nesting/relative_module.lua")
print("package.path:", package.path)
print()

print("Now, let's try to require 'other_relative_module'")
require("other_relative_module")
