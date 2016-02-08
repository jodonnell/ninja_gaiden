import MainGame from require 'main_game'

if os.getenv("LUA_TEST")
  require "lunatest.lunatest"
  lunatest.suite("tests.ninja_test")
  lunatest.run()
  os.exit()


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
    main_game.ninja.rightPressed = true
  elseif key == 'left'
    main_game.ninja.leftPressed = true
  elseif key == 'up'
    main_game.ninja.upPressed = true
  elseif key == 'down'
    main_game.ninja.downPressed = true

love.keyreleased = (key, unicode) ->
  if key == 'right'
    main_game.ninja.rightPressed = false
  elseif key == 'left'
    main_game.ninja.leftPressed = false
  elseif key == 'down'
    main_game.ninja.downPressed = false
  elseif key == 'up'
    main_game.ninja.upPressed = false


love.touchpressed = (id, x, y, dx, dy, pressure) ->
  main_game.ninja.rightPressed = true


love.touchreleased = (id, x, y, dx, dy, pressure) ->
  main_game.ninja.rightPressed = false
