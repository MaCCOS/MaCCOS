System = {
	halt = os.shutdown,
	reboot = os.reboot,
	exit = function() _running = false end
}