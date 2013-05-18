require 'class'

Hunchback = class()

function Hunchback:init(x, y, direction)
	 self.x = x
	 self.y = y
	 self.direction = direction

	 self.images = { 
			walk1Right = love.graphics.newImage("images/hunchback_walk1_right.png"),
			walk2Right = love.graphics.newImage("images/hunchback_walk2_right.png"),
			walk1Left = love.graphics.newImage("images/hunchback_walk1_left.png"),
			walk2Left = love.graphics.newImage("images/hunchback_walk2_left.png")
	 }
	 self.currentImage = self.images['walk1Left']
	 self.timer = 0
end

function Hunchback:draw()
	 love.graphics.draw(self:getCurrentImage(), self.x, self.y)
end

function Hunchback:update()
	 self.x = self.x - 2

	 self.timer = self.timer + 1
	 if self.timer == 10 then
			self.currentImage = self.images['walk2Left']
	 elseif self.timer == 20 then
			self.currentImage = self.images['walk1Left']
			self.timer = 0
	 end
end

function Hunchback:getCurrentImage()
	 return self.currentImage
end
