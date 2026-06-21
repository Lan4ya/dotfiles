---@diagnostic disable: undefined-global
local hl = hl

local mainMod = "SUPER"
local home = os.getenv("HOME")
local scriptsDir = home .. "/.config/hypr/scripts"
local UserScripts = home .. "/.config/hypr/UserScripts"
-- local UserConfigs = home .. "/.config/hypr/UserConfigs"
-- local hypr = home .. "/.config/hypr"

-- Exit Hyprland
hl.bind("CTRL + SHIFT + ALT + Delete", hl.dsp.exec_cmd("hyprctl dispatch exit 0"))

-- Close window
hl.bind(mainMod .. " + q", hl.dsp.window.close())
--kill

-- Kill active process
hl.bind(mainMod .. " + SHIFT + q", hl.dsp.exec_cmd(scriptsDir .. "/KillActiveProcess.sh"))
-- Kill active process

-- Screen lock
hl.bind("CTRL + SHIFT + ALT + L", hl.dsp.exec_cmd(scriptsDir .. "/LockScreen.sh"))
-- screen lock

-- Power menu
hl.bind("CTRL + SHIFT + ALT + P", hl.dsp.exec_cmd(scriptsDir .. "/Wlogout.sh"))
-- power menu

-- SwayNC notification panel
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
-- swayNC notification panel

-- Master Layout (commented out)
-- bind = $mainMod CTRL, D, layoutmsg, removemaster
-- bind = $mainMod, I, layoutmsg, addmaster
-- bind = $mainMod, J, layoutmsg, cyclenext
-- bind = $mainMod, K, layoutmsg, cycleprev
-- bind = $mainMod CTRL, M, layoutmsg, swapwithmaster

-- Dwindle Layout
-- bind = $mainMod SHIFT, V, togglesplit # only works on dwindle layout
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.pseudo())
-- dwindle

-- Works on either layout (Master or Dwindle)
-- bind = $mainMod, Y, exec, hyprctl dispatch splitratio 0.3

-- group
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
-- toggle group

-- change focus to another window
hl.bind(mainMod .. " + CTRL + tab", hl.dsp.group.next({ forward = false }))

-- Cycle windows if floating bring to top
hl.bind("ALT + tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

-- Move windows
hl.bind(mainMod .. " + CTRL + left", hl.dsp.exec_cmd("hyprctl dispatch movewindow l"))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.exec_cmd("hyprctl dispatch movewindow d"))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.exec_cmd("hyprctl dispatch movewindow u"))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.exec_cmd("hyprctl dispatch movewindow r"))

-- Focus directions
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + p", hl.dsp.focus({ direction = "right" }))

-- Swap windows
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + p", hl.dsp.window.swap({ direction = "right" }))

-- Resize windows
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.exec_cmd("hyprctl dispatch resizeactive -50 0"))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -50"))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 50"))
hl.bind(mainMod .. " + SHIFT + p", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 50 0"))

-- Move windows (alternative)
hl.bind(mainMod .. " + CTRL + j", hl.dsp.exec_cmd("hyprctl dispatch movewindow l"))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.exec_cmd("hyprctl dispatch movewindow r"))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.exec_cmd("hyprctl dispatch movewindow u"))
hl.bind(mainMod .. " + CTRL + p", hl.dsp.exec_cmd("hyprctl dispatch movewindow d"))

-- Workspaces – skim active workspaces
hl.bind(mainMod .. " + tab", hl.dsp.exec_cmd(UserScripts .. "/ActiveWorkspaces.sh next"))
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.exec_cmd(UserScripts .. "/ActiveWorkspaces.sh prev"))

-- Move/resize windows with mouse drag
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
-- mouse:272 = left click
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
-- mouse:273 = right click

-- Special workspace
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + U", hl.dsp.workspace.toggle_special(nil))

-- =============================================================================
-- WORKSPACE KEYBINDS (split-monitor-workspaces plugin)
-- =============================================================================

local smw = require("plugins.split-monitor-workspaces")

-- Move active window to the next monitor and keep focus
hl.bind(mainMod .. " + i", hl.dsp.window.move({ monitor = "+1", follow = false }))

-- Move active window to the next monitor and switch focus
hl.bind(mainMod .. " + SHIFT + i", hl.dsp.window.move({ monitor = "+1" }))

-- SHIFT key mapping: non‑sequential mapping (due to keyd remap)
local shift_map = {
	[1] = "1",
	[2] = "2",
	[3] = "8",
	[4] = "7",
	[5] = "3",
	[6] = "6",
	[7] = "5",
	[8] = "4",
	[9] = "9",
	[10] = "0",
}

for i = 1, smw.get_amount_of_workspaces() do
	local n = tostring(i)
	if n == "10" then
		n = "0"
	end

	-- Switch to workspace N on the currently focused monitor
	hl.bind(mainMod .. " + " .. n, smw.workspace(n))

	-- Move window to workspace N and follow
	local shift_key = shift_map[i]
	hl.bind(mainMod .. " + SHIFT + " .. shift_key, smw.move_to_workspace(tostring(i)))

	-- Move window to workspace N silently (no focus change)
	hl.bind(mainMod .. " + CTRL + " .. n, smw.move_to_workspace_silent(n))
end

-- =============================================================================
-- Single‑monitor workspace
-- =============================================================================
--[[
-- Switch workspaces with mainMod + [0-9]
-- hl.bind(mainMod .. " + code:10", hl.dsp.focus({ workspace = "1" }))
-- hl.bind(mainMod .. " + code:11", hl.dsp.focus({ workspace = "2" }))
-- hl.bind(mainMod .. " + code:12", hl.dsp.focus({ workspace = "3" }))
-- hl.bind(mainMod .. " + code:13", hl.dsp.focus({ workspace = "4" }))
-- hl.bind(mainMod .. " + code:14", hl.dsp.focus({ workspace = "5" }))
-- hl.bind(mainMod .. " + code:15", hl.dsp.focus({ workspace = "6" }))
-- hl.bind(mainMod .. " + code:16", hl.dsp.focus({ workspace = "7" }))
-- hl.bind(mainMod .. " + code:17", hl.dsp.focus({ workspace = "8" }))
-- hl.bind(mainMod .. " + code:18", hl.dsp.focus({ workspace = "9" }))
-- hl.bind(mainMod .. " + code:19", hl.dsp.focus({ workspace = "10" }))

-- Move active window and follow to workspace mainMod + SHIFT [0-9]
-- hl.bind(mainMod .. " + SHIFT + code:10", hl.dsp.window.move({ workspace = "1" }))
-- hl.bind(mainMod .. " + SHIFT + code:11", hl.dsp.window.move({ workspace = "2" }))
-- hl.bind(mainMod .. " + SHIFT + code:17", hl.dsp.window.move({ workspace = "3" }))
-- hl.bind(mainMod .. " + SHIFT + code:16", hl.dsp.window.move({ workspace = "4" }))
-- hl.bind(mainMod .. " + SHIFT + code:12", hl.dsp.window.move({ workspace = "5" }))
-- hl.bind(mainMod .. " + SHIFT + code:15", hl.dsp.window.move({ workspace = "6" }))
-- hl.bind(mainMod .. " + SHIFT + code:14", hl.dsp.window.move({ workspace = "7" }))
-- hl.bind(mainMod .. " + SHIFT + code:13", hl.dsp.window.move({ workspace = "8" }))
-- hl.bind(mainMod .. " + SHIFT + code:18", hl.dsp.window.move({ workspace = "9" }))
-- hl.bind(mainMod .. " + SHIFT + code:19", hl.dsp.window.move({ workspace = "10" }))
-- hl.bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.window.move({ workspace = "-1" }))
-- hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = "+1" }))

-- Move active window silently mainMod + CTRL [0-9]
-- hl.bind(mainMod .. " + CTRL + code:10", hl.dsp.window.move({ workspace = "1", follow = false }))
-- hl.bind(mainMod .. " + CTRL + code:11", hl.dsp.window.move({ workspace = "2", follow = false }))
-- hl.bind(mainMod .. " + CTRL + code:12", hl.dsp.window.move({ workspace = "3", follow = false }))
-- hl.bind(mainMod .. " + CTRL + code:13", hl.dsp.window.move({ workspace = "4", follow = false }))
-- hl.bind(mainMod .. " + CTRL + code:14", hl.dsp.window.move({ workspace = "5", follow = false }))
-- hl.bind(mainMod .. " + CTRL + code:15", hl.dsp.window.move({ workspace = "6", follow = false }))
-- hl.bind(mainMod .. " + CTRL + code:16", hl.dsp.window.move({ workspace = "7", follow = false }))
-- hl.bind(mainMod .. " + CTRL + code:17", hl.dsp.window.move({ workspace = "8", follow = false }))
-- hl.bind(mainMod .. " + CTRL + code:18", hl.dsp.window.move({ workspace = "9", follow = false }))
-- hl.bind(mainMod .. " + CTRL + code:19", hl.dsp.window.move({ workspace = "10", follow = false }))
-- hl.bind(mainMod .. " + CTRL + bracketleft", hl.dsp.window.move({ workspace = "-1", follow = false }))
-- hl.bind(mainMod .. " + CTRL + bracketright", hl.dsp.window.move({ workspace = "+1", follow = false }))
--]]

-- DEFAULT VARS
-- local files = "thunar"
local code = "code --use-gl=desktop"
-- $spotify = env LD_PRELOAD=/usr/lib/spotify-adblock.so spotify --uri=%U # spotify no ads

-- COMMON SHORTCUTS
--bindr = $mainMod, $mainMod_L, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run,window # Super Key to Launch rofi menu
hl.bind(mainMod .. " + n", hl.dsp.exec_cmd("pkill rofi || true && rofi -show drun -modi drun,filebrowser,run,window"))
-- Main Menu (APP Launcher)

-- bind = $mainMod, ???, exec, xdg-open "http:// &"  # default browser
-- bindd = $mainMod, A, desktop overview, exec, $scriptsDir/OverviewToggle.sh
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"))

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("foot"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + c", hl.dsp.exec_cmd(code))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar /home/maya/Downloads/"))

-- WAYBAR
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
-- Toggle hide/show waybar
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd(scriptsDir .. "/WaybarStyles.sh"))
-- Waybar Styles Menu
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd(scriptsDir .. "/WaybarLayout.sh"))
-- Waybar Layout Menu

-- FEATURES / EXTRAS
hl.bind(mainMod .. " + CTRL + SHIFT + H", hl.dsp.exec_cmd(scriptsDir .. "/KeyHints.sh"))
-- help / cheat sheet

hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd(scriptsDir .. "/Refresh.sh"))
-- Refresh waybar, swaync, rofi

hl.bind(mainMod .. " + CTRL + E", hl.dsp.exec_cmd(scriptsDir .. "/RofiEmoji.sh"))
-- emoji menu

hl.bind(mainMod .. " + semicolon", hl.dsp.exec_cmd(scriptsDir .. "/RofiSearch.sh"))
-- Google search using rofi

hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(scriptsDir .. "/ChangeBlur.sh"))
-- Toggle blur settings

hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(scriptsDir .. "/ChangeLayout.sh"))
-- Toggle Master or Dwindle Layout

hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd(scriptsDir .. "/ClipManager.sh"))
-- Clipboard Manager

hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd(scriptsDir .. "/RofiThemeSelector.sh"))
-- KooL Rofi Menu Theme Selector

hl.bind(mainMod .. " + period", hl.dsp.exec_cmd(scriptsDir .. "/Quick_Settings.sh"))

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float())
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen())
-- fake full screen

-- UserScripts
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(UserScripts .. "/RofiBeats.sh"))
-- Online music using rofi

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(UserScripts .. "/WallpaperSelect.sh"))
-- Select wallpaper to apply

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(UserScripts .. "/WallpaperEffects.sh"))
-- Wallpaper Effects by imagemagick

hl.bind(mainMod .. " + CTRL + O", hl.dsp.exec_cmd("hyprctl setprop active opaque toggle"))
-- disable opacity on active window

hl.bind(mainMod .. " + CTRL + Return", hl.dsp.exec_cmd(scriptsDir .. "/KeyBinds.sh"))
-- search keybinds via rofi

hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("pypr zoom"))
-- Toggle Desktop Zoom

-- For passthrough keyboard into a VM
-- bind = $mainMod ALT, P, submap, passthru
--submap = passthru
-- to unbind
--bind = $mainMod ALT, P, submap, reset
--submap = reset

-- Manually added
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("blueman-manager"))
-- bind = $mainMod, Space, exec, $spotify

hl.bind(mainMod .. " + SHIFT + BACKSPACE", hl.dsp.exec_cmd(UserScripts .. "/ToggleZeroBrightness.sh"))

hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(UserScripts .. "/OpenGithub.sh"))

return {}
