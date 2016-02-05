require 'class'
require 'constants'
require 'sprite'

Ninja = class(Sprite)

function Ninja:init()
end

function Ninja:draw()
  local image = love.graphics.newImage("images/ninja/ryu_stand.png")

  local x = 0
  local y = 0
  local rotation = 0
  local scaleX = 1
  local scaleY = 1

  love.graphics.draw(image, x, y, rotation, scaleX, scaleY)
end

function Ninja:update()
end
