local kernel_file = "/system/kernel"
local system_file = "/system/system.lua"

_MAC = { _OENV = _G }

_MAC.flags = {
    ["--silent"] = false,
    ["--force"] = false,
	["--debug"] = false,
	["--nogui"] = true
}

--[[ Manually load Logger and System modules, this should always be loaded ]]--
loadfile("/system/modules/" .. "Logger" .. ".mm.lua", _MAC)()
loadfile("/system/modules/System.mm.lua", _MAC)()

_MAC.Logger.start()

_MAC.System.debug(0, "Loading kernel")
local kernel = loadfile(kernel_file, _MAC)
kernel(system_file)

_MAC.Logger.stop()

_MAC = nil
