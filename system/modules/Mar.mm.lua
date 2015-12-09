base_url = "https://raw.githubusercontent.com/MaCCOS/MAR/master/stable/"

Mar = {

	DownloadFileList = function(app_name)
		data = Internet.DownloadFile(base_url .. app_name .. "/file.lst")

		files = String.split(data, ",")
		--[[data:gsub(",", function(c) table.insert(files,c) end)
		for i=1,#files do
			print(files[i])
		end]]
		return files
	end,

	GetAppSize = function(app_name)
		size = 0
		files = fs.list("/usr/apps/" .. app_name)

		for i = 1, #files do
			f = fs.open("/usr/apps/" .. app_name .. "/" .. files[i], "r")
			data = f.readAll()
			size = size + tonumber(string.len(data))
			f.close()
		end

		return size
	end,
	
	DownloadApp = function(app_name)
		files = Mar.DownloadFileList(app_name)

		for i = 1, #files do
			print("File:" .. files[i])
			f = fs.open("/usr/apps/" .. app_name .. "/" .. files[i], "w")
			f.write(Internet.DownloadFile(base_url .. app_name .. "/" .. files[i]))
			f.close()
		end
	end,

	RemoveApp = function(app_name)
		print("Removing this app will free up " .. Mar.GetAppSize(app_name) .. "B of space.")
		write("Are you sure you want to remove this app? (y/N): ")
		r = read()
		if r == "y" or r == "Y" then
			print("Deleting app: " .. app_name)
			Directory.remove("/usr/apps/" .. app_name)
		else
			print("App not removed")
		end
	end,

	UpdateApp = function(app_name)
		--Check app version
	end
}