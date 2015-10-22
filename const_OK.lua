local Var = {
	prototype = {},
}

--TODO find better typo
function Var.prototype:newConst(name, value)
	if not self.__const then
		self.__const = {}   -- this is a 'setOnce' table type (TODO) (each fields must be set only once
	end
	if self.__const[name] then
		return self.__const[name]
	end
	self.__const[name] = value
end

function Var.new(tbl)
	local tbl = tbl or {}
	return setmetatable(tbl, Var.mt)
end

Var.mt = {
	__index = function (self, key)
		local const = rawget(self, "__const")
		if const and const[key] then
			return const[key]
		end
		return Var.prototype[key]
	end,

	__newindex = function (self, key, value)
		if self.__const then
			local oldVal = self.__const[key]
			if oldVal then
				print("→ Cannot set " .. key .. " to " .. value .. ", because this is a constant with value '" .. oldVal .. "'")
				return
			end
		end
		print("→ Adding field '" .. key .. "' with value of type '" .. type(value) .. "'")
		rawset(self, key, value)
	end
}



-- Usage

local var = Var.new({ oldVar = 21 })

var:newConst("const1", "constantValue")

print(var.const1)

var.const1 = "newValue"

print(var.const1)

var.variable = 42

print(var.variable)
