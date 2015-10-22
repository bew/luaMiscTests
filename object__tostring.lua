local Var = {
	prototype = {}
}

Var.prototype.mt = {
	__tostring = function(self)
		return "(__tostring) " .. self.name .. " = " .. self.value
	end,
	__concat = function(obj1, obj2)
		return tostring(obj1) .. tostring(obj2)
	end,
}

function Var.new(name, value)
	local newvar = {
		_type = "Var",
		name = name,
		value = value,
	}
	return setmetatable(newvar, Var.prototype.mt)
end


---- TESTS ----

local variable = Var.new("bla", 42)

print("printing via tostring : " .. tostring(variable))

print("================================================")

print("printing via .. : " .. variable)
