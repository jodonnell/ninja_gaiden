module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end

   ninja = Ninja()
	 ninja:setClimbableRects({Rect(0, 450, 2000, 450)})
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

function test_ninja_transitions_to_move_right_when_ducking()
	 ninja.downPressed = true
	 ninja:update()
	 ninja.rightPressed = true
	 ninja:update()
   assert_equal(450, ninja.y)
end

function test_ninja_can_jump()
	 ninja:startJumping()
	 ninja:update()
   assert_lt(450, ninja.y)
end

function test_ninja_can_get_hurt()
	 local x = ninja.x
	 ninja:gotHurt()
	 ninja:update()
	 assert_lt(x, ninja.x)
	 assert_lt(450, ninja.y)
end

function test_ninja_can_get_hurt_and_bounces_right()
	 local x = ninja.x
	 ninja:gotHurt(true)
	 ninja:update()
	 assert_gt(x, ninja.x)
	 assert_lt(450, ninja.y)
end

function test_ninja_can_not_take_any_other_actions_when_hurt()
	 ninja.y = 440
	 ninja.isHurt = true
	 assert_false(ninja:isFalling())

	 ninja.y = 450
	 assert_false(ninja:canDuck())

	 assert_false(ninja:canAttack())

	 assert_false(ninja:isStanding())

	 ninja.rightPressed = true
	 assert_false(ninja:isMovingRight())

	 ninja.rightPressed = false
	 ninja.leftPressed = true
	 assert_false(ninja:isMovingLeft())
end

function test_ninja_stops_jumping_and_attacking_when_hurt()
	 ninja.jumpPressed = true
	 ninja.isAttacking = true
	 ninja:gotHurt()
	 ninja:update()
	 assert_false(ninja.jumpPressed)
	 assert_false(ninja.isAttacking)
end

function test_ninja_becomes_invincible_when_hurt()
	 ninja:gotHurt()
	 ninja:update()
	 assert_true(ninja.isInvincible)

	 update(ninja, 80)
	 assert_false(ninja.isInvincible)
end

function test_ninja_does_not_fall_when_climbing()
	 ninja.y = 100
	 ninja.isClimbing = true
	 assert_false(ninja:isFalling())
end

function test_ninja_collision_detection_works_correctly()
	 ninja.x = 10
	 ninja.y = 80
	 ninja:setClimbableRects({Rect(5, 50, 2000, 50)})
	 ninja:update()
	 assert_gt(80, ninja.y)
end

function test_ninja_collision_detection_left_works_correctly()
	 ninja.x = 100
	 ninja.y = 120
	 ninja:setClimbableRects({Rect(5, 50, 99, 300)})
	 ninja.leftPressed = true
	 ninja:update()
	 assert_true(ninja.isClimbing)
end

function test_ninja_collision_detection_right_works_correctly()
	 ninja.x = 4
	 ninja.y = 120
	 ninja:setClimbableRects({Rect(5, 50, 99, 300)})
	 ninja.rightPressed = true
	 ninja:update()
	 assert_true(ninja.isClimbing)
end

function test_ninja_climbs_up()
	 ninja.x = 99
	 ninja.y = 100
	 ninja.rightPressed = true
	 ninja:setClimbableRects({Rect(100, 50, 101, 300)})

	 ninja:update()

	 ninja.rightPressed = false
	 ninja.upPressed = true

	 ninja:update()
	 assert_lt(100, ninja.y)
end

function test_ninja_climbs_down()
	 ninja.x = 99
	 ninja.y = 100
	 ninja.rightPressed = true
	 ninja:setClimbableRects({Rect(100, 50, 101, 300)})

	 ninja:update()

	 ninja.rightPressed = false
	 ninja.downPressed = true

	 ninja:update()
	 assert_gt(100, ninja.y)
end

function test_ninja_cannot_jump_over_and_over()
	 ninja:startJumping()
	 ninja:update()
	 assert_false(ninja:canJump())
end