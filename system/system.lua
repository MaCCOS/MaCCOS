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

	sys_app = "/sysapps/" .. tostring(program[1])
	usr_app = "/usr/apps/" .. tostring(program[1])

	if Directory.isFile(sys_app) then
		table.remove(program, 1)
		os.run(getfenv(), sys_app, unpack(program))
		return
	elseif Directory.isDir(usr_app) then
		prog = coroutine.create(function()
			os.run(getfenv(), usr_app .. "/main.lua", unpack(program))
			main()
		end)
		coroutine.resume(prog, program)
	else
		System.println("Program not found.")
		return
	end
end

getBuild = function()
    return _build
end