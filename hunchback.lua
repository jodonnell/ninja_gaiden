require 'class'
require 'sprite'

Hunchback = class(Sprite)

function Hunchback:init(x, y, direction, id, leftBound, rightBound)
	 self.x = x
	 self.y = y
	 self.id = id
	 self.direction = direction
	 self.leftBound = leftBound
	 self.rightBound = rightBound

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

function Hunchback:update(dt)
	 if self.direction == LEFT then
			self.x = self.x - (120 * dt)
	 else
			self.x = self.x + (120 * dt)
	 end

	 if self.x <= self.leftBound then
			self.direction = RIGHT
	 elseif self.x >= self.rightBound then
			self.direction = LEFT
	 end

	 self.timer = self.timer + dt
	 if self.timer < 0.3 then
			self.currentImage = self.images['walk2']
	 elseif self.timer < 0.6 then
			self.currentImage = self.images['walk1']
	 else
			self.timer = 0
	 end
end

function Hunchback:getBoundingBox()
	 return self.x + 30, self.y, self:getWidth() - 35, self:getHeight()
end