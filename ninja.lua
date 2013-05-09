require 'class'

Ninja = class()

function Ninja:init()
	 self.image = love.graphics.newImage("images/ryu_stand_right.png")
	 self.left = love.graphics.newImage("images/ryu_stand_left.png")
	 self.falling = love.graphics.newImage("images/ryu_falling_right.png")
	 self.runningRight1 = love.graphics.newImage("images/ryu_running_1_right.png")
	 self.runningRight2 = love.graphics.newImage("images/ryu_running_2_right.png")
	 self.runningRight3 = love.graphics.newImage("images/ryu_running_3_right.png")

	 self.runningLeft1 = love.graphics.newImage("images/ryu_running_1_left.png")
	 self.runningLeft2 = love.graphics.newImage("images/ryu_running_2_left.png")
	 self.runningLeft3 = love.graphics.newImage("images/ryu_running_3_left.png")

	 self.currentImage = self.image
	 self.x = 105
	 self.y = 150

	 self.rightPressed = false
	 self.leftPressed = false

	 self.timer = 0
end

function Ninja:update()
	 if self.rightPressed then
			self:moveRight()
	 elseif self.leftPressed then
			self:moveLeft()
	 end

	 if self.y < 450 then
			self.y = self.y + 10
			self.currentImage = self.falling
	 elseif self.currentImage == self.falling then
			self.currentImage = self.image
	 elseif not (self.leftPressed or self.rightPressed) then
			self.currentImage = self.image
	 end
end

function Ninja:getCurrentImage()
	 return self.currentImage
end

function Ninja:moveRight()
	 self.x = self.x + 4
	 self.timer = self.timer + 1
	 
	 if self.timer == 1 then
			self.currentImage = self.runningRight1
	 elseif self.timer == 5 then
			self.currentImage = self.runningRight2
	 elseif self.timer == 9 then
			self.currentImage = self.runningRight3
	 elseif self.timer == 12 then
			self.timer = 0
	 end
end

function Ninja:moveLeft()
	 self.x = self.x - 4

	 self.timer = self.timer + 1
	 
	 if self.timer == 1 then
			self.currentImage = self.runningLeft1
	 elseif self.timer == 5 then
			self.currentImage = self.runningLeft2
	 elseif self.timer == 9 then
			self.currentImage = self.runningLeft3
	 elseif self.timer == 12 then
			self.timer = 0
	 end

end