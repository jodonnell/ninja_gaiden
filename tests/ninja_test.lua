module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
   ninja = Ninja()
end

function teardown()
   mainGame = nil
end

function test_ninja_falls()
   local y = ninja.y
   ninja:update()
   assert_gt(y, ninja.y)
end

function test_ninja_lands_on_the_ground()
	 for i=1,50 do
			ninja:update()
	 end
   assert_equal(450, ninja.y)
end

function test_ninja_goes_to_stand_animation()
	 for i=1,50 do
			ninja:update()
	 end
   assert_equal(ninja.image, ninja:getCurrentImage())
end
