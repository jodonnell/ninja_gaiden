require 'class'

Hurt = class()

function Hurt:init(ninja, bouncesRight)
	 self.timer = 0
	 self.ninja = ninja
	 self.bouncesRight = bouncesRight
end

function Hurt:update(dt)
	 self.timer = self.timer + dt

	 if self.timer <= 0.1 then
			self.ninja.y = self.ninja.y - (360 * dt)
	 elseif self.timer <= 0.16 then
			self.ninja.y = self.ninja.y - (240 * dt)
	 elseif self.timer <= 0.24 then
			self.ninja.y = self.ninja.y - (120 * dt)
	 elseif self.timer <= 0.44 then

	 elseif self.ninja.collisionDetection:isBottomColliding() then
			self.ninja.isHurt = false
			return
	 elseif self.timer <= 0.3 then
			self.ninja.y = self.ninja.y + (120 * dt)
	 elseif self.timer <= 0.36 then
			self.ninja.y = self.ninja.y + (240 * dt)
	 elseif self.timer <= 0.42 then
			self.ninja.y = self.ninja.y + (360 * dt)
	 else
			self.ninja.y = self.ninja.y + (NINJA_FALL_SPEED * dt)
	 end

	 if self.bouncesRight then
			self.ninja.x = self.ninja.x + (NINJA_MOVE_SPEED * dt)
	 else
			self.ninja.x = self.ninja.x - (NINJA_MOVE_SPEED * dt)
	 end

	 self.ninja.animations:hurt()
end