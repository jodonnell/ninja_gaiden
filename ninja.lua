require 'class'

Ninja = class()

function Ninja:init()
	 self.image = love.graphics.newImage("images/ryu_stand_right.png")
	 self.falling = love.graphics.newImage("images/ryu_falling_right.png")
	 self.currentImage = self.image
	 self.x = 105
	 self.y = 150
end

function Ninja:update()
	 if self.y < 450 then
			self.y = self.y + 10
			self.currentImage = self.falling
	 else
			self.currentImage = self.image
	 end
end

function Ninja:getCurrentImage()
	 return self.currentImage
end

function Ninja:moveRight()
	 self.x = self.x + 4
end

function Ninja:moveLeft()
	 self.x = self.x - 4
end