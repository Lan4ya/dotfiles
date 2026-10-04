local configHome = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
local hypr = configHome .. "/hypr"

require("UserConfigs.env")
require("UserConfigs.startup")
require("UserConfigs.plugins")
require("UserConfigs.monitor")
require("UserConfigs.laptops")
require("UserConfigs.window_rules")
require("UserConfigs.decorations")
require("UserConfigs.keybinds")
require("UserConfigs.settings")

hl.on("hyprland.start", function()
	hl.exec_cmd(hypr .. "/initial-boot.sh")
	hl.exec_cmd("hypridle")
end)
