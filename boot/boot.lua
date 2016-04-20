local kernel_file = "/system/kernel"
local system_file = "/system/system.lua"

local kernel = loadfile(kernel_file)
kernel(system_file)
