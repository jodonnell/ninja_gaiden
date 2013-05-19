require 'class'
require 'sprite'

Explosion = class(Sprite)

function Explosion:init(x, y)
	 self.currentImage = love.graphics.newImage("images/enemy_explode.png")
	 self.x = x + 30
	 self.y = y
	 self.explosionHeight = self:getHeight()
	 self.explosionWidth = self:getWidth()

	 self.timer = 0
end

function Explosion:update()
	 self.timer = self.timer + 8
end

function Explosion:draw()
	 local xSpread = 14 + self.timer
	 local ySpread = 5 + self.timer

	 -- top right
	 love.graphics.draw(self:getCurrentImage(), self.x + xSpread, self.y - ySpread, 0, 1, 1)

	 -- top lefth
	 love.graphics.draw(self:getCurrentImage(), self.x - xSpread, self.y - ySpread, 0, -1, 1)

	 -- bottom right
	 love.graphics.draw(self:getCurrentImage(), self.x + xSpread, self.y + ySpread + self.explosionHeight * 2, 0, 1, -1)

	 --bottom left
	 love.graphics.draw(self:getCurrentImage(), self.x - xSpread, self.y + ySpread + self.explosionHeight * 2, 0, -1, -1)
end

function Explosion:isExplosionFinished()
	 if self.timer > 40 then
			return true
	 end
	 return false
end