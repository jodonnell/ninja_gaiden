require 'class'
require 'enemy'

Bird = class(Enemy)

function Bird:init(x, y, direction, id)
  self:setup(x, y, direction, id)
  self.maxSpeed = 380
  self.speed = self.maxSpeed

  self.images = { 
    walk1 = love.graphics.newImage("images/bird_walk1.png"),
    walk2 = love.graphics.newImage("images/bird_walk2.png")
  }
  self.currentImage = self.images['walk1']
end

function Bird:update(dt, attributes)
  self:move(dt, attributes["ninja"])
  self:reverseDirection(attributes["ninja"])
  self:animate(dt)
end

function Bird:move(dt, ninja)
  if self.direction == LEFT then
    self.x = self.x - (self.speed * dt)
  else
    self.x = self.x + (self.speed * dt)
  end

  if ninja.y > self.y then
    self.y = self.y + 2
  else
    self.y = self.y - 2
  end
end

function Bird:reverseDirection(ninja)
  if self.x + 360 <= ninja.x and self.direction == LEFT then
    self.speed = self.speed - 10
    if self.speed <= 10 then
      self.direction = RIGHT
    end
  elseif self.x - 360 >= ninja.x and self.direction == RIGHT then
    self.speed = self.speed - 10
    if self.speed <= 10 then
      self.direction = LEFT
    end
  elseif self.speed < self.maxSpeed then
    self.speed = self.speed + 10
  end
end

function Bird:animate(dt)
  self.timer = self.timer + dt
  if self.timer < 0.1 then
    self.currentImage = self.images['walk2']
  elseif self.timer < 0.2 then
    self.currentImage = self.images['walk1']
  else
    self.timer = 0
  end
end

function Bird:getBoundingBox()
  return self.x + 30, self.y, self:getWidth() - 35, self:getHeight()
end
