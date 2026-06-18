---@diagnostic disable: undefined-global
local hl = hl

local home = os.getenv("HOME")

local scriptsDir = home .. "/.config/hypr/scripts"
local UserScripts = home .. "/.config/hypr/UserScripts"
local wallDIR = home .. "/Pictures/wallpapers"
local lock = home .. "/.config/hypr/scripts/LockScreen.sh"

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
	hl.exec_cmd("hyprctl dispatch exec '[workspace 11 silent] foot'")
	hl.exec_cmd("hyprctl dispatch exec '[workspace 19 silent] firefox'")
	hl.exec_cmd("env LD_PRELOAD=/usr/lib/spotify-adblock.so spotify --uri=%U")
	hl.exec_cmd("waybar")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("swaync")
	hl.exec_cmd("qs -c overview")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("pypr")
	hl.exec_cmd(home .. "/.config/hypr/scripts/KeybindsLayoutInit.sh")
	hl.exec_cmd(home .. "/.config/hypr/scripts/WallpaperDaemon.sh")
	hl.exec_cmd(home .. "/.config/hypr/scripts/Dropterminal.sh kitty")
	hl.exec_cmd(home .. "/.config/hypr/scripts/Polkit.sh")
	-- hl.exec_cmd("hyprctl dispatch exec '[workspace 11] foot'")
	-- hl.exec_cmd("hyprctl dispatch exec '[workspace 11 silent] kitty -e bash -c tmux new-session -A -s thecozybud -c ~/dev/projects/thecozybud && tmux source-file ~/.config/tmux/tmux.conf'")
	-- hl.exec_cmd("postman --use-gl=desktop")
	-- hl.exec_cmd("thunar /home/maya/Downloads/")
	-- hl.exec_cmd("hyprctl dispatch exec '[workspace 2 silent] google-chrome-stable --disable-background-networking --ozone-platform=wayland --ozone-platform-hint=auto --use-gl=egl --use-vulkan=any --ignore-gpu-blocklist --enable-zero-copy --enable-gpu-rasterization --canvas-oop-rasterization --enable-features=CanvasOopRasterization,Vulkan'")
	-- hl.exec_cmd("ags")
	-- hl.exec_cmd("rog-control-center")
	-- hl.exec_cmd(scriptsDir .. "/Hyprsunset.sh init")
	-- -- xdg-desktop-portal-hyprland (should be auto starting. However, you can force to start)
	-- hl.exec_cmd(scriptsDir .. "/PortalHyprland.sh")
end)

return {}
