module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
   ninja = Ninja()
end

function teardown()
   mainGame = nil
end

function test_ninja_falls()
   local y = ninja.y
   ninja:update()
   assert_gt(y, ninja.y)
end

function test_ninja_lands_on_the_ground()
	 for i=1,50 do
			ninja:update()
	 end
   assert_equal(450, ninja.y)
end

function test_ninja_duck_moves_y()
	 ninja.y = 450
	 ninja.downPressed = true
	 ninja:update()
	 ninja:update()
   assert_equal(470, ninja.y)
end

function test_ninja_transitions_to_move_right_when_ducking()
	 ninja.y = 450
	 ninja.downPressed = true
	 ninja:update()
	 ninja.rightPressed = true
	 ninja:update()
   assert_equal(450, ninja.y)
end

function test_ninja_can_jump()
	 ninja.y = 450
	 ninja.jumpPressed = true
	 ninja:update()
   assert_lt(450, ninja.y)
end

function test_ninja_stops_running_when_attacking()
	 ninja.x = 0
	 ninja.rightPressed = true
	 ninja.attackPressed = true
	 ninja:update(true, false)
   assert_equal(0, ninja.x)

	 ninja:update(true, false)
   assert_equal(0, ninja.x)

	 ninja.attackPressed = false
	 ninja:update(true, false)
	 assert_gt(0, ninja.x)
end

function test_ninja_can_move_right()
   ninja.x = 0
	 ninja.rightPressed = true
	 ninja:update(true, false)
   assert_gt(0, ninja.x)
end

function test_ninja_can_stop_moving_right()
   ninja.x = 0
	 ninja.rightPressed = true
	 ninja:update(false, true)

   local x = ninja.x
	 ninja.rightPressed = false
	 ninja:update(false, true)
   assert_equal(x, ninja.x)
end

function test_ninja_can_move_left()
   ninja.x = 0
	 ninja.leftPressed = true
	 ninja:update(false, true)
   assert_lt(0, ninja.x)
end

function test_ninja_can_stop_moving_left()
   ninja.x = 0
	 ninja.leftPressed = true
	 ninja:update(false, true)

   local x = ninja.x
	 ninja.leftPressed = false
	 ninja:update(false, true)
   assert_equal(x, ninja.x)
end
