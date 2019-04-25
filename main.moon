-- import MainGame from require 'src.main_game'


display.setStatusBar( display.HiddenStatusBar )

sequence = {
  {
    name: "ready",
    frames: { 1, 2, 3, 2 },
    time: 550,
    loopCount: 0
  },
  {
    name: "hurt",
    frames: { 4, 5, 5, 5 },
    time: 800,
    loopCount: 1
  },
}

sheet_options = {
  frames: {
     {
      x: 268,
      y: 24,
      width: 32,
      height: 100
    },
    {
      x: 346,
      y: 24,
      width: 30,
      height: 100
    },
    {
      x: 308,
      y: 24,
      width: 32,
      height: 100
    },
    {
      x: 54,
      y: 132,
      width: 86 - 54,
      height: 224 - 132
    },
    {
      x: 397,
      y: 136,
      width: 428 - 397,
      height: 237 - 136
    }
  }
}

background = display.newRect(0, 0, display.contentWidth * 2, display.contentHeight *2 )
background\setFillColor(0, 0, 1)


objectSheet = graphics.newImageSheet("images/GlassJoe.png", sheet_options)
character = display.newSprite( objectSheet, sequence )
character.x = display.contentCenterX
character.y = display.contentCenterY
character.id = "GlassJoe"
character\scale(10, 10)
character\setSequence("ready")
character\play()

onHurtEnded = (event) ->
  if event.phase == "ended"
    character\setSequence("ready")
    character\play()


onObjectTouch = (event) ->
  if ( event.phase == "began" )
    character\setSequence("hurt")
    character\play()
    character\addEventListener("sprite", onHurtEnded) -- this might put on too many
  true

background\addEventListener( "touch", onObjectTouch )

--ship = display.newImageRect( mainGroup, objectSheet, 1, 32, 100 )
--ship.x = display.contentCenterX
--ship.y = display.contentCenterY


-- setWindow: ->
--   modes = love.graphics.getModes()
--   height = 0
--   for key, value in pairs(modes) do
--     if value['width'] == 1024 and value['height'] > height
--       height = value['height']
-- love.graphics.setMode( 375, 667, false, false, 0 )


--love.draw = ->
--  main_game\draw()

-- love.update = (dt) ->
--   main_game\update(dt)
--
-- love.keypressed = (key, unicode) ->
--   if key == 'right'
--     main_game.opponent.hitRight = true
--   elseif key == 'left'
--     main_game.opponent.hitLeft = true
--   elseif key == 'up'
--     main_game.opponent.upPressed = true
--   elseif key == 'down'
--     main_game.opponent.downPressed = true
--
-- love.keyreleased = (key, unicode) ->
--   if key == 'right'
--     main_game.opponent.hitRight = false
--   elseif key == 'left'
--     main_game.opponent.hitLeft = false
--   elseif key == 'down'
--     main_game.opponent.downPressed = false
--   elseif key == 'up'
--     main_game.opponent.upPressed = false
--
--
-- love.touchpressed = (id, x, y, dx, dy, pressure) ->
--   main_game\touchpressed(id, x, y, dx, dy, pressure)
--
-- love.touchmoved = (id, x, y, dx, dy, pressure) ->
--   main_game\touchmoved(id, x, y, dx, dy, pressure)
--
-- love.touchreleased = (id, x, y, dx, dy, pressure) ->
--   main_game.opponent.hitRight = false
--   main_game.opponent.hitLeft = false
--
--
