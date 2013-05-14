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
   assert_equal(animations:getCurrentImage(), animations.images['fallingRight'])
end

function test_left_animation()
	 animations.direction = LEFT
	 animations:fall()
   assert_equal(animations:getCurrentImage(), animations.images['fallingLeft'])
end

function test_stand_animation()
	 animations:stand()
   assert_equal(animations:getCurrentImage(), animations.images['standingRight'])
end

function test_duck_animation()
	 animations:duck()
   assert_equal(animations:getCurrentImage(), animations.images['duckingRight'])
end

function test_attack_animation()
	 animations:attack()
   assert_equal(animations:getCurrentImage(), animations.images['attacking1Right'])

	 advanceFrames(5)
   assert_equal(animations:getCurrentImage(), animations.images['attacking2Right'])

	 advanceFrames(5)
   assert_equal(animations:getCurrentImage(), animations.images['attacking3Right'])
end

function test_attack_when_falling_does_a_different_animation()
	 animations.currentImage = 'falling'
	 animations:attack()
   assert_equal(animations:getCurrentImage(), animations.images['fallingAttack1Right'], 'not first attack animation')

	 advanceFrames(5)
   assert_equal(animations:getCurrentImage(), animations.images['fallingAttack2Right'], 'not second attack animation')

	 advanceFrames(5)
   assert_equal(animations:getCurrentImage(), animations.images['fallingRight'], 'not original fall animation')
	 
end


function test_ninja_moving_left_runs_animation()
	 animations:runLeft()
	 assert_equal(animations:getCurrentImage(), animations.images['running1Left'])
	 
	 advanceFrames(5)
	 assert_equal(animations:getCurrentImage(), animations.images['running2Left'])
	 
	 advanceFrames(4)
	 assert_equal(animations:getCurrentImage(), animations.images['running3Left'])

	 advanceFrames(4)
	 assert_equal(animations:getCurrentImage(), animations.images['running1Left'])
end

function test_ninja_moving_right_runs_animation()
	 animations:runRight()
	 assert_equal(animations:getCurrentImage(), animations.images['running1Right'])
	 
	 advanceFrames(5)
	 assert_equal(animations:getCurrentImage(), animations.images['running2Right'])
	 
	 advanceFrames(4)
	 assert_equal(animations:getCurrentImage(), animations.images['running3Right'])

	 advanceFrames(4)
	 assert_equal(animations:getCurrentImage(), animations.images['running1Right'])
end

function advanceFrames(numFrames)
	 for i=1, numFrames do
			animations:changeAnimation()
	 end
end