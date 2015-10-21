local _build = 3

function start()
	print("Welcome to MaCCOS [build " .. _build .. "]")
	return 0
end

function loop()
	write("/" .. Directory.get() .. "> ")
	System.runProgram(read())
end

function stop()

end
