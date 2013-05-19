require 'class'
require 'sprite'

Hunchback = class(Sprite)

function Hunchback:init(x, y, direction)
	 self.x = x
	 self.y = y
	 self.direction = direction

	 self.images = { 
			walk1 = love.graphics.newImage("images/hunchback_walk1.png"),
			walk2 = love.graphics.newImage("images/hunchback_walk2.png")
	 }
	 self.currentImage = self.images['walk1']
	 self.timer = 0
end

function Hunchback:draw()
	 local image = self:getCurrentImage()
	 local imageWidth = image:getWidth()
	 if self.direction == LEFT then
			love.graphics.draw(image, self.x + imageWidth, self.y, 0, -1, 1)
	 else
			love.graphics.draw(image, self.x, self.y)
	 end
end

function Hunchback:update()
	 self.x = self.x - 2

	 self.timer = self.timer + 1
	 if self.timer == 10 then
			self.currentImage = self.images['walk2']
	 elseif self.timer == 20 then
			self.currentImage = self.images['walk1']
			self.timer = 0
	 end
end

function Hunchback:getBoundingBox()
	 return self.x + 30, self.y, self:getWidth() - 35, self:getHeight()
end