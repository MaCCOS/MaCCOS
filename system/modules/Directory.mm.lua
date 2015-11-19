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
			print("Directory not found")
			return false
		end
	end,
	get = function() return _dir end,
	list = fs.list,
	exists = fs.exists,
	isDir = fs.isDir,
	create = fs.makeDir,
	remove = fs.delete,
	isFile = function(str) return Directory.exists(str) and not Directory.isDir(str) end
}