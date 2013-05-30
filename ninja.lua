require 'class'
require 'constants'
require 'ninja_animations'
require 'sprite'
require 'utility'
require 'ninja/hurt'
require 'ninja/jump'
require 'ninja/collision_detection'

Ninja = class(Sprite)

function Ninja:init()
	 self.animations = NinjaAnimations(self)
	 self.normalWidth = self:getWidth()

	 self:setInitialStates()

	 self.life = NINJA_MAX_LIFE
	 self.lives = 2
end

function Ninja:setInitialStates()
	 self.x = 105
	 self:setY(150)

	 self.rightPressed = false
	 self.leftPressed = false
	 self.downPressed = false
	 self.upPressed = false
	 self.jumpPressed = false
	 self.isAttacking = false
	 self.isHurt = false
	 self.isInvincible = false
	 self.isClimbing = false

	 self.invincibilityTimer = 0
end

function Ninja:setClimbableRects(rects)
	 self.collisionDetection = CollisionDetection(self, rects)
end

function Ninja:update(dt)
	 self.dt = dt
	 self.lastX = self.x
	 self:move(dt)

	 self.animations:changeAnimation(self.dt)

	 if self.isInvincible then
			self.invincibilityTimer = self.invincibilityTimer + dt
			if self.invincibilityTimer > 1.2 then
				 self.isInvincible = false
			end
	 end

	 if self.isHurt then
			self.hurt:update(dt)
	 end

	 if self.upPressed and self.isClimbing then
			self:setY(self.y - (NINJA_CLIMB_SPEED * dt))
			self.collisionDetection:isAtTop()
	 end

	 if self.downPressed and self.isClimbing then
			self:setY(self.y + (NINJA_CLIMB_SPEED * dt))
			self.collisionDetection:isAtBottom()
	 end

	 if self:isFalling() then
			self:fall(dt)
	 end
	 
	 if self.jumpPressed then
			self.jump:update(dt)
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
	 return not (self:isFalling() or self.isHurt or self.jumpPressed)
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
	 return (not self.collisionDetection:isBottomColliding(self.dt)) and self.jumpPressed == false and self.isHurt == false and self.isClimbing == false
end

function Ninja:getCurrentImage()
	 return self.animations:getCurrentImage()
end

function Ninja:fall(dt)
	 self:setY(self.y + (NINJA_FALL_SPEED * dt))
	 self.animations:fall()
end

function Ninja:move(dt)
	 if self:isMovingRight() then
			self:moveRight(dt)
	 elseif self:isMovingLeft() then
			self:moveLeft(dt)
	 end
end

function Ninja:isMovingRight()
	 return self.rightPressed and self.isHurt == false and self.isClimbing == false and (self.isAttacking == false or (self:isJumping() or self:isFalling()))
end

function Ninja:isMovingLeft()
	 return self.leftPressed and self.isHurt == false and self.isClimbing == false and (self.isAttacking == false or (self:isJumping() or self:isFalling()))
end

function Ninja:moveRight(dt)
	 self.x = self.x + (NINJA_MOVE_SPEED * dt)
	 self.animations:runRight()

	 if self.collisionDetection:isRightColliding() then
			self:startClimbing()
	 end
end

function Ninja:moveLeft(dt)
	 self.x = self.x - (NINJA_MOVE_SPEED * dt)
	 self.animations:runLeft()

	 if self.collisionDetection:isLeftColliding() then
			self:startClimbing()
	 end
end

function Ninja:startClimbing()
	 self.jumpPressed = false
	 self.animations:climb()
	 self.isClimbing = true
	 self.isAttacking = false
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

	 local timer = round(self.invincibilityTimer, 1)
	 if not (self.isInvincible and (timer % 0.2) == 0) then
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

function Ninja:startJumping()
	 self.jumpPressed = true

	 local timer
	 if self.isClimbing then
			timer = 0.15
	 else
			timer = 0
	 end

	 self.jump = Jump(self, timer)

	 self.isClimbing = false
end

function Ninja:gotHurt(bouncesRight)
	 self.jumpPressed = false
	 self.isAttacking = false
	 self.isClimbing = false
	 self.isHurt = true
	 self.hurt = Hurt(self, bouncesRight)
	 self.isInvincible = true
	 self.invincibilityTimer = 0
	 self.bouncesRight = bouncesRight
	 self.life = self.life - 1
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

function Ninja:lostLife()
	 self.lives = self.lives - 1
	 self.life = NINJA_MAX_LIFE
	 self:setInitialStates()
end

function Ninja:hasLostLife()
	 return self.life == 0 or self.y > love.graphics.getHeight()
end

function Ninja:setY(y)
	 self.lastY = self.y
	 self.y = y
end