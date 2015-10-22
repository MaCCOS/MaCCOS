local _build = 4

function start()
	print("Welcome to MaCCOS [build " .. _build .. "]")
	return 0
end

function loop()
	write("\n/" .. Directory.get() .. "> ")
	System.runProgram(read())
end

function stop()

end
