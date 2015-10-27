local _build = 5

function start()
	print("Welcome to MaCCOS [build " .. _build .. "]")
	return 0
end

function loop()
	write("\n/" .. Directory.get() .. "> ")
	runProgram(read())
end

function stop()

end


--[[ System functions ]]--
runProgram = function(name)
	if name == nil then return end
	program = String.split(name)

	sys_app = "/sysapps/" .. tostring(program[1])
	usr_app = "/usr/apps/" .. tostring(program[1])

	if Directory.isFile(sys_app) then
		table.remove(program, 1)

		prog = coroutine.create(function()
			os.run(getfenv(), sys_app, unpack(program))
		end)
		coroutine.resume(prog, program)

		return
	elseif Directory.isDir(usr_app) then

	else
		print("Program not found.")
		return
	end
end
