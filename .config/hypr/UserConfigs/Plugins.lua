package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/hypr/plugins/?.lua"

local smw = require("plugins.split-monitor-workspaces")

smw.setup({
	workspace_count = 10,
	keep_focused = true,
	enable_notifications = false,
	enable_persistent_workspaces = true,
})
