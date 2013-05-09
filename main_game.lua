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
   -- love.graphics.draw(ryu, 105, 450)
	 love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10)
end

function MainGame:loveDraw(sprite)
	 love.graphics.draw(sprite.image, sprite.x, sprite.y)
end

function MainGame:update()
	 self.ninja:update()
end