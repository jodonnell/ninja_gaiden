module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
   stage = Stage(Ninja())
end

function test_screen_scrolls_when_ninja_in_center()
	 stage.ninja.x = love.graphics.getWidth() / 2
   local x = stage.ninja.x
	 stage.ninja.rightPressed = true
	 stage:scrollScreen()
   assert_equal(4, stage.screenScrollX)
end

function test_does_not_screen_scroll_right()
	 stage.ninja.rightPressed = true
	 stage.screenScrollX = 0
	 stage.ninja.x = 0

	 assert_false(stage:shouldScrollRight())
end

function test_screen_scroll_right()
	 stage.ninja.rightPressed = true
	 stage.screenScrollX = 0
	 stage.ninja.x = love.graphics.getWidth() / 2

	 assert_true(stage:shouldScrollRight())

	 stage.ninja.rightPressed = true
	 stage.screenScrollX = stage.endOfStageX
	 stage.ninja.x = love.graphics.getWidth() / 2

	 assert_false(stage:shouldScrollRight())
end


function test_screen_scroll_left()
	 stage.ninja.leftPressed = true
	 stage.screenScrollX = 0
	 stage.ninja.x = love.graphics.getWidth() / 2

	 assert_false(stage:shouldScrollLeft())

	 stage.ninja.leftPressed = true
	 stage.screenScrollX = stage.endOfStageX
	 stage.ninja.x = love.graphics.getWidth() / 2

	 assert_true(stage:shouldScrollLeft())
end
