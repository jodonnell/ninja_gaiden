module(..., package.seeall)
require 'tests.helpers'

function setup()
	 love.graphics.newImage = function(path) return path end
   hunchback = Hunchback(100, 100, LEFT)
end

function test_hunchback_animates()
   assert_equal(hunchback.images['walk1Left'], hunchback:getCurrentImage())

	 update(hunchback, 10)
   assert_equal(hunchback.images['walk2Left'], hunchback:getCurrentImage())

	 update(hunchback, 10)
   assert_equal(hunchback.images['walk1Left'], hunchback:getCurrentImage())
end

function test_hunchback_moves_left()
	 hunchback:update()
	 assert_lt(100, hunchback.x)
end
