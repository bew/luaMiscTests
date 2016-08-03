-- getopt_alt.lua

-- getopt, POSIX style command line argument parser
-- param arg contains the command line arguments in a standard table.
-- param options is a string with the letters that expect string values.
-- returns a table where associated keys are true, nil, or a string value.
-- The following example styles are supported
--   -a one  ==> opts["a"]=="one"
--   -bone   ==> opts["b"]=="one"
--   -c      ==> opts["c"]==true
--   --c=one ==> opts["c"]=="one"
--   -cdaone ==> opts["c"]==true opts["d"]==true opts["a"]=="one"
-- note POSIX demands the parser ends at the first non option
--      this behavior isn't implemented.

---------------------------------------------------------------
-- TODO: rework the args, do something more expressive
---------------------------------------------------------------

local function getopt( args, options )
	local tab = {}
	for arg_idx, arg in ipairs(args) do
		if string.sub( arg, 1, 2) == "--" then
			local equal_idx = string.find( arg, "=", 1, true )
			if equal_idx then
				tab[ string.sub( arg, 3, equal_idx - 1 ) ] = string.sub( arg, equal_idx + 1 )
			else
				tab[ string.sub( arg, 3 ) ] = true
			end
		elseif string.sub( arg, 1, 1 ) == "-" then
			local position = 2
			local arg_len = string.len(arg)
			while position <= arg_len do
				local opt_letter = string.sub( arg, position, position )
				if string.find( options, opt_letter, 1, true ) then
					if position < arg_len then
						tab[ opt_letter ] = string.sub( arg, position+1 )
						position = arg_len
					else
						tab[ opt_letter ] = arg[ arg_idx + 1 ]
					end
				else
					tab[ opt_letter ] = true
				end
				position = position + 1
			end
		end
	end
	return tab
end

-- Test code
local opts = getopt( arg, "ab" )
for k, v in pairs(opts) do
	print( k, v )
end

-- EOF
