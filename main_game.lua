require 'class'
require 'ninja'

MainGame = class()

function MainGame:init()
end

function MainGame:load()
	 self.image = love.graphics.newImage("stagea.png")
	 self.ninja = Ninja()
end

function MainGame:draw()
	 love.graphics.draw(self.image, x, 128)
	 self:loveDraw(self.ninja)
	 love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10)
end

function MainGame:loveDraw(sprite)
	 love.graphics.draw(sprite:getCurrentImage(), sprite.x, sprite.y)
end

function MainGame:update()
	 self.ninja:update()
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