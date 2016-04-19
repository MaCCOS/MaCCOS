_dir = ""

Directory = {
	_setc = function() shell.setDir(_dir) end,

	set = function(str)
		dir = shell.resolve(str)
		if Directory.exists(dir) and Directory.isDir(dir) then
			_dir = shell.resolve(str)
			if _dir == nil then _dir = "" end
			Directory._setc()
			return true
		else
			System.println("Directory not found")
			return false
		end
	end,
	get = function() return _dir end,
	list = _OLD_ENV.fs.list,
	exists = _OLD_ENV.fs.exists,
	isDir = _OLD_ENV.fs.isDir,
	create = _OLD_ENV.fs.makeDir,
	remove = _OLD_ENV.fs.delete,
	isFile = function(str) return Directory.exists(str) and not Directory.isDir(str) end
}
