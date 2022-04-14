local log = hs.logger.new('init.lua', 'debug')

keyUpDown = function(modifiers, key)
  -- Un-comment & reload config to log each keystroke that we're triggering
  log.d('Sending keystroke:', hs.inspect(modifiers), key)

  hs.eventtap.keyStroke(modifiers, key, 0)
end

hs.urlevent.bind("someAlert", function(eventName, params)
    hs.alert.show("Received someAlert")
end)


hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  log.d('sending alert!')
  hs.alert("Ding Dong")
end)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "P", function()
  log.d('sending greeting!')
  hs.notify.new({title="hammerspoon", informativeText="Hello World"}):send()
  hs.alert.show("Hello Worldz!")
end)

local function open(name)
	return function()
		hs.application.launchOrFocus(name)
		if name == 'Finder' then
			hs.appfinder.appFromName(name):activate()
		end
	end
end

-- quick open applications
hs.hotkey.bind({"alt"}, "E", open("Finder"))
hs.hotkey.bind({"alt"}, "K", open("Kitty"))
hs.hotkey.bind({"alt"}, "C", open("Google Chrome"))
hs.hotkey.bind({"alt"}, "S", open("Slack"))


-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x - 10
--   win:setFrame(f)
-- end)
--

-- require 'control-escape'
-- hs.loadSpoon('ControlEscape'):start() -- Load Hammerspoon bits from https://github.com/jasonrudolph/ControlEscape.spoon
hs.loadSpoon('EmmyLua') -- Load hammerspoon documentation
log.d('LOADED')

