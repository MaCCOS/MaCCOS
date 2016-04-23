System = {
	Halt = function()
        Logger.stop()
        _OENV.os.shutdown()
    end,

	Reboot = function()
        Logger.stop()
        _OENV.os.reboot()
    end,

	Exit = function() _running = false end,

    Print = function(str)
        if not flags["--silent"] then
            _OENV.write(str)
            Logger.log(str)
        end
    end,

    PrintLn = function(str)
        System.Print(str .. "\n")
    end,

    Read = function()
        input = _OENV.read()
        Logger.log(input)

        return input
    end,

	Debug = function(level, msg)
		if flags["--debug"] then
			if     level == 0 then level = "INFO"
			elseif level == 1 then level = "WARNING"
			elseif level == 2 then level = "ERROR"
			elseif level == 3 then level = "FATAL"
			end
			System.PrintLn("[" .. level .. "] " .. msg)
		end
	end,

	GetUsrApps = function()
		return Directory.list("/sysapps")
	end,

	GetSysApps = function()
		return Directory.list("/usr/apps")
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
