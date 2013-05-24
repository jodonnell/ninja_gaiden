require 'class'
require 'rect'

Stage = class()

function Stage:init(ninja)
	 self.image = love.graphics.newImage("images/stage.png")
	 self.ninjaX = ninja.x

	 self.screenScrollX = 0
	 self.endOfStageX = 2038
	 self.ninja = ninja
	 self:createClimbableRects()
	 self.ninja:setClimbableRects(self.rects)
end

function Stage:draw()
	 love.graphics.draw(self.image, -self.screenScrollX, 128)
end

function Stage:createClimbableRects()
	 self.rects = {}
	 self.rects[1] = Rect(0, 450, self.endOfStageX, 451)
	 self.rects[2] = Rect(80, 0, 80, 450)

	 self.rects[3] = Rect(1705, 275, 1784, 275)
end

function Stage:climbableRects()
	 return self.rects
end