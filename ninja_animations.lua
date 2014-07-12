require 'class'
require 'constants'

NinjaAnimations = class()

function NinjaAnimations:init(ninja)
	 self.timer = 0;
	 self.currentImage = 'standing';
	 self.direction = RIGHT;
	 self.ninja = ninja

	 self.images = { standing = love.graphics.newImage("images/ninja/ryu_stand.png"),
									 running1 = love.graphics.newImage("images/ninja/ryu_running_1.png"),
									 running2 = love.graphics.newImage("images/ninja/ryu_running_2.png"),
									 running3 = love.graphics.newImage("images/ninja/ryu_running_3.png"),
									 ducking = love.graphics.newImage("images/ninja/ryu_ducking.png"),
									 jumping1 = love.graphics.newImage("images/ninja/ryu_right_jump.png"),
									 jumping2 = love.graphics.newImage("images/ninja/ryu_down_jump.png"),
									 jumping3 = love.graphics.newImage("images/ninja/ryu_left_jump.png"),
									 jumping4 = love.graphics.newImage("images/ninja/ryu_up_jump.png"),
									 attacking1 = love.graphics.newImage("images/ninja/ryu_attack_begin.png"),
									 attacking2 = love.graphics.newImage("images/ninja/ryu_attack_middle.png"),
									 attacking3 = love.graphics.newImage("images/ninja/ryu_attack_end.png"),
									 falling = love.graphics.newImage("images/ninja/ryu_falling_attack_begin.png"),
									 fallingAttack1 = love.graphics.newImage("images/ninja/ryu_falling_attack_middle.png"),
									 fallingAttack2 = love.graphics.newImage("images/ninja/ryu_falling_attack_end.png"),
									 hurt = love.graphics.newImage("images/ninja/ryu_hurt.png"),
									 duckingAttack1 = love.graphics.newImage("images/ninja/ryu_ducking_attack_begin.png"),
									 duckingAttack2 = love.graphics.newImage("images/ninja/ryu_ducking_attack_middle.png"),
									 duckingAttack3 = love.graphics.newImage("images/ninja/ryu_ducking_attack_end.png"),
									 climbing1 = love.graphics.newImage("images/ninja/ryu_climb.png"),
									 climbing2 = love.graphics.newImage("images/ninja/ryu_climb_arms.png")
	 }
end

function NinjaAnimations:changeAnimation(dt)
	 self.timer = self.timer + dt

	 if self:isClimbing() then
			self:climbingAnimation()
	 elseif self:isAttacking() then
			self:attackingAnimation()
	 elseif self:isAttackFalling() then
			self:attackFallingAnimation()
	 elseif self:isAttackDucking() then
			self:attackDuckingAnimation()
	 elseif self:isMovingRight() or self:isMovingLeft() then
			self:runningAnimation()
	 elseif self:isJumping() then
			self:jumpingAnimation()
	 end
end

function NinjaAnimations:climbingAnimation()
	 if (self.ninja.upPressed or self.ninja.downPressed) and self.timer > 0.1 then
			if self.currentImage == 'climbing1' then
				 self.currentImage = 'climbing2'
			else
				 self.currentImage = 'climbing1'
			end
			self.timer = 0
	 end
end

function NinjaAnimations:attackFallingAnimation()
	 if self.timer < 0.1 then
	 		self.currentImage = 'fallingAttack1'
	 elseif self.timer < 0.2 then
	 		self.currentImage = 'fallingAttack2'
	 else
	 		self.ninja.isAttacking = false
			self.currentImage = '' -- to force fall not return early
			self:fall()
	 end
end

function NinjaAnimations:attackDuckingAnimation()
	 if self.timer < 0.06 then
	 		self.currentImage = 'duckingAttack1'
	 elseif self.timer < 0.12 then
	 		self.currentImage = 'duckingAttack2'
	 elseif self.timer < 0.24 then
			self.currentImage = 'duckingAttack3'
	 else
	 		self.ninja.isAttacking = false
			if self.ninja.rightPressed == false and self.ninja.leftPressed == false then
				 if self.ninja.downPressed then
						self.currentImage = 'ducking'
				 else
						self.currentImage = 'standing'
				 end
			end
	 end

end

function NinjaAnimations:attackingAnimation()
	 if self.timer < 0.06 then
			self.currentImage = 'attacking1'
	 elseif self.timer < 0.14 then
	 		self.currentImage = 'attacking2'
	 elseif self.timer < 0.22 then
	 		self.currentImage = 'attacking3'
	 elseif self.timer > 0.28 then
	 		self.ninja.isAttacking = false

			if self.ninja.rightPressed == false and self.ninja.leftPressed == false then
				 if self.ninja.downPressed then
						self.currentImage = 'ducking'
				 else
						self.currentImage = 'standing'
				 end
			end
	 end
end

function NinjaAnimations:runningAnimation()
	 if self.timer < 0.08 then
			self.currentImage = 'running1'
	 elseif self.timer < 0.16 then
			self.currentImage = 'running2'
	 elseif self.timer < 0.24 then
			self.currentImage = 'running3'
	 else
			self.timer = 0
	 end
end

function NinjaAnimations:jumpingAnimation()
	 if self.timer > 0.04 then
			if self.currentImage == 'jumping1' then
				 self.currentImage = 'jumping2'
			elseif self.currentImage == 'jumping2' then
				 self.currentImage = 'jumping3'
			elseif self.currentImage == 'jumping3' then
				 self.currentImage = 'jumping4'
			else
				 self.currentImage = 'jumping1'
			end
			self.timer = 0
	 end
end

function NinjaAnimations:isAttacking()
	 return self.currentImage == 'attacking1'
			or self.currentImage == 'attacking2'
			or self.currentImage == 'attacking3'
end

function NinjaAnimations:isClimbing()
	 return self.currentImage == 'climbing1' or self.currentImage == 'climbing2'
end

function NinjaAnimations:isFalling()
	 return self.currentImage == 'falling'
end

function NinjaAnimations:isAttackFalling()
	 return self.currentImage == 'fallingAttack1' or self.currentImage == 'fallingAttack2'
end

function NinjaAnimations:isAttackDucking()
	 return self.currentImage == 'duckingAttack1' or self.currentImage == 'duckingAttack2' or self.currentImage == 'duckingAttack3'
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

function NinjaAnimations:isCrouched()
	 return self:isDucking() or self:isAttackDucking()
end

function NinjaAnimations:isDucking()
	 return self.currentImage == 'ducking'
end

function NinjaAnimations:getCurrentImage()
	 return self.images[self.currentImage]
end

function NinjaAnimations:stand()
	 if self:isAttacking() then
			return
	 end

	 self.currentImage = 'standing'
end

function NinjaAnimations:fall()
	 if self:isFalling() or self:isAttackFalling() then
			return
	 end

	 self.currentImage = 'falling'
end

function NinjaAnimations:jump()
	 if self:isJumping() or self:isAttackFalling() then
			return
	 end

	 self.timer = 0
	 self.currentImage = 'jumping1'
end

function NinjaAnimations:attack()
	 if self:isAttacking() or self:isAttackFalling() or self:isAttackDucking() then
			return
	 end

	 if self:isFalling() or self:isJumping() then
			self.currentImage = 'fallingAttack1'
	 elseif self:isDucking() then
			self.currentImage = 'duckingAttack1'
	 else
			self.currentImage = 'attacking1'
	 end

	 self.timer = 0
end

function NinjaAnimations:duck()
	 if self:isAttackDucking() then
			return
	 end

	 self.currentImage = 'ducking'
end

function NinjaAnimations:climb()
	 self.currentImage = 'climbing1'
	 self.timer = 0
end

function NinjaAnimations:hurt()
	 self.currentImage = 'hurt'
end

function NinjaAnimations:runRight()
	 self.direction = RIGHT

	 if self:isMovingRight() or self:isJumping() or self:isAttackFalling() then
			return
	 end

	 self.currentImage = 'running1'
	 self.timer = 0
end

function NinjaAnimations:runLeft()
	 self.direction = LEFT

	 if self:isMovingLeft() or self:isJumping() or self:isAttackFalling() then
			return
	 end

	 self.currentImage = 'running1'
	 self.timer = 0
end
