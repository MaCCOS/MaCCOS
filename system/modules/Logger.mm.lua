_logfile = "/system/logs/logfile.log"
_lastlogfile = "/system/logs/last.log"
_logger_started = false

Logger = {
	file = nil,
	start = function()
        if not _logger_started then
		  Logger.file = _OENV.fs.open(_lastlogfile, "w")
          _logger_started = true
        end
	end,

	log = function(string)
		if _logger_started then
			Logger.file.write(string)
		else
			System.debug(3, "Logger is not started!")
		end
	end,

	stop = function()
        if _logger_started then
            Logger.file.close()
            f = _OENV.fs.open(_lastlogfile, "r")
            data = f.readAll()
            f.close()

            log = _OENV.fs.open(_logfile, "a")
            log.writeLine("\n\n/*************************************************/")
            log.write(data)
            log.close()

            _logger_started = false
        end
	end
}
