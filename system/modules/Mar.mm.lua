base_url = "https://raw.githubusercontent.com/MaCCOS/MAR/master/stable/"
base_app_dir = "/usr/apps/"
app_json_file = "/app.json"

Mar = {

	DownloadFileList = function(app_name)
		data = Internet.DownloadFile(base_url .. app_name .. app_json_file)
		return decode(data).files
	end,

	GetAppSize = function(app_name)
		size = 0
		files = fs.list(base_app_dir .. app_name)

		for i = 1, #files do
			f = fs.open(base_app_dir .. app_name .. "/" .. files[i], "r")
			data = f.readAll()
			size = size + tonumber(string.len(data))
			f.close()
		end

		return size
	end,
    
    GetAppData = function(app_name)
        json_file = fs.open(base_app_dir .. app_name .. app_json_file, "r")
        json_encoded = json_file.readAll()
        
        app_data = decode(json_encoded)
        json_file.close()

        return app_data
    end,

	DownloadApp = function(app_name, flags)
        if not flags["--silent"] then System.println("Downloading app: " .. app_name) end
        if not Directory.exists(base_app_dir .. app_name) then
            json = Internet.DownloadFile(base_url .. app_name .. app_json_file)
            data = decode(json)

            f = fs.open(base_app_dir .. app_name .. app_json_file, "w")
            f.write(json)
            f.close()
            
            files = data.files
            for i = 1, #files do
                if not flags["--silent"] then System.println("File: " .. files[i]) end
                f = fs.open(base_app_dir .. app_name .. "/" .. files[i], "w")
                f.write(Internet.DownloadFile(base_url .. app_name .. "/" .. files[i]))
                f.close()
            end
            if not flags["--silent"] then System.println("App successfully installed") end
        else
            if not flags["--silent"] then System.println("App is already installed!") end
        end
	end,

	RemoveApp = function(app_name, flags)
        if Directory.exists(base_app_dir .. app_name) then
            if flags["--silent"] then
                Directory.remove(base_app_dir .. app_name)
            else
                System.println("Removing this app will free up " .. Mar.GetAppSize(app_name) .. "B of space.")
                System.print("Are you sure you want to remove this app? (y/N): ")
                r = read()
                if r == "y" or r == "Y" then
                    System.println("Deleting app: " .. app_name)
                    Directory.remove(base_app_dir .. app_name)
                else
                    System.println("App not removed")
                end
            end
        else
            if not flags["--silent"] then System.println("App not found.") end
        end
	end,

	UpdateApp = function(app_name, flags)
        json = Internet.DownloadFile(base_url .. app_name .. app_json_file)
		data = decode(json)
        local_data = Mar.GetAppData(app_name)
        
        new_version = data.version.major
        local_version = local_data.version.major
        
        if new_version > local_version or flags["--force"] then
            if not flags["--silent"] then
                System.println("An update is avaliable!")
                System.println("New version: " .. new_version .. " - Installed version: " .. local_version)
            end
            --Would you like to update?
            
            Mar.RemoveApp(app_name, { ["--silent"] = true })
            Mar.DownloadApp(app_name, { ["--silent"] = true })
            if not flags["--silent"] then System.println(app_name .. " was successfully updated!") end
        else
            if not flags["--silent"] then System.println(app_name .. " is up to date. Version: " .. local_version) end
        end
        
	end
}