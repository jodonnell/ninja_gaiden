module(..., package.seeall)
require 'tests.helpers'

function setup()
	 love.graphics.newImage = function(path) return path end

   ninja = Ninja()

	 collision_detection = CollisionDetection(ninja, {Rect(5, 500, 2000, 10)})
end

function test_ninja_lands_on_the_ground()
	 ninja.x = 6
	 ninja:setY(500 - NINJA_HEIGHT - 1)
   assert_false(collision_detection:isBottomColliding())

	 ninja:setY(500 - NINJA_HEIGHT)
   assert_true(collision_detection:isBottomColliding())
end

function test_ninja_right_side_is_on_ground()
	 ninja.x = 6 - NINJA_WIDTH
	 ninja:setY(500 - NINJA_HEIGHT)
   assert_true(collision_detection:isBottomColliding())
end
