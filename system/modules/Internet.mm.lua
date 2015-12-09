Internet = {
	DownloadFile = function(path)
		http.request(path)
		requesting = true

		while requesting do
			event, url, sourceText = os.pullEvent()

			if event == "http_success" then
				respondedText = sourceText.readAll()

				sourceText.close()

				requesting = false
			elseif event == "http_failure" then
				print("Server didn't respond.")

				requesting = false
			end
		end

		return respondedText
	end
}