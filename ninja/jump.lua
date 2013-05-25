require 'class'

Jump = class()

function Jump:init(ninja, startTimer)
	 self.timer = startTimer
	 self.ninja = ninja
end

function Jump:update()
	 self.timer = self.timer + 1

	 if self.timer <= 9 then
			self.ninja.y = self.ninja.y - 8
	 elseif self.timer <= 13 then
			self.ninja.y = self.ninja.y - 6
	 elseif self.timer <= 17 then
			self.ninja.y = self.ninja.y - 4
	 elseif self.timer <= 21 then
			self.ninja.y = self.ninja.y - 2
	 elseif self.timer <= 30 then
	 else
			self.ninja.jumpPressed = false
			self.ninja.animations:fall()
			return
	 end

	 self.ninja.animations:jump()
end