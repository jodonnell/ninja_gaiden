love.conf = (t) ->
  t.modules.joystick = false   -- Enable the joystick module (boolean)
  t.modules.audio = true      -- Enable the audio module (boolean)
  t.modules.keyboard = true   -- Enable the keyboard module (boolean)
  t.modules.event = true      -- Enable the event module (boolean)
  t.modules.image = true      -- Enable the image module (boolean)
  t.modules.graphics = true   -- Enable the graphics module (boolean)
  t.modules.timer = true      -- Enable the timer module (boolean)
  t.modules.mouse = true      -- Enable the mouse module (boolean)
  t.modules.sound = true      -- Enable the sound module (boolean)
  t.modules.physics = false   -- Enable the physics module (boolean)
  t.console = false           -- Attach a console (boolean, Windows only)
  t.title = "ninja_gaiden"    -- The title of the window the game is in (string)
  t.author = "Jacob"          -- The author of the game (string)
  t.window.fullscreen = false  -- Enable fullscreen (boolean)
  t.window.vsync = true       -- Enable vertical sync (boolean)
  t.window.fsaa = 0           -- The number of FSAA-buffers (number)
  t.window.width = 414       -- The window width (number)
  t.window.height = 736       -- The window height (number)
  --t.window.height = 768       -- The window height (number)
  t.version = "0.10.1"         -- The LÖVE version this game was made for (number)
  t.highdpi = true