require 'class'
require 'ninja'
require 'stage'

MainGame = class()

function MainGame:init()
end

function MainGame:load()
	 self.ninja = Ninja()
	 self.stage = Stage()
end

function MainGame:draw()
	 self.stage:draw()
	 self.ninja:draw()
	 love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10)
end

function MainGame:update()
	 local moveNinjaRight, moveNinjaLeft = self:scrollScreen()
	 self.ninja:update(moveNinjaRight, moveNinjaLeft)
end

function MainGame:scrollScreen()
	 local moveNinjaRight = self:scrollScreenRight()
	 local moveNinjaLeft = self:scrollScreenLeft()
	 return moveNinjaRight, moveNinjaLeft
end

function MainGame:scrollScreenRight()
	 if self:shouldScrollRight() then
			self.stage:moveRight()
	 elseif self:shouldMoveNinjaRight() then
			return true
	 end
	 return false
end

function MainGame:scrollScreenLeft()
	 if self:shouldScrollLeft() then
			self.stage:moveLeft()
	 elseif self:shouldMoveNinjaLeft() then
			return true
	 end
	 return false
end

function MainGame:shouldScrollRight()
	 if self.ninja.rightPressed then
			if self.stage:isInMiddleOfStage() then
				 return true
			end

			if self.ninja.x >= love.graphics.getWidth() / 2 and not self.stage:atEndOfStage() then
				 return true
			end
	 end
end

function MainGame:shouldScrollLeft()
	 if self.ninja.leftPressed then
			if self.stage:isInMiddleOfStage() then
				 return true
			end

			if self.ninja.x <= love.graphics.getWidth() / 2 and self.stage:atEndOfStage() then
				 return true
			end
	 end
	 return false
end

function MainGame:shouldMoveNinjaLeft()
	 if self.ninja.leftPressed and not self:shouldScrollLeft() then
			return true
	 end
	 return false
end

function MainGame:shouldMoveNinjaRight()
	 if self.ninja.rightPressed and not self:shouldScrollRight() then
			return true
	 end
	 return false
end

function MainGame:pressRight()
	 self.ninja.rightPressed = true
end

function MainGame:releaseRight()
	 self.ninja.rightPressed = false
end

function MainGame:pressLeft()
	 self.ninja.leftPressed = true
end

function MainGame:releaseLeft()
	 self.ninja.leftPressed = false
end

function MainGame:pressDown()
	 self.ninja.downPressed = true
end

function MainGame:releaseDown()
	 self.ninja.downPressed = false
end

function MainGame:pressJump()
	 self.ninja.jumpPressed = true
end

function MainGame:pressAttack()
	 self.ninja.attackPressed = true
end