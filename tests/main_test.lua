module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
   mainGame = MainGame()
	 mainGame:load()
end

function teardown()
   mainGame = nil
end

function test_ninja_can_move_right()
   local x = mainGame.ninja.x
	 mainGame:pressRight()
	 mainGame:update()
   assert_gt(x, mainGame.ninja.x)
end

function test_ninja_can_stop_moving_right()
	 mainGame:pressRight()
	 mainGame:update()
   local x = mainGame.ninja.x
	 mainGame:releaseRight()
	 mainGame:update()
   assert_equal(x, mainGame.ninja.x)
end

function test_ninja_can_move_left()
   local x = mainGame.ninja.x
	 mainGame:pressLeft()
	 mainGame:update()
   assert_lt(x, mainGame.ninja.x)
end

function test_ninja_can_stop_moving_left()
	 mainGame:pressLeft()
	 mainGame:update()
   local x = mainGame.ninja.x
	 mainGame:releaseLeft()
	 mainGame:update()
   assert_equal(x, mainGame.ninja.x)
end
