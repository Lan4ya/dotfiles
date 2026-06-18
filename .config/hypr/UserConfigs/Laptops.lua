-- See https://wiki.hyprland.org/Configuring/Keywords/ for more variable settings

-- These configs are mostly for laptops. This is addemdum to Keybinds.conf

local mainMod = "SUPER"
local home = os.getenv("HOME")

local scriptsDir = home .. "/.config/hypr/scripts"
-- local UserConfigs = home .. "/.config/hypr/UserConfigs"

-- for disabling Touchpad. hyprctl devices to get device name.
local Touchpad_Device = "asue1209:00-04f3:319f-touchpad"

-- Keyboard brightness controls
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd(scriptsDir .. "/BrightnessKbd.sh --dec"))
-- decrease keyboard brightness

hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd(scriptsDir .. "/BrightnessKbd.sh --inc"))
-- increase keyboard brightness

hl.bind("XF86Launch1", hl.dsp.exec_cmd("rog-control-center"))
-- ASUS Armory crate button

hl.bind("XF86Launch3", hl.dsp.exec_cmd("asusctl led-mode -n"))
-- FN+F4 Switch keyboard RGB profile

hl.bind("XF86Launch4", hl.dsp.exec_cmd("asusctl profile -n"))
-- FN+F5 change of fan profiles (Quite, Balance, Performance)

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(scriptsDir .. "/Brightness.sh --dec"))
-- decrease monitor brightness

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(scriptsDir .. "/Brightness.sh --inc"))
-- increase monitor brightness

hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd(scriptsDir .. "/TouchPad.sh"))
-- toggle touchpad

-- Screenshot keybindings using F6 (no PrinSrc button)
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --now"))
-- screenshot

hl.bind(mainMod .. " + SHIFT + F6", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"))
-- screenshot (area)

hl.bind(mainMod .. " + CTRL + F6", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in5"))
-- # screenshot (5 secs delay)

hl.bind(mainMod .. " + ALT + F6", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in10"))
-- screenshot (10 secs delay)

hl.bind("ALT + F6", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --active"))
-- screenshot (active window only)

-- screenshot with swappy (another screenshot tool)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --swappy"))
--screenshot (swappy)

-- Touchpad device rule
hl.device({
	name = Touchpad_Device,
	enabled = true,
})

-- Volume controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --inc"), { locked = true })
-- volume up

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --dec"), { locked = true })
-- volume down

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle-mic"), { locked = true })
-- mic mute

hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle"), { locked = true })
-- mute

hl.bind("XF86Sleep", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })
-- sleep button

hl.bind("XF86Rfkill", hl.dsp.exec_cmd(scriptsDir .. "/AirplaneMode.sh"), { locked = true })
-- Airplane mode

-- media controls using keyboards
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --nxt"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --prv"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --stop"), { locked = true })

-- Below are useful when you are connecting your laptop in external display
-- Suggest you edit below for your laptop display
-- From WIKI This is to disable laptop monitor when lid is closed.
-- consult https://wiki.hyprland.org/hyprland-wiki/pages/Configuring/Binds/#switches

--[[ Preserved and converted legacy laptop rules:
hl.bindl("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprctl keyword monitor \"eDP-1, preferred, auto, 1\""))
hl.bindl("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprctl keyword monitor \"eDP-1, disable\""))
]]

-- WARNING! Using this method has some caveats!! USE THIS PART WITH SOME CAUTION!
-- CONS of doing this, is that you need to set up your wallpaper (SUPER W) and choose wallpaper.
-- CAVEATS! Sometimes the Main Laptop Monitor DOES NOT have display that it needs to re-connect your external monitor
-- One work around is to ensure that before shutting down laptop, MAKE SURE your laptop lid is OPEN!!
-- Make sure to comment (put # on the both the bindl = , switch ......) above
-- NOTE: Display for laptop are being generated into LaptopDisplay.conf
-- This part is to be use if you do not want your main laptop monitor to wake up during say wallpaper change etc

--[[ Preserved and converted legacy lid trigger overrides:
hl.bindl("switch:off:Lid Switch", hl.dsp.exec_cmd("echo \"monitor = eDP-1, preferred, auto, 1\" > " .. UserConfigs .. "/LaptopDisplay.conf"))
hl.bindl("switch:on:Lid Switch", hl.dsp.exec_cmd("echo \"monitor = eDP-1, disable\" > " .. UserConfigs .. "/LaptopDisplay.conf"))
]]

-- for laptop-lid action (to erase the last entry)
--[[ Preserved and converted boot hook:
hl.on("hyprland.start", function()
    hl.exec_cmd("echo \"monitor = eDP-1, preferred, auto, 1\" > " .. home .. "/.config/hypr/UserConfigs/LaptopDisplay.conf")
end)
]]

return {}
