require 'class'

Jump = class()

function Jump:init(ninja, startTimer)
  self.timer = startTimer
  self.ninja = ninja
end

function Jump:update(dt)
  self.timer = self.timer + dt

  if self.timer <= 0.22 then
    self.ninja:setY(self.ninja.y - (480 * dt))
  elseif self.timer <= 0.27 then
    self.ninja:setY(self.ninja.y - (360 * dt))
  elseif self.timer <= 0.32 then
    self.ninja:setY(self.ninja.y - (240 * dt))
  elseif self.timer <= 0.37 then
    self.ninja:setY(self.ninja.y - (120 * dt))
  elseif self.timer <= 0.47 then
  else
    self.ninja.jumpPressed = false
    self.ninja.animations:fall()
    return
  end

  self.ninja.animations:jump()
end
