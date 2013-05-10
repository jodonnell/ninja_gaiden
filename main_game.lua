require 'class'
require 'ninja'

MainGame = class()

function MainGame:init()
end

function MainGame:load()
	 self.image = love.graphics.newImage("stagea.png")
	 self.ninja = Ninja()
	 self.screenScrollX = 0
	 self.endOfStageX = 1020
end

function MainGame:draw()
	 love.graphics.draw(self.image, -self.screenScrollX, 128)
	 self:loveDraw(self.ninja)
	 love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10)
	 love.graphics.print("FPS: "..self.screenScrollX, 10, 30)
end

function MainGame:loveDraw(sprite)
	 love.graphics.draw(sprite:getCurrentImage(), sprite.x, sprite.y)
end

function MainGame:update()
	 local moveNinjaRight = false
	 local moveNinjaLeft = false
	 if self:shouldScrollRight() then
			self.screenScrollX = self.screenScrollX + 4
	 elseif self:shouldMoveNinjaRight() then
			moveNinjaRight = true
	 end

	 if self:shouldScrollLeft() then
			self.screenScrollX = self.screenScrollX - 4
	 elseif self:shouldMoveNinjaLeft() then
			moveNinjaLeft = true
	 end
	 
	 self.ninja:update(moveNinjaRight, moveNinjaLeft)
end

function MainGame:shouldScrollRight()
	 if self.ninja.rightPressed then
			if self.screenScrollX > 0 and self.screenScrollX < self.endOfStageX then
				 return true
			end

			if self.ninja.x >= love.graphics.getWidth() / 2 and self.screenScrollX < self.endOfStageX then
				 return true
			end
	 end
end

function MainGame:shouldScrollLeft()
	 if self.ninja.leftPressed then
			if self.screenScrollX > 0 and self.screenScrollX < self.endOfStageX then
				 return true
			end

			if self.ninja.x <= love.graphics.getWidth() / 2 and self.screenScrollX == 0 then
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