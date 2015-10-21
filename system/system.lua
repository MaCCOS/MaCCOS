local _build = 2

function start()
	print("Welcome to MaCCOS [build " .. _build .. "]")
	return 0
end

function loop()
	write("> ")
	System.runProgram(read())
end

function stop()

end
