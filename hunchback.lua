require 'class'

Hunchback = class()

function Hunchback:init()
	 self.x = 800
	 self.y = 450

	 self.images = { 
			walk1Right = love.graphics.newImage("images/hunchback_walk1_right.png"),
			walk2Right = love.graphics.newImage("images/hunchback_walk1_right.png"),
			walk1Left = love.graphics.newImage("images/hunchback_walk1_left.png"),
			walk2Left = love.graphics.newImage("images/hunchback_walk1_left.png")
	 }
	 self.currentImage = self.images['walk1Left']
end

function Hunchback:draw()
	 love.graphics.draw(self:getCurrentImage(), self.x, self.y)
end

function Hunchback:getCurrentImage()
	 return self.currentImage
end
