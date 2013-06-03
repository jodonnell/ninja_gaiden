require 'class'
require 'sprite'
require 'images'

Powerup = class(Sprite)

function Powerup:init(x, y, rects)
	 self.x = x
	 self.y = y
	 self.lastY = y

	 self.currentImage = images.images['powerup']
	 self.rects = rects
end

function Powerup:draw()
	 local image = self:getCurrentImage()
	 love.graphics.draw(image, self.x, self.y)
end

function Powerup:update(dt)
	 if (not self:isBottomColliding()) then
			self:setY(self.y + (NINJA_FALL_SPEED * dt))
	 end
end

function Powerup:getBoundingBox()
	 return self.x + 30, self.y, self:getWidth() - 35, self:getHeight()
end

function Powerup:setY(y)
	 self.lastY = self.y
	 self.y = y
end

function Powerup:rightSide()
	 return self.x + 43
end

function Powerup:bottom()
	 return self.y + 43
end

function Powerup:lastYBottom()
	 return self.lastY + 43
end

function Powerup:isBottomColliding()
	 
	 for i, climbableRect in ipairs(self.rects) do
			local inBoundsX = self:rightSide() > climbableRect:left() and self.x < climbableRect:right()
			if inBoundsX and self:bottom() >= climbableRect:top() and self:lastYBottom() <= climbableRect:top() then
				 local y = climbableRect:top() - 43
				 self:setY(y)
				 self.lastY = y
				 return true
			end
	 end
	 
	 return false
end
