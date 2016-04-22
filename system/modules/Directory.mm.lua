_dir = ""

Directory = {
	_setc = function() Utils.shell.setDir(_dir) end,

	set = function(str)
		dir = Utils.shell.resolve(str)
		if Directory.exists(dir) and Directory.isDir(dir) then
			_dir = Utils.shell.resolve(str)
			if _dir == nil then _dir = "" end
			Directory._setc()
			return true
		else
			System.println("Directory not found")
			return false
		end
	end,
	get = function() return _dir end,
	list = _OENV.fs.list,
	exists = _OENV.fs.exists,
	isDir = _OENV.fs.isDir,
	create = _OENV.fs.makeDir,
	remove = _OENV.fs.delete,
	isFile = function(str) return Directory.exists(str) and not Directory.isDir(str) end
}
