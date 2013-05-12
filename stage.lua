require 'class'

Stage = class()

function Stage:init()
	 self.image = love.graphics.newImage("stagea.png")
	 self.screenScrollX = 0
	 self.endOfStageX = 1020
end

function Stage:draw()
	 love.graphics.draw(self.image, -self.screenScrollX, 128)
	 love.graphics.print("scroll: "..self.screenScrollX, 10, 30)
end

function Stage:isInMiddleOfStage()
	 return self.screenScrollX > 0 and self.screenScrollX < self.endOfStageX
end

function Stage:atEndOfStage()
	 return self.screenScrollX == self.endOfStageX
end

function Stage:moveRight()
	 self.screenScrollX = self.screenScrollX + 4
end

function Stage:moveLeft()
	 self.screenScrollX = self.screenScrollX - 4
end