System = {
	halt = function()
        Logger.stop()
        _OENV.os.shutdown()
    end,

	reboot = function()
        Logger.stop()
        _OENV.os.reboot()
    end,

	exit = function() _running = false end,

    print = function(str)
        if not flags["--silent"] then
            _OENV.write(str)
            Logger.log(str)
        end
    end,

    println = function(str)
        System.print(str .. "\n")
    end,

    read = function()
        input = _OENV.read()
        Logger.log(input)

        return input
    end,

	debug = function(level, msg)
		if flags["--debug"] then
			if     level == 0 then level = "INFO"
			elseif level == 1 then level = "WARNING"
			elseif level == 2 then level = "ERROR"
			elseif level == 3 then level = "FATAL"
			end
			System.println("[" .. level .. "] " .. msg)
		end
	end,

    --[[WIP]]--
    AddToInit = function(program)
        if Directory.exists("/sysapps/" .. program) then
            init_file = _OENV.fs.open("/system/init", "a")
            init_file.writeLine("shell.run('" .. "/sysapps/" .. program .. "')")
            init_file.close()
        else
            System.println("Program not found.")
        end
    end

}
