require 'class'
require 'sprite'
require 'images'

Powerup = class(Sprite)

function Powerup:init(x, y)
	 self.x = x
	 self.y = y

	 self.currentImage = images.images['powerup']
end

function Powerup:draw()
	 local image = self:getCurrentImage()
	 love.graphics.draw(image, self.x, self.y)
end

function Powerup:update(dt)
	 self.timer = self.timer + dt
end

function Powerup:getBoundingBox()
	 return self.x + 30, self.y, self:getWidth() - 35, self:getHeight()
end