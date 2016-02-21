import MainGame from require 'main_game'

main_game = MainGame!

setWindow: ->
  modes = love.graphics.getModes()
  height = 0
  for key, value in pairs(modes) do
    if value['width'] == 1024 and value['height'] > height
      height = value['height']

  love.graphics.setMode( 375, 667, false, false, 0 )

love.load = ->
  -- setWindow()
  main_game\load()

love.draw = ->
  main_game\draw()

love.update = (dt) ->
  main_game\update(dt)

love.keypressed = (key, unicode) ->
  if key == 'right'
    main_game.opponent.rightPressed = true
  elseif key == 'left'
    main_game.opponent.leftPressed = true
  elseif key == 'up'
    main_game.opponent.upPressed = true
  elseif key == 'down'
    main_game.opponent.downPressed = true

love.keyreleased = (key, unicode) ->
  if key == 'right'
    main_game.opponent.rightPressed = false
  elseif key == 'left'
    main_game.opponent.leftPressed = false
  elseif key == 'down'
    main_game.opponent.downPressed = false
  elseif key == 'up'
    main_game.opponent.upPressed = false


love.touchpressed = (id, x, y, dx, dy, pressure) ->
  main_game.opponent.rightPressed = true

love.touchreleased = (id, x, y, dx, dy, pressure) ->
  main_game.opponent.rightPressed = false
