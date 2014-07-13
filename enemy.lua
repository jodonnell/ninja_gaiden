require 'class'
require 'sprite'

Enemy = class(Sprite)

function Enemy:setup(x, y, direction, id)
	 self.x = x
	 self.y = y
	 self.id = id
	 self.direction = direction
   self.timer = 0
end

function Enemy:draw()
	 local image = self:getCurrentImage()
	 local imageWidth = image:getWidth()
	 if self.direction == LEFT then
			love.graphics.draw(image, self.x + imageWidth, self.y, 0, -1, 1)
	 else
			love.graphics.draw(image, self.x, self.y)
	 end
end
