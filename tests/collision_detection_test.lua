module(..., package.seeall)
require 'tests.helpers'

function setup()
	 love.graphics.newImage = function(path) return path end

   ninja = Ninja()

	 collision_detection = CollisionDetection(ninja, {Rect(5, 500, 500, 100)})
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

function test_ninja_collision_detection_left_works_correctly()
	 ninja.x = 505
	 ninja.lastX = 505
	 ninja:setY(550)
   assert_true(collision_detection:isLeftColliding())
end

function test_ninja_collision_detection_right_works_correctly()
	 ninja.x = 5 - NINJA_WIDTH + 10
	 ninja.lastX = 5 - NINJA_WIDTH + 10
	 ninja:setY(550)
   assert_true(collision_detection:isRightColliding())
end

function test_ninja_collision_detection_top_right_works_correctly()
	 ninja.x = 5 - NINJA_WIDTH + 10
	 ninja.lastX = 5 - NINJA_WIDTH + 10
	 ninja:setY(500 - NINJA_HEIGHT - 1)
   assert_false(collision_detection:isRightColliding())

	 ninja:setY(500 - NINJA_HEIGHT)
   assert_true(collision_detection:isRightColliding())
end
