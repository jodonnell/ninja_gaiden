require 'class'
require 'sprite'
require 'images'

ItemBall = class(Sprite)

function ItemBall:init(x, y)
  self.x = x
  self.y = y

  self.images = { 
    itemBall1 = images.images['itemBall1'],
    itemBall2 = images.images['itemBall2'],
    itemBall3 = images.images['itemBall3'],
    itemBall4 = images.images['itemBall4']
  }

  self.currentImage = self.images['itemBall1']
  self.timer = 0
end

function ItemBall:draw()
  local image = self:getCurrentImage()
  love.graphics.draw(image, self.x, self.y)
end

function ItemBall:update(dt)
  self.timer = self.timer + dt
  if self.timer < 0.1 then
    self.currentImage = self.images['itemBall2']
  elseif self.timer < 0.2 then
    self.currentImage = self.images['itemBall3']
  elseif self.timer < 0.7 then
    self.currentImage = self.images['itemBall4']
  elseif self.timer < 0.8 then
    self.currentImage = self.images['itemBall1']
  else
    self.timer = 0
  end
end

function ItemBall:getBoundingBox()
  return self.x + 30, self.y, self:getWidth() - 35, self:getHeight()
end
