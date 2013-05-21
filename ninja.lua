require 'class'
require 'ninja_animations'
require 'sprite'

Ninja = class(Sprite)

function Ninja:init()
	 self.animations = NinjaAnimations(self)
	 self.normalWidth = self:getWidth()

	 self.x = 105
	 self.y = 150

	 self.rightPressed = false
	 self.leftPressed = false
	 self.downPressed = false
	 self.upPressed = false
	 self.jumpPressed = false
	 self.isAttacking = false
	 self.isHurt = false
	 self.isInvincible = false
	 self.bouncesRight = false
	 self.isClimbing = false

	 self.timer = 0
	 self.invincibilityTimer = 0
end

function Ninja:update()
	 self:move()

	 self.animations:changeAnimation()

	 if self.isInvincible then
			self.invincibilityTimer = self.invincibilityTimer + 1
			if self.invincibilityTimer > 80 then
				 self.isInvincible = false
			end
	 end

	 if self.isHurt then
			self:hurt()
	 end

	 if self.upPressed and self.isClimbing then
			self.y = self.y - 4
	 end

	 if self.downPressed and self.isClimbing then
			self.y = self.y + 4
	 end

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

	 if self:isStanding() then
			self:stand()
	 end
end

function Ninja:isDucking()
	 return self.downPressed and self:canDuck()
end

function Ninja:isStanding()
	 return not (self.leftPressed or self.rightPressed or self:isJumping() or self:isDucking() or self:isFalling() or self.isHurt or self.animations:isAttackDucking() or self.isClimbing)
end

function Ninja:canDuck()
	 return not (self.leftPressed or self.rightPressed or self:isJumping() or self.isHurt or self:isFalling() or self.animations:isAttacking() or self.isClimbing)
end

function Ninja:canJump()
	 if self.isClimbing then
			if self.animations.direction == LEFT then
				 return self.rightPressed
			else
				 return self.leftPressed
			end
	 end
	 return not (self:isFalling() or self.isHurt)
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

function Ninja:canAttack()
	 return not (self.isHurt or self.isClimbing)
end

function Ninja:isFalling()
	 return self.y < 450 and self.jumpPressed == false and self.isHurt == false and self.isClimbing == false
end

function Ninja:getCurrentImage()
	 return self.animations:getCurrentImage()
end

function Ninja:fall()
	 self.y = self.y + 12
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
	 return self.rightPressed and self.isHurt == false and self.isClimbing == false and (self.isAttacking == false or (self:isJumping() or self:isFalling()))
end

function Ninja:isAttackingFromGround()
	 return self.isAttacking == true and self.y == 450
end

function Ninja:isMovingLeft()
	 return self.leftPressed and self.isHurt == false and self.isClimbing == false and (self.isAttacking == false or (self:isJumping() or self:isFalling()))
end

function Ninja:moveRight()
	 self.x = self.x + 4
	 self.animations:runRight()
end

function Ninja:moveLeft()
	 self.x = self.x - 4
	 self.animations:runLeft()

	 if self.x < 80 then
			self.jumpPressed = false
			self.animations:climb()
			self.isClimbing = true
	 end

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

	 if self.animations:isCrouched() then
			y = y + 20
	 end

	 if not (self.isInvincible and (self.invincibilityTimer % 2) == 0) then
			love.graphics.draw(image, x, y, rotation, scaleX, scaleY)
	 end
end

function Ninja:getOffset(imageWidth)
	 local offset = 0
	 if imageWidth > self.normalWidth then
			offset = imageWidth - self.normalWidth
	 end
	 return offset
end

function Ninja:hurt()
	 self.timer = self.timer + 1

	 if self.timer <= 5 then
			self.y = self.y - 6
	 elseif self.timer <= 10 then
			self.y = self.y - 4
	 elseif self.timer <= 15 then
			self.y = self.y - 2
	 elseif self.timer <= 20 then

	 elseif self.y > 450 then
			self.timer = 0
			self.isHurt = false
			self.bouncesRight = false
			return
	 elseif self.timer <= 25 then
			self.y = self.y + 2
	 elseif self.timer <= 30 then
			self.y = self.y + 4
	 elseif self.timer <= 35 then
			self.y = self.y + 6
	 else
			self.y = self.y + 10
	 end

	 if self.bouncesRight then
			self.x = self.x + 4
	 else
			self.x = self.x - 4
	 end

	 self.animations:hurt()
end

function Ninja:startJumping()
	 self.jumpPressed = true
	 self.isClimbing = false
	 self.timer = 0
end

function Ninja:gotHurt(bouncesRight)
	 self.jumpPressed = false
	 self.isAttacking = false
	 self.isHurt = true
	 self.isInvincible = true
	 self.invincibilityTimer = 0
	 self.timer = 0
	 self.bouncesRight = bouncesRight
end

function Ninja:getSwordBoundingBox()
	 local x = self.x
	 if self.animations.direction == LEFT then
			x = x - self.normalWidth
	 else
			x = x + self.normalWidth
	 end
	 return x, self.y, self:getWidth(), self:getHeight()
end

function Ninja:getBoundingBox()
	 local width = self:getWidth()
	 local x = self.x
	 if self.isAttacking then
			if self.animations.direction == LEFT then
				 x = width - self.normalWidth
			end
			width = self.normalWidth
	 end
	 return x, self.y, width, self:getHeight()
end