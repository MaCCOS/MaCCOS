String = {
	split = function(input, reg)
		if reg == nil then
			reg = "%s"
		end
		local t = {}
		i = 1
		for str in _OENV.string.gmatch(input, "([^" .. reg .. "]+)") do
			t[i] = str
			i = i + 1
		end
		return t
	end
}
