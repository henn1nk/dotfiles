local application = require "hs.application"
local tiling = require "hs.tiling" -- git clone https://github.com/dsanson/hs.tiling $HOME/.hammerspoon/hs/tiling
local hotkey = require "hs.hotkey"
local mash = {"ctrl", "cmd"}
local safari = nil

-- settings
hs.window.animationDuration = 0 -- disable window animations

-- tiling
hotkey.bind(mash, "c", function() tiling.cyclelayout() end)
hotkey.bind(mash, "j", function() tiling.cycle(1) end)
hotkey.bind(mash, "k", function() tiling.cycle(-1) end)
hotkey.bind(mash, "space", function() tiling.promote() end)

tiling.set('layouts', {
  'fullscreen', 'main-vertical'
})

-- launching
hotkey.bind(mash, '1', function() application.launchOrFocus('iTerm') end)
hotkey.bind(mash, '2', function() application.launchOrFocus('Safari') end)
hotkey.bind(mash, '3', function() application.launchOrFocus('Finder') end)
hotkey.bind(mash, '4', function() application.launchOrFocus('Mail') end)
hotkey.bind(mash, '5', function() application.launchOrFocus('iTerm') end)

-- Safari tab keys
function safari_tab(num)
        hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab ' .. num)
end

safari_tab_keys = hs.hotkey.modal.new()
safari_tab_keys:bind({"cmd"}, "1", function() safari_tab(1) end)
safari_tab_keys:bind({"cmd"}, "2", function() safari_tab(2) end)
safari_tab_keys:bind({"cmd"}, "3", function() safari_tab(3) end)
safari_tab_keys:bind({"cmd"}, "4", function() safari_tab(4) end)
safari_tab_keys:bind({"cmd"}, "5", function() safari_tab(5) end)
safari_tab_keys:bind({"cmd"}, "6", function() safari_tab(6) end)
safari_tab_keys:bind({"cmd"}, "7", function() safari_tab(7) end)
safari_tab_keys:bind({"cmd"}, "8", function() safari_tab(8) end)
safari_tab_keys:bind({"cmd"}, "9", function() safari_tab(9) end)

-- automatic config reloading
function reload_config(files)
        hs.reload()
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.alert.show("Config reloaded")

-- application watcher
function applicationWatcher(app, event, appObject)
        if app == 'Safari' then
                if event == hs.application.watcher.activated then
                        safari_tab_keys:enter()
                else
                        safari_tab_keys:exit()
                end
        end
end

hs.application.watcher.new(applicationWatcher):start()
