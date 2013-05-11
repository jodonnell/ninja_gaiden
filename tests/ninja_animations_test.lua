module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
   animations = NinjaAnimations()
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


function test_ninja_moving_left_runs_animation()
	 animations:runLeft()
	 assert_equal(animations:getCurrentImage(), animations.images['running1Left'])
	 
	 for i=1,5 do
			animations:changeAnimation()
	 end

	 assert_equal(animations:getCurrentImage(), animations.images['running2Left'])
	 
	 for i=1,4 do
			animations:changeAnimation()
	 end

	 assert_equal(animations:getCurrentImage(), animations.images['running3Left'])

	 for i=1,4 do
			animations:changeAnimation()
	 end

	 assert_equal(animations:getCurrentImage(), animations.images['running1Left'])
end

function test_ninja_moving_right_runs_animation()
	 animations:runRight()
	 assert_equal(animations:getCurrentImage(), animations.images['running1Right'])
	 
	 for i=1,5 do
			animations:changeAnimation()
	 end

	 assert_equal(animations:getCurrentImage(), animations.images['running2Right'])
	 
	 for i=1,4 do
			animations:changeAnimation()
	 end

	 assert_equal(animations:getCurrentImage(), animations.images['running3Right'])

	 for i=1,4 do
			animations:changeAnimation()
	 end

	 assert_equal(animations:getCurrentImage(), animations.images['running1Right'])
end
