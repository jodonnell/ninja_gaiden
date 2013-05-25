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

	 self.rects[3] = Rect(895, 150, 1015, 450)

	 self.rects[4] = Rect(1070, 240, 1349, 450)

	 self.rects[5] = Rect(1675, 320, 1784, 320)

	 self.rects[6] = Rect(1845, 240, self.endOfStageX, 450)
end

function Stage:climbableRects()
	 return self.rects
end