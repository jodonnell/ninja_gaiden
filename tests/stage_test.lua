module(..., package.seeall)

function setup()
	 love.graphics.newImage = function(path) return path end
   stage = Stage(Ninja())
	 stage.ninja.y = 450
end

