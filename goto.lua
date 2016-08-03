local i = 0

::label::
i = i + 1
print("i = " .. i)
if i == 10 then
	goto done
end
goto label

::done::
print("gotos are working :p")
