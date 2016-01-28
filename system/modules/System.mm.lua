System = {
	halt = os.shutdown,
	reboot = os.reboot,
	exit = function() _running = false end,
    
    AddToInit = function(program)
        init_file = fs.open("/system/init", "a")
        init.writeLine("shell.run('" .. program .. "')")
        init_file.close()
    end
    
}