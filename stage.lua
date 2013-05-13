require 'class'

Stage = class()

function Stage:init(ninja)
	 self.image = love.graphics.newImage("stagea.png")
	 self.screenScrollX = 0
	 self.endOfStageX = 1020
	 self.ninja = ninja
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

function Stage:scrollScreen()
	 self:scrollScreenRight()
	 self:scrollScreenLeft()
end

function Stage:scrollScreenRight()
	 if self:shouldScrollRight() then
			self:moveRight()
	 elseif self:shouldMoveNinjaRight() then
			self.ninja.x = self.ninja.x + 4
	 end
end

function Stage:scrollScreenLeft()
	 if self:shouldScrollLeft() then
			self:moveLeft()
	 elseif self:shouldMoveNinjaLeft() then
			self.ninja.x = self.ninja.x - 4
	 end
end

function Stage:shouldScrollRight()
	 if self.ninja.rightPressed and self.ninja.attackPressed == false then
			if self:isInMiddleOfStage() then
				 return true
			end

			if self.ninja.x >= love.graphics.getWidth() / 2 and not self:atEndOfStage() then
				 return true
			end
	 end
end

function Stage:shouldScrollLeft()
	 if self.ninja.leftPressed and self.ninja.attackPressed == false then
			if self:isInMiddleOfStage() then
				 return true
			end

			if self.ninja.x <= love.graphics.getWidth() / 2 and self:atEndOfStage() then
				 return true
			end
	 end
	 return false
end

function Stage:shouldMoveNinjaLeft()
	 if self.ninja.leftPressed and not self:shouldScrollLeft() then
			return true
	 end
	 return false
end

function Stage:shouldMoveNinjaRight()
	 if self.ninja.rightPressed and not self:shouldScrollRight() then
			return true
	 end
	 return false
end
