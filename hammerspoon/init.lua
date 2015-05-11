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

safari_tab_keys = hotkey.modal.new()
for i = 1, 9, 1 do
        safari_tab_keys:bind(mash, tostring(i), function() safari_tab(i) end)
end

-- This draws a bright red circle around the pointer for a few seconds
function mouse_highlight()
        if mouseCircle then
                mouseCircle:delete()
                if mouseCircleTimer then
                        mouseCircleTimer:stop()
                end
        end
        mousepoint = hs.mouse.getAbsolutePosition()
        mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
        mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
        mouseCircle:setFill(false)
        mouseCircle:setStrokeWidth(5)
        mouseCircle:show()
        mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end

hotkey.bind({"cmd", "alt"}, 'd', mouse_highlight)

-- automatic config reloading
function reload_config(files)
        hs.reload()
end

hs.pathwatcher.new(os.getenv("HOME") .. "/git/dotfiles/hammerspoon/", reload_config):start()
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
