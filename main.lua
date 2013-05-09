require 'class'
require 'main_game'

if os.getenv("LUA_TEST") then
   require "lunatest.lunatest"

   lunatest.suite("tests.main_test")

   lunatest.run()
   os.exit()
end

local main_game = MainGame()

function love.load()
	 main_game:load()
end

function love.draw()
	 main_game:draw()
end

function love.update()
	 main_game:update()
end

function love.keypressed(key, unicode)
   if key == 'right' then
			main_game:pressRight()
	 elseif key == 'left' then
			main_game:pressLeft()
   end
end

function love.keyreleased(key, unicode)
   if key == 'right' then
			main_game:releaseRight()
	 elseif key == 'left' then
			main_game:releaseLeft()
   end
end