local _build = 13

function start()
	System.println("Welcome to MaCCOS [build " .. _build .. "]")
    _OENV.os.run(Utils.GetEnv(), "/system/init")
	if not flags["--nogui"] then
		xstart()
	end
	return 0
end

function loop()
    if xluk == true then
        xloop()
    else
        System.print("\n/" .. Directory.get() .. "> ")
	    runProgram(System.read())
    end
end

function stop()
    return 0
end


--[[ System functions ]]--
runProgram = function(name)
	if name == nil then return end
	program = String.split(name)

	sys_app = "/sysapps/" .. Utils.ToString(program[1])
	usr_app = "/usr/apps/" .. Utils.ToString(program[1])

	if Directory.isFile(sys_app) then

		_OENV.table.remove(program, 1)
		_OENV.os.run(Utils.GetEnv(), sys_app, _OENV.unpack(program))
		return

	elseif Directory.isDir(usr_app) then

		prog = _OENV.coroutine.create(function()
			os.run(Utils.GetEnv(), usr_app .. "/main.lua", _OENV.unpack(program))
			main()
		end)
		_OENV.coroutine.resume(prog, program)

	else

		System.println("Program not found.")
		return

	end
end

getBuild = function()
    return _build
end
