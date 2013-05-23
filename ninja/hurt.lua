require 'class'

Hurt = class()

function Hurt:init(ninja, bouncesRight)
	 self.timer = 0
	 self.ninja = ninja
	 self.bouncesRight = bouncesRight
end

function Hurt:update()
	 self.timer = self.timer + 1

	 if self.timer <= 5 then
			self.ninja.y = self.ninja.y - 6
	 elseif self.timer <= 10 then
			self.ninja.y = self.ninja.y - 4
	 elseif self.timer <= 15 then
			self.ninja.y = self.ninja.y - 2
	 elseif self.timer <= 20 then

	 elseif self.ninja.y > 450 then
			self.ninja.isHurt = false
			return
	 elseif self.timer <= 25 then
			self.ninja.y = self.ninja.y + 2
	 elseif self.timer <= 30 then
			self.ninja.y = self.ninja.y + 4
	 elseif self.timer <= 35 then
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