require 'class'

Ninja = class()

RIGHT = 0
LEFT = 1

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

	 self.duckingLeft = love.graphics.newImage("images/ryu_ducking_left.png")
	 self.duckingRight = love.graphics.newImage("images/ryu_ducking_right.png")

	 self.jumpingRight1 = love.graphics.newImage("images/ryu_right_jump_right.png")
	 self.jumpingRight2 = love.graphics.newImage("images/ryu_down_jump_right.png")
	 self.jumpingRight3 = love.graphics.newImage("images/ryu_left_jump_right.png")
	 self.jumpingRight4 = love.graphics.newImage("images/ryu_up_jump_right.png")

	 self.currentImage = self.image
	 self.x = 105
	 self.y = 150

	 self.rightPressed = false
	 self.leftPressed = false
	 self.downPressed = false
	 self.jumpPressed = false

	 self.jumping = false

	 self.wasDucking = false

	 self.direction = 0

	 self.timer = 0
end

function Ninja:update(moveNinjaRight, moveNinjaLeft)
	 if self.rightPressed then
			self:stand()
			self:moveRight(moveNinjaRight)
	 elseif self.leftPressed then
			self:stand()
			self:moveLeft(moveNinjaLeft)
	 end

	 if self.y < 450 and self.jumping == false then
			self.y = self.y + 10
			self.currentImage = self.falling
			self:stand()
	 elseif self.currentImage == self.falling then
			self:stand()
			if self.direction == RIGHT then
				 self.currentImage = self.image
			else
				 self.currentImage = self.left
			end
	 elseif self.jumpPressed then
			self.jumpPressed = false
			self.jumping = true
			self.timer = 0
	 elseif not (self.leftPressed or self.rightPressed or self.jumping) then
			if self.downPressed then
				 if not self.wasDucking then
						self.y = self.y + 20
						self.wasDucking = true
				 end

				 self.currentImage = self.duckingRight
			elseif self.direction == RIGHT then
				 self:stand()
				 self.currentImage = self.image
			else
				 self:stand()
				 self.currentImage = self.left
			end
	 end

	 if self.jumping then
			self:jump()
	 end
end

function Ninja:stand()
	 if self.wasDucking then
			self.y = self.y - 20
	 end

	 self.wasDucking = false
end

function Ninja:getCurrentImage()
	 return self.currentImage
end

function Ninja:jump()
	 self.timer = self.timer + 1

	 if self.timer <= 5 then
			self.y = self.y - 10
	 elseif self.timer <= 10 then
			self.y = self.y - 8
	 elseif self.timer <= 14 then
			self.y = self.y - 6
	 elseif self.timer <= 18 then
			self.y = self.y - 3
	 elseif self.timer <= 24 then
	 else
			self.timer = 0
			self.jumping = false
	 end


	 if (self.timer % 3) == 0 then
			if self.currentImage == self.jumpingRight1 then
				 self.currentImage = self.jumpingRight2
			elseif self.currentImage == self.jumpingRight2 then
				 self.currentImage = self.jumpingRight3				 
			elseif self.currentImage == self.jumpingRight3 then
				 self.currentImage = self.jumpingRight4
			else
				 self.currentImage = self.jumpingRight1
			end
	 end
end

function Ninja:moveRight(moveNinjaRight)
	 if moveNinjaRight then
			self.x = self.x + 4
	 end

	 if self.jumping == false then
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

	 self.direction = RIGHT
end

function Ninja:moveLeft(moveNinjaLeft)
	 if moveNinjaLeft then
			self.x = self.x - 4
	 end

	 if self.jumping == false then
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
	 self.direction = LEFT
end