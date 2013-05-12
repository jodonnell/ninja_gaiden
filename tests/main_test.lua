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

function test_screen_scrolls_when_ninja_in_center()
	 mainGame.ninja.x = love.graphics.getWidth() / 2
   local x = mainGame.ninja.x
	 mainGame:pressRight()
	 mainGame:update()
   assert_equal(4, mainGame.stage.screenScrollX)
end

function test_screen_scroll_right()
	 mainGame.ninja.rightPressed = true
	 mainGame.stage.screenScrollX = 0
	 mainGame.ninja.x = love.graphics.getWidth() / 2

	 assert_true(mainGame:shouldScrollRight())

	 mainGame.ninja.rightPressed = true
	 mainGame.stage.screenScrollX = mainGame.stage.endOfStageX
	 mainGame.ninja.x = love.graphics.getWidth() / 2

	 assert_false(mainGame:shouldScrollRight())

end

function test_does_not_screen_scroll_right()
	 mainGame.ninja.rightPressed = true
	 mainGame.stage.screenScrollX = 0
	 mainGame.ninja.x = 0

	 assert_false(mainGame:shouldScrollRight())
end

function test_screen_scroll_left()
	 mainGame.ninja.leftPressed = true
	 mainGame.stage.screenScrollX = 0
	 mainGame.ninja.x = love.graphics.getWidth() / 2

	 assert_false(mainGame:shouldScrollLeft())

	 mainGame.ninja.leftPressed = true
	 mainGame.stage.screenScrollX = mainGame.stage.endOfStageX
	 mainGame.ninja.x = love.graphics.getWidth() / 2

	 assert_true(mainGame:shouldScrollLeft())
end
