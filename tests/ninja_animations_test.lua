module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
   animations = NinjaAnimations(Ninja())
end

function teardown()
   animations = nil
end

function test_fall_animation()
	 animations:fall()
   assert_equal(animations.images['fallingRight'], animations:getCurrentImage())
end

function test_left_animation()
	 animations.direction = LEFT
	 animations:fall()
   assert_equal(animations.images['fallingLeft'], animations:getCurrentImage())
end

function test_stand_animation()
	 animations:stand()
   assert_equal(animations.images['standingRight'], animations:getCurrentImage())
end

function test_duck_animation()
	 animations:duck()
   assert_equal(animations.images['duckingRight'], animations:getCurrentImage())
end

function test_attack_animation()
	 animations:attack()
   assert_equal(animations.images['attacking1Right'], animations:getCurrentImage())

	 advanceFrames(5)
   assert_equal(animations.images['attacking2Right'], animations:getCurrentImage())

	 advanceFrames(5)
   assert_equal(animations.images['attacking3Right'], animations:getCurrentImage())
end

function test_attack_when_falling_does_a_different_animation()
	 animations.currentImage = 'falling'
	 animations:attack()
   assert_equal(animations.images['fallingAttack1Right'], animations:getCurrentImage(), 'not first attack animation')

	 advanceFrames(5)
   assert_equal(animations.images['fallingAttack2Right'], animations:getCurrentImage(), 'not second attack animation')

	 advanceFrames(4)
   assert_equal(animations.images['fallingRight'], animations:getCurrentImage(), 'not original fall animation')
	 
end


function test_ninja_moving_left_runs_animation()
	 animations:runLeft()
	 assert_equal(animations.images['running1Left'], animations:getCurrentImage())
	 
	 advanceFrames(5)
	 assert_equal(animations.images['running2Left'], animations:getCurrentImage())
	 
	 advanceFrames(4)
	 assert_equal(animations.images['running3Left'], animations:getCurrentImage())

	 advanceFrames(4)
	 assert_equal(animations.images['running1Left'], animations:getCurrentImage())
end

function test_ninja_moving_right_runs_animation()
	 animations:runRight()
	 assert_equal(animations.images['running1Right'], animations:getCurrentImage())
	 
	 advanceFrames(5)
	 assert_equal(animations.images['running2Right'], animations:getCurrentImage())
	 
	 advanceFrames(4)
	 assert_equal(animations.images['running3Right'], animations:getCurrentImage())

	 advanceFrames(4)
	 assert_equal(animations.images['running1Right'], animations:getCurrentImage())
end

function advanceFrames(numFrames)
	 for i=1, numFrames do
			animations:changeAnimation()
	 end
end