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
			self.ninja.y = self.ninja.y - 6
	 elseif self.timer <= 0.2 then
			self.ninja.y = self.ninja.y - 4
	 elseif self.timer <= 0.3 then
			self.ninja.y = self.ninja.y - 2
	 elseif self.timer <= 0.4 then

	 elseif self.ninja.collisionDetection:isBottomColliding() then
			self.ninja.isHurt = false
			return
	 elseif self.timer <= 0.5 then
			self.ninja.y = self.ninja.y + 2
	 elseif self.timer <= 0.6 then
			self.ninja.y = self.ninja.y + 4
	 elseif self.timer <= 0.7 then
			self.ninja.y = self.ninja.y + 6
	 else
			self.ninja.y = self.ninja.y + 10
	 end

	 if self.bouncesRight then
			self.ninja.x = self.ninja.x + 4
	 else
			self.ninja.x = self.ninja.x - 4
	 end

	 self.ninja.animations:hurt()
end