base_url = "https://raw.githubusercontent.com/MaCCOS/MAR/master/stable/"
base_app_dir = "/usr/apps/"
Mar = {

	DownloadFileList = function(app_name)
		data = Internet.DownloadFile(base_url .. app_name .. "/app.json")
		return decode(data).files
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
    
    GetAppData = function(app_name)
        json_file = fs.open(base_app_dir .. app_name .. "/app.json", "r")
        json_encoded = json_file.readAll()
        
        app_data = decode(json_encoded)
        json_file.close()

        return app_data
    end,

	DownloadApp = function(app_name, flags)
        if not flags["--silent"] then print("Downloading app: " .. app_name) end
		json = Internet.DownloadFile(base_url .. app_name .. "/app.json")
		data = decode(json)

		f = fs.open(base_app_dir .. app_name .. "/app.json", "w")
		f.write(json)
		f.close()
		
        files = data.files
		for i = 1, #files do
            if not flags["--silent"] then print("File:" .. files[i]) end
			f = fs.open(base_app_dir .. app_name .. "/" .. files[i], "w")
			f.write(Internet.DownloadFile(base_url .. app_name .. "/" .. files[i]))
			f.close()
		end
        if not flags["--silent"] then print("App successfully installed") end
	end,

	RemoveApp = function(app_name, flags)
        if not flags["--silent"] then
            print("Removing this app will free up " .. Mar.GetAppSize(app_name) .. "B of space.")
            write("Are you sure you want to remove this app? (y/N): ")
            r = read()
            if r == "y" or r == "Y" then
                print("Deleting app: " .. app_name)
                Directory.remove("/usr/apps/" .. app_name)
            else
                print("App not removed")
            end
        else
            Directory.remove("/usr/apps/" .. app_name)
        end
	end,

	UpdateApp = function(app_name, flags)
        json = Internet.DownloadFile(base_url .. app_name .. "/app.json")
		data = decode(json)
        local_data = Mar.GetAppData(app_name)
        
        new_version = data.version.major
        local_version = local_data.version.major
        
        if new_version > local_version or flags["--force"] ~= nil then
            if not flags["--silent"] then
                print("An update is avaliable!")
                print("New version: " .. new_version .. " - Installed version: " .. local_version)
            end
            --Would you like to update?
            
            Mar.RemoveApp(app_name, { ["--silent"] = true })
            Mar.DownloadApp(app_name, { ["--silent"] = true })
            if not flags["--silent"] then print(app_name .. " was successfully updated!") end
        else
            if not flags["--silent"] then print(app_name .. " is up to date. Version: " .. local_version) end
        end
        
	end
}