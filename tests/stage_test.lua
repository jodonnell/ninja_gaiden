module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
   stage = Stage(Ninja())
end

function test_can_get_climbable_rects()
	 assert_equal(1, stage:climbableRects()[1]:left())
end