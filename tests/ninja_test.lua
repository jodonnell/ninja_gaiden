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

function test_ninja_goes_to_stand_animation()
	 for i=1,50 do
			ninja:update()
	 end
   assert_equal(ninja.image, ninja:getCurrentImage())
end

function test_ninja_can_duck()
	 ninja.y = 450
	 ninja.downPressed = true
	 ninja:update()
	 ninja:update()
   assert_equal(ninja.duckingRight, ninja:getCurrentImage())
   assert_equal(470, ninja.y)
end

function test_ninja_transitions_to_move_right_when_ducking()
	 ninja.y = 450
	 ninja.downPressed = true
	 ninja:update()
	 ninja.rightPressed = true
	 ninja:update()
   assert_equal(ninja.runningRight1, ninja:getCurrentImage())
   assert_equal(450, ninja.y)
end

function test_ninja_can_jump()
	 ninja.y = 450
	 ninja.jumpPressed = true
	 ninja:update()
   assert_equal(440, ninja.y)
end
