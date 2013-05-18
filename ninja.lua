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
	 
	 if self.jumpPressed then
			self:jump()
	 end

	 if self.isAttacking then
			self:attack()
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
	 return self.rightPressed and (self.isAttacking == false or (self:isJumping() or self:isFalling()))
end

function Ninja:isAttackingFromGround()
	 return self.isAttacking == true and self.y == 450
end

function Ninja:isMovingLeft()
	 return self.leftPressed and (self.isAttacking == false or (self:isJumping() or self:isFalling()))
end

function Ninja:moveRight()
	 self.x = self.x + 4
	 self.animations:runRight()
end

function Ninja:moveLeft()
	 self.x = self.x - 4
	 self.animations:runLeft()
end

function Ninja:isAttacking()
	 return self.isAttacking
end

function Ninja:isJumping()
	 return self.jumpPressed
end

function Ninja:draw()
	 local image = self:getCurrentImage()

	 local x = self.x
	 local y = self.y
	 local rotation = 0
	 local scaleX = 1
	 local scaleY = 1

	 if self.animations.direction == LEFT then
			local imageWidth = image:getWidth()
			x = self.x + imageWidth - self:getOffset(imageWidth)
			scaleX = -1
	 end

	 love.graphics.draw(image, x, y, rotation, scaleX, scaleY)
end

function Ninja:getOffset(imageWidth)
	 local offset = 0
	 if imageWidth > self.animations.normalWidth then
			offset = imageWidth - self.animations.normalWidth
	 end
	 return offset
end