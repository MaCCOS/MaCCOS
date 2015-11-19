_logfile = "/system/logs/logfile.log"
_lastlogfile = "/system/logs/last.log"

Logger = {
	file = nil,
	start = function()
		file = fs.open(_lastlogfile, "w")
		return file
	end,
	log = function(string)
		msg = "[" .. os.time() .. "] " .. string
		print(msg)
		file.writeLine(msg)
	end,
	stop = function()
		file.close()
		f = fs.open(_lastlogfile, "r")
		data = f.readAll()
		f.close()

		log = fs.open(_logfile, "a")
		log.writeLine("\n\n/********************/")
		log.write(data)
		log.close()
	end
}
