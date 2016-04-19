System = {
	halt = function()
        Logger.stop()
        _OLD_ENV.os.shutdown()
    end,

	reboot = function()
        Logger.stop()
        _OLD_ENV.os.reboot()
    end,

	exit = function() _running = false end,

    print = function(str)
        if not flags["--silent"] then
            _OLD_ENV.write(str)
            Logger.log(str)
        end
    end,

    println = function(str)
        System.print(str .. "\n")
    end,

    read = function()
        input = _OLD_ENV.read()
        Logger.log(input)

        return input
    end,

    --[[WIP]]--
    AddToInit = function(program)
        if Directory.exists("/sysapps/" .. program) then
            init_file = _OLD_ENV.fs.open("/system/init", "a")
            init_file.writeLine("shell.run('" .. "/sysapps/" .. program .. "')")
            init_file.close()
        else
            System.println("Program not found.")
        end
    end

}
