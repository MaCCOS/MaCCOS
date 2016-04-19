local _build = 7

function start()
	System.println("Welcome to MaCCOS [build " .. _build .. "]")

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

	sys_app = "/sysapps/" .. _OLD_ENV.tostring(program[1])
	usr_app = "/usr/apps/" .. _OLD_ENV.tostring(program[1])

	if Directory.isFile(sys_app) then
		_OLD_ENV.table.remove(program, 1)
		_OLD_ENV.os.run(_OLD_ENV.getfenv(), sys_app, _OLD_ENV.unpack(program))
		return
	elseif Directory.isDir(usr_app) then
		prog = _OLD_ENV.coroutine.create(function()
			os.run(_OLD_ENV.getfenv(), usr_app .. "/main.lua", _OLD_ENV.unpack(program))
			main()
		end)
		_OLD_ENV.coroutine.resume(prog, program)
	else
		System.println("Program not found.")
		return
	end
end

getBuild = function()
    return _build
end
