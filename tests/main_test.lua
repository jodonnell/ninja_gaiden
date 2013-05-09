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

function test_ninja_goes_into_fall_animation()
   main_game:update()
   assert_equal(main_game.ninja.falling, main_game.ninja:getCurrentImage())
end

function test_ninja_lands_on_the_ground()
	 for i=1,50 do
			main_game:update()
	 end
   assert_equal(450, main_game.ninja.y)
end

function test_ninja_goes_to_stand_animation()
	 for i=1,50 do
			main_game:update()
	 end
   assert_equal(main_game.ninja.image, main_game.ninja:getCurrentImage())
end
