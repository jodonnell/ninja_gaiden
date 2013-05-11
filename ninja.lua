require 'class'
require 'ninja_animations'

Ninja = class()

RIGHT = 0
LEFT = 1

function Ninja:init()
	 self.animations = NinjaAnimations(self);

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

	 self.animations:changeAnimation()

	 if self.y < 450 and self.jumping == false then
			self.y = self.y + 10
			self.animations:fall()
			self:stand()
	 elseif self.jumpPressed then
			self.jumpPressed = false
			self.jumping = true
			self.timer = 0
			self.animations:jump()
	 elseif not (self.leftPressed or self.rightPressed or self.jumping) then
			if self.downPressed then
				 if not self.wasDucking then
						self.y = self.y + 20
						self.wasDucking = true
				 end

				 self.animations:duck()
			else
				 self:stand()
				 self.animations:stand()
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
	 return self.animations:getCurrentImage()
end

function Ninja:jump()
	 self.timer = self.timer + 1

	 if self.timer <= 8 then
			self.y = self.y - 8
	 elseif self.timer <= 13 then
			self.y = self.y - 6
	 elseif self.timer <= 17 then
			self.y = self.y - 4
	 elseif self.timer <= 21 then
			self.y = self.y - 2
	 elseif self.timer <= 30 then
	 else
			self.timer = 0
			self.jumping = false
	 end
end

function Ninja:moveRight(moveNinjaRight)
	 if moveNinjaRight then
			self.x = self.x + 4
	 end

	 if self.jumping == false then
			self.animations:runRight()
	 end

	 self.direction = RIGHT
end

function Ninja:moveLeft(moveNinjaLeft)
	 if moveNinjaLeft then
			self.x = self.x - 4
	 end

	 if self.jumping == false then
			self.animations:runLeft()
	 end
	 self.direction = LEFT
end