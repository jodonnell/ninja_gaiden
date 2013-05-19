module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
   explosion = Explosion(100, 100)
end

function test_animation_finishes()
	 assert_false(explosion:isExplosionFinished())
	 update(explosion, 20)
	 assert_true(explosion:isExplosionFinished())
end
