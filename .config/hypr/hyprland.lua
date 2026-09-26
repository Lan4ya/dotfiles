local home = os.getenv("HOME")

local hypr = home .. "/.config/hypr"

require("UserConfigs.ENVariables")
require("UserConfigs.Startup_Apps")
require("UserConfigs.Plugins")
require("UserConfigs.Monitor")
require("UserConfigs.Laptops")
require("UserConfigs.LaptopDisplay")
require("UserConfigs.WindowRules")
require("UserConfigs.UserDecorations")
require("UserConfigs.UserKeybinds")
require("UserConfigs.UserSettings")

hl.on("hyprland.start", function()
	hl.exec_cmd(hypr .. "/initial-boot.sh")
	hl.exec_cmd("hypridle")
end)
