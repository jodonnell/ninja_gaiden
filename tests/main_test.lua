module(..., package.seeall)

function setup()
   mainGame = MainGame()
	 mainGame:load()
end

function teardown()
   mainGame = nil
end

function test_ninja_falls()
   local y = mainGame.ninja.y
   mainGame:update()
   assert_gt(y, mainGame.ninja.y)
end

function test_ninja_goes_into_fall_animation()
   mainGame:update()
   assert_equal(mainGame.ninja.falling, mainGame.ninja:getCurrentImage())
end

function test_ninja_lands_on_the_ground()
	 for i=1,50 do
			mainGame:update()
	 end
   assert_equal(450, mainGame.ninja.y)
end

function test_ninja_goes_to_stand_animation()
	 for i=1,50 do
			mainGame:update()
	 end
   assert_equal(mainGame.ninja.image, mainGame.ninja:getCurrentImage())
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
