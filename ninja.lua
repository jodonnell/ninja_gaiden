require 'class'
require 'ninja_animations'

Ninja = class()

function Ninja:init()
	 self.animations = NinjaAnimations(self);

	 self.x = 105
	 self.y = 150

	 self.rightPressed = false
	 self.leftPressed = false
	 self.downPressed = false
	 self.jumpPressed = false
	 self.isAttacking = false

	 self.timer = 0
end

function Ninja:update()
	 self:move()

	 self.animations:changeAnimation()

	 if self:isFalling() then
			self:fall()
	 end
	 
	 if self.isAttacking then
			self:attack()
	 end

	 if self.jumpPressed then
			self:jump()
	 end

	 if self:isDucking() then
			self:duck()
	 end

	 if self:standing() then
			self:stand()
	 end
end

function Ninja:isDucking()
	 return self.downPressed and self:canDuck()
end

function Ninja:standing()
	 return not (self.leftPressed or self.rightPressed or self:isJumping() or self:isDucking() or self:isFalling())
end

function Ninja:canDuck()
	 return not (self.leftPressed or self.rightPressed or self:isJumping())
end

function Ninja:duck()
	 self.animations:duck()
end

function Ninja:stand()
	 self.animations:stand()
end

function Ninja:attack()
	 self.animations:attack()
end

function Ninja:isFalling()
	 return self.y < 450 and self.jumpPressed == false
end

function Ninja:getCurrentImage()
	 return self.animations:getCurrentImage()
end

function Ninja:fall()
	 self.y = self.y + 10
	 self.animations:fall()
end

function Ninja:jump()
	 self.animations:jump()

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
			self.jumpPressed = false
	 end
end

function Ninja:move()
	 if self:isMovingRight() then
			self:moveRight()
	 elseif self:isMovingLeft() then
			self:moveLeft()
	 end
end

function Ninja:isMovingRight()
	 return self.rightPressed and self.isAttacking == false
end

function Ninja:isMovingLeft()
	 return self.leftPressed and self.isAttacking == false
end

function Ninja:moveRight()
	 self.animations:runRight()
end

function Ninja:moveLeft()
	 self.animations:runLeft()
end

function Ninja:isAttacking()
	 return self.isAttacking
end

function Ninja:isJumping()
	 return self.jumpPressed
end

function Ninja:draw()
	 love.graphics.draw(self:getCurrentImage(), self.x, self.y)
end