require 'class'

Stage = class()

function Stage:init(ninja)
	 self.image = love.graphics.newImage("images/stage.png")
	 self.ninjaX = ninja.x

	 self.screenScrollX = 0
	 self.endOfStageX = 2038
	 self.ninja = ninja
end

function Stage:draw()
	 love.graphics.draw(self.image, -self.screenScrollX, 128)
end
