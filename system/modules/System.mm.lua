System = {
	halt = function()
        Logger.stop()
        os.shutdown()
    end,
    
	reboot = function()
        Logger.stop()
        os.reboot()
    end,
    
	exit = function() _running = false end,
    
    print = function(str)
        if not flags["--silent"] then
            write(str)
            Logger.log(str)
        end
    end,
    
    println = function(str)
        System.print(str .. "\n")
    end,
    
    read = function()
        input = read()
        Logger.log(input)
        
        return input
    end,
    
    --[[WIP]]--
    AddToInit = function(program)
        if Directory.exists("/sysapps/" .. program) then
            init_file = fs.open("/system/init", "a")
            init_file.writeLine("shell.run('" .. "/sysapps/" .. program .. "')")
            init_file.close()
        else
            System.println("Program not found.")
        end
    end
    
}