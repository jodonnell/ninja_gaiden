require 'class'
require 'main_game'

if os.getenv("LUA_TEST") then
   require "lunatest.lunatest"

   lunatest.suite("tests.main_test")
   lunatest.suite("tests.ninja_test")
   lunatest.suite("tests.ninja_animations_test")
   lunatest.suite("tests.stage_test")
   lunatest.suite("tests.hunchback_test")
   lunatest.suite("tests.explosion_test")
   lunatest.suite("tests.collision_detection_test")

   lunatest.run()
   os.exit()
end

local main_game = MainGame()

function setWindow()
	 local modes = love.graphics.getModes()
	 local height = 0
	 for key,value in pairs(modes) do 
			if value['width'] == 1024 and value['height'] > height then
				 height = value['height']
			end
	 end

	 local success = love.graphics.setMode( 1024, height, false, false, 0 )
end

function love.load()
	 -- setWindow()
	 main_game:load()
end

function love.draw()
	 main_game:draw()
end

function love.update(dt)
	 main_game:update(dt)
end

function love.keypressed(key, unicode)
   if key == 'right' then
			main_game.ninja.rightPressed = true
	 elseif key == 'left' then
			main_game.ninja.leftPressed = true
	 elseif key == 'up' then
			main_game.ninja.upPressed = true
	 elseif key == 'down' then
			main_game.ninja.downPressed = true
	 elseif (key == 'q' or key == 'x') and main_game.ninja:canJump() then
			main_game.ninja:startJumping()
	 elseif (key == ';' or key == 'z') and main_game.ninja:canAttack() then
			main_game.ninja.isAttacking = true
   end
end

function love.keyreleased(key, unicode)
   if key == 'right' then
			main_game.ninja.rightPressed = false
	 elseif key == 'left' then
			main_game.ninja.leftPressed = false
	 elseif key == 'down' then
			main_game.ninja.downPressed = false
	 elseif key == 'up' then
			main_game.ninja.upPressed = false
   end
end