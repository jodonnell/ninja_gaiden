require 'class'
require 'ninja'

MainGame = class()

function MainGame:init()
	 self.rightPressed = false
	 self.leftPressed = false
end

function MainGame:load()
	 self.image = love.graphics.newImage("stagea.png")
	 self.ninja = Ninja()
end

function MainGame:draw()
	 love.graphics.draw(self.image, x, 128)
	 self:loveDraw(self.ninja)
   -- love.graphics.draw(ryu, 105, 450)
	 love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10)
end

function MainGame:loveDraw(sprite)
	 love.graphics.draw(sprite:getCurrentImage(), sprite.x, sprite.y)
end

function MainGame:update()
	 if self.rightPressed then
			self.ninja:moveRight()
	 elseif self.leftPressed then
			self.ninja:moveLeft()
	 end

	 self.ninja:update()
end

function MainGame:pressRight()
	 self.rightPressed = true
end

function MainGame:releaseRight()
	 self.rightPressed = false
end

function MainGame:pressLeft()
	 self.leftPressed = true
end

function MainGame:releaseLeft()
	 self.leftPressed = false
end