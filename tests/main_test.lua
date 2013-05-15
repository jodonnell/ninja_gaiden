module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
   mainGame = MainGame()
	 mainGame:load()
end

function teardown()
   mainGame = nil
end

function test_ninja_jump_attack_and_move_right()
   mainGame.ninja.x = 0
	 mainGame.ninja.rightPressed = true
	 mainGame.ninja.jumpPressed = true
	 
	 for i=1, 10 do
	 		mainGame:update()
	 end

	 mainGame.ninja.isAttacking = true

   local x = mainGame.ninja.x
   local y = mainGame.ninja.y
	 mainGame:update()

   assert_gt(x, mainGame.ninja.x, 'Should move right')
   assert_lt(y, mainGame.ninja.y, 'Should move up')
end

function test_enemy_appears_at_when_scrolling()
	 mainGame.ninja.x = love.graphics.getWidth() / 2
	 mainGame.ninja.rightPressed = true
   assert_equal(0, #mainGame.enemies, 'No enemies')

	 mainGame:update()
   assert_equal(1, #mainGame.enemies, 'One enemy')
end
