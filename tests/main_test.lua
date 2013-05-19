module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
	 function NinjaAnimations:getNormalWidth()
			return 20
	 end

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
	 mainGame.ninja.x = 581
	 mainGame.ninja.rightPressed = true
   assert_equal(0, #mainGame.enemies, 'No enemies')

	 mainGame:update()
   assert_equal(1, #mainGame.enemies, 'One enemy')
end

function test_ninja_can_hit_enemy()
	 function Ninja:getWidth()
			return 20
	 end
	 function Ninja:getHeight()
			return 20
	 end
	 function Hunchback:getWidth()
			return 20
	 end
	 function Hunchback:getHeight()
			return 20
	 end

	 mainGame.ninja.x = 400
	 table.insert(mainGame.enemies, Hunchback(400, mainGame.ninja.y, LEFT))
	 mainGame:update()
	 assert_true(mainGame.ninja.isHurt)
end

function advanceDraw(newX)
	 mainGame.enemies[1].loveDraw = function(self, image, x, y) 
	 		assert_equal(newX, x, 'Moved relatively 4')
	 end

	 mainGame:update()
	 mainGame:draw()
end