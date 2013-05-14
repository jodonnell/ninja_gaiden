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

function test_does_not_scroll_when_ninja_attacking()
	 stage.ninja.rightPressed = true
	 stage.ninja.isAttacking = true
	 stage.screenScrollX = 20

	 assert_false(stage:shouldScrollRight())
end

function test_moves_ninja_right()
   stage.ninja.x = 0
	 stage.ninja.rightPressed = true
	 stage:scrollScreen()
   assert_gt(0, stage.ninja.x)
end

function test_ninja_can_move_left()
   stage.ninja.x = 0
	 stage.ninja.leftPressed = true
	 stage:scrollScreen()
   assert_lt(0, stage.ninja.x)
end


function test_ninja_stops_running_when_attacking()
	 stage.ninja.x = 0
	 stage.ninja.rightPressed = true
	 stage.ninja.isAttacking = true
	 stage:scrollScreen()
   assert_equal(0, stage.ninja.x, 'Moved when attacked')

	 stage.ninja.isAttacking = false
	 stage:scrollScreen()
	 assert_gt(0, stage.ninja.x, 'Didnt move even after stopped attacking')
end
