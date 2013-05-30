module(..., package.seeall)
require 'tests.helpers'

function setup()
	 love.graphics.newImage = function(path) return path end
   hunchback = Hunchback(100, 100, LEFT, 0, 200)
end

function test_hunchback_animates()
   assert_equal(hunchback.images['walk1'], hunchback:getCurrentImage())

	 update(hunchback, 10)
   assert_equal(hunchback.images['walk2'], hunchback:getCurrentImage())

	 update(hunchback, 10)
   assert_equal(hunchback.images['walk1'], hunchback:getCurrentImage())
end

function test_hunchback_moves_left()
	 hunchback:update(0.0166666666667)
	 assert_lt(100, hunchback.x)
end

function test_hunchback_turns_around_at_bound()
	 hunchback.x = 1
	 hunchback:update(0.1)
	 assert_equal(RIGHT, hunchback.direction)
end
