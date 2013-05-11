module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
   mainGame = MainGame()
	 mainGame:load()
end

function teardown()
   mainGame = nil
end

function test_ninja_goes_into_fall_animation()
   mainGame:update()
   assert_equal(mainGame.ninja.falling, mainGame.ninja:getCurrentImage())
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

function test_ninja_moving_right_runs_animation()
	 mainGame.ninja.y = 450
	 mainGame:pressRight()
	 mainGame:update()
	 assert_equal(mainGame.ninja.runningRight1, mainGame.ninja:getCurrentImage())
	 
	 for i=1,4 do
			mainGame:update()
	 end

	 assert_equal(mainGame.ninja.runningRight2, mainGame.ninja:getCurrentImage())

	 for i=1,4 do
			mainGame:update()
	 end

	 assert_equal(mainGame.ninja.runningRight3, mainGame.ninja:getCurrentImage())

	 for i=1,4 do
			mainGame:update()
	 end

	 assert_equal(mainGame.ninja.runningRight1, mainGame.ninja:getCurrentImage())

	 mainGame:releaseRight()
	 mainGame:update()
	 assert_equal(mainGame.ninja.image, mainGame.ninja:getCurrentImage())
end

function test_ninja_moving_left_runs_animation()
	 mainGame.ninja.y = 450
	 mainGame:pressLeft()
	 mainGame:update()
	 assert_equal(mainGame.ninja.runningLeft1, mainGame.ninja:getCurrentImage())
	 
	 for i=1,4 do
			mainGame:update()
	 end

	 assert_equal(mainGame.ninja.runningLeft2, mainGame.ninja:getCurrentImage())

	 for i=1,4 do
			mainGame:update()
	 end

	 assert_equal(mainGame.ninja.runningLeft3, mainGame.ninja:getCurrentImage())

	 for i=1,4 do
			mainGame:update()
	 end

	 assert_equal(mainGame.ninja.runningLeft1, mainGame.ninja:getCurrentImage())

	 mainGame:releaseLeft()
	 mainGame:update()
	 assert_equal(mainGame.ninja.left, mainGame.ninja:getCurrentImage())
end

function test_screen_scrolls_when_ninja_in_center()
	 mainGame.ninja.x = love.graphics.getWidth() / 2
   local x = mainGame.ninja.x
	 mainGame:pressRight()
	 mainGame:update()
   assert_equal(4, mainGame.screenScrollX)
end

function test_screen_scroll_right()
	 mainGame.ninja.rightPressed = true
	 mainGame.screenScrollX = 0
	 mainGame.ninja.x = love.graphics.getWidth() / 2

	 assert_true(mainGame:shouldScrollRight())

	 mainGame.ninja.rightPressed = true
	 mainGame.screenScrollX = mainGame.endOfStageX
	 mainGame.ninja.x = love.graphics.getWidth() / 2

	 assert_false(mainGame:shouldScrollRight())

end

function test_does_not_screen_scroll_right()
	 mainGame.ninja.rightPressed = true
	 mainGame.screenScrollX = 0
	 mainGame.ninja.x = 0

	 assert_false(mainGame:shouldScrollRight())
end

function test_screen_scroll_left()
	 mainGame.ninja.leftPressed = true
	 mainGame.screenScrollX = 0
	 mainGame.ninja.x = love.graphics.getWidth() / 2

	 assert_false(mainGame:shouldScrollLeft())

	 mainGame.ninja.leftPressed = true
	 mainGame.screenScrollX = mainGame.endOfStageX
	 mainGame.ninja.x = love.graphics.getWidth() / 2

	 assert_true(mainGame:shouldScrollLeft())
end
