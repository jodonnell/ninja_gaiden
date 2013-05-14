module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
   ninja = Ninja()
	 ninja.y = 450
end

function test_ninja_falls()
   ninja.y = 100
   ninja:update()
   assert_gt(100, ninja.y)
end

function test_ninja_lands_on_the_ground()
	 for i=1,50 do
			ninja:update()
	 end
   assert_equal(450, ninja.y)
end

function test_ninja_duck_moves_y()
	 ninja.downPressed = true
	 ninja:update()
	 ninja:update()
   assert_equal(470, ninja.y)
end

function test_ninja_transitions_to_move_right_when_ducking()
	 ninja.downPressed = true
	 ninja:update()
	 ninja.rightPressed = true
	 ninja:update()
   assert_equal(450, ninja.y)
end

function test_ninja_can_jump()
	 ninja.jumpPressed = true
	 ninja:update()
   assert_lt(450, ninja.y)
end
