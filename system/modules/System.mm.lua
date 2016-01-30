System = {
	halt = os.shutdown,
    
	reboot = function()
        Logger.stop()
        os.reboot()
    end,
    
	exit = function() _running = false end,
    
    print = function(str)
        write(str)
        Logger.log(str)
    end,
    
    println = function(str)
        System.print(str .. "\n")
    end,
    
    read = function()
        input = read()
        Logger.log(input)
        
        return input
    end,
    
    AddToInit = function(program)
        init_file = fs.open("/system/init", "a")
        init.writeLine("shell.run('" .. program .. "')")
        init_file.close()
    end
    
}