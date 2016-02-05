require 'class'
require 'ninja'

MainGame = class()

function MainGame:init()
end

function MainGame:load()
  self.ninja = Ninja()
end

function MainGame:draw()
  self.ninja:draw()
end

function MainGame:update(dt)
  self.ninja:update(dt)
end
