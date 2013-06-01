module(..., package.seeall)
require 'tests.helpers'

function setup()
	 love.graphics.newImage = function(path) return path end

   ninja = Ninja()
	 ninja:setClimbableRects({Rect(0, 450, 2000, 450)})
	 ninja:setY(450)
end

function test_ninja_falls()
   ninja.y = 100
   ninja:update(ONE_FRAME)
   assert_gt(100, ninja.y)
end

function test_ninja_transitions_to_move_right_when_ducking()
	 ninja.downPressed = true
	 ninja:update(ONE_FRAME)
	 ninja.rightPressed = true
	 ninja:update(ONE_FRAME)
   assert_equal(450, ninja.y)
end

function test_ninja_can_jump()
	 ninja:startJumping()
	 ninja:update(ONE_FRAME)
   assert_lt(450, ninja.y)
end

function test_ninja_can_get_hurt()
	 local x = ninja.x
	 ninja:gotHurt()
	 ninja:update(ONE_FRAME)
	 assert_lt(x, ninja.x)
	 assert_lt(450, ninja.y)
end

function test_ninja_can_get_hurt_and_bounces_right()
	 local x = ninja.x
	 ninja:gotHurt(true)
	 ninja:update(ONE_FRAME)
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

function test_ninja_status_reset_when_hurt()
	 ninja.jumpPressed = true
	 ninja.isAttacking = true
	 ninja.isClimbing = true
	 ninja:gotHurt()
	 ninja:update(ONE_FRAME)
	 assert_false(ninja.jumpPressed)
	 assert_false(ninja.isAttacking)
	 assert_false(ninja.isClimbing)
end

function test_ninja_becomes_invincible_when_hurt()
	 ninja:gotHurt()
	 ninja:update(ONE_FRAME)
	 assert_true(ninja.isInvincible)

	 update(ninja, 80)
	 assert_false(ninja.isInvincible)
end

function test_ninja_does_not_fall_when_climbing()
	 ninja.y = 100
	 ninja.isClimbing = true
	 assert_false(ninja:isFalling())
end

function test_ninja_climbs_up()
	 ninja.x = 99
	 ninja.y = 100
	 ninja.rightPressed = true
	 ninja:setClimbableRects({Rect(100, 50, 101, 300)})

	 ninja:update(ONE_FRAME)

	 ninja.rightPressed = false
	 ninja.upPressed = true

	 ninja:update(ONE_FRAME)
	 assert_lt(100, ninja.y)
end

function test_ninja_climbs_down()
	 ninja.x = 99
	 ninja.y = 100
	 ninja.rightPressed = true
	 ninja:setClimbableRects({Rect(100, 50, 101, 300)})

	 ninja:update(ONE_FRAME)

	 ninja.rightPressed = false
	 ninja.downPressed = true

	 ninja:update(ONE_FRAME)
	 assert_gt(100, ninja.y)
end

function test_ninja_cannot_jump_over_and_over()
	 ninja:startJumping()
	 ninja:update(ONE_FRAME)
	 assert_false(ninja:canJump())
end

function test_ninja_has_life()
	 assert_equal(NINJA_MAX_LIFE, ninja.life)
end

function test_ninja_loses_life_when_hurt()
	 ninja:gotHurt()
	 assert_equal(NINJA_MAX_LIFE - 1, ninja.life)
end

function test_ninja_has_lives()
	 assert_equal(NINJA_STARTING_LIVES, ninja.lives)
end
