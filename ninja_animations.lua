require 'class'

NinjaAnimations = class()

RIGHT = 0
LEFT = 1


function NinjaAnimations:init(ninja)
	 self.timer = 0;
	 self.currentImage = 'standing';
	 self.direction = RIGHT;
	 self.ninja = ninja
	 self.images = { standingRight = love.graphics.newImage("images/ryu_stand_right.png"),
									 standingLeft = love.graphics.newImage("images/ryu_stand_left.png"),
									 running1Left = love.graphics.newImage("images/ryu_running_1_left.png"),
									 running2Left = love.graphics.newImage("images/ryu_running_2_left.png"),
									 running3Left = love.graphics.newImage("images/ryu_running_3_left.png"),
									 running1Right = love.graphics.newImage("images/ryu_running_1_right.png"),
									 running2Right = love.graphics.newImage("images/ryu_running_2_right.png"),
									 running3Right = love.graphics.newImage("images/ryu_running_3_right.png"),
									 duckingLeft = love.graphics.newImage("images/ryu_ducking_left.png"),
									 duckingRight = love.graphics.newImage("images/ryu_ducking_right.png"),
									 fallingRight = love.graphics.newImage("images/ryu_falling_right.png"),
									 fallingLeft = love.graphics.newImage("images/ryu_falling_left.png"),
									 jumping1Right = love.graphics.newImage("images/ryu_right_jump_right.png"),
									 jumping2Right = love.graphics.newImage("images/ryu_down_jump_right.png"),
									 jumping3Right = love.graphics.newImage("images/ryu_left_jump_right.png"),
									 jumping4Right = love.graphics.newImage("images/ryu_up_jump_right.png"),
									 jumping1Left = love.graphics.newImage("images/ryu_right_jump_left.png"),
									 jumping2Left = love.graphics.newImage("images/ryu_down_jump_left.png"),
									 jumping3Left = love.graphics.newImage("images/ryu_left_jump_left.png"),
									 jumping4Left = love.graphics.newImage("images/ryu_up_jump_left.png")
	 }

end

function NinjaAnimations:duck()
	 self.currentImage = 'ducking'
end

function NinjaAnimations:runRight()
	 if self:isMovingRight() then
			return
	 end

	 self.currentImage = 'running1'
	 self.timer = 0
	 self.direction = RIGHT
end

function NinjaAnimations:runLeft()
	 if self:isMovingLeft() then
			return
	 end

	 self.currentImage = 'running1'
	 self.timer = 0
	 self.direction = LEFT
end

function NinjaAnimations:changeAnimation()
	 self.timer = self.timer + 1

	 if self:isMovingRight() or self:isMovingLeft() then
			self:runningAnimation()
	 elseif self:isJumping() then
			self:jumpingAnimation()
	 end

end

function NinjaAnimations:runningAnimation()
	 if self.timer == 1 then
			self.currentImage = 'running1'
	 elseif self.timer == 5 then
			self.currentImage = 'running2'
	 elseif self.timer == 9 then
			self.currentImage = 'running3'
	 elseif self.timer == 12 then
			self.timer = 0
	 end
end

function NinjaAnimations:jumpingAnimation()
	 if (self.timer % 3) == 0 then
			if self.currentImage == 'jumping1' then
				 self.currentImage = 'jumping2'
			elseif self.currentImage == 'jumping2' then
				 self.currentImage = 'jumping3'
			elseif self.currentImage == 'jumping3' then
				 self.currentImage = 'jumping4'
			else
				 self.currentImage = 'jumping1'
			end
	 end
end

function NinjaAnimations:isMovingRight()
	 return self.direction == RIGHT and (self.currentImage == 'running1' or 
																			 self.currentImage == 'running2' or
																			 self.currentImage == 'running3')
end

function NinjaAnimations:isJumping()
	 return self.currentImage == 'jumping1'
			or self.currentImage == 'jumping2'
			or self.currentImage == 'jumping3'
			or self.currentImage == 'jumping4'
end

function NinjaAnimations:isMovingLeft()
	 return self.direction == LEFT and (self.currentImage == 'running1' or 
																			self.currentImage == 'running2' or
																			self.currentImage == 'running3')
end

function NinjaAnimations:getCurrentImage()
	 local image = self.currentImage
	 if self.direction == LEFT then
			image = image .. 'Left'
	 else
			image = image .. 'Right'
	 end
	 return self.images[image]
end

function NinjaAnimations:stand()
	 self.currentImage = 'standing'
end

function NinjaAnimations:fall()
	 self.currentImage = 'falling'
end

function NinjaAnimations:jump()
	 self.timer = 0
	 self.currentImage = 'jumping1'
end