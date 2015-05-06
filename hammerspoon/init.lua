local application = require "hs.application"
local tiling = require "hs.tiling" -- git clone https://github.com/dsanson/hs.tiling $HOME/.hammerspoon/hs/tiling
local hotkey = require "hs.hotkey"
local mash = {"ctrl"}

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
hs.hotkey.bind({"cmd"}, "1", function() hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 1') end)
hs.hotkey.bind({"cmd"}, "2", function() hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 2') end)
hs.hotkey.bind({"cmd"}, "3", function() hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 3') end)
hs.hotkey.bind({"cmd"}, "4", function() hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 4') end)
hs.hotkey.bind({"cmd"}, "5", function() hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 5') end)
hs.hotkey.bind({"cmd"}, "6", function() hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 6') end)
hs.hotkey.bind({"cmd"}, "7", function() hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 7') end)
hs.hotkey.bind({"cmd"}, "8", function() hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 8') end)
hs.hotkey.bind({"cmd"}, "9", function() hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 9') end)

-- automatic config reloading
function reload_config(files)
        hs.reload()
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.alert.show("Config reloaded")
