module(..., package.seeall)

function setup()
   main_game = MainGame()
	 main_game:load()
end

function teardown()
   main_game = nil
end

function test_ninja_falls()
   local y = main_game.ninja.y
   main_game:update()
   assert_gt(y, main_game.ninja.y)
end
