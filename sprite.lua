require 'class'

Sprite = class()

function Sprite:getWidth()
	 return self:getCurrentImage():getWidth()
end

function Sprite:getHeight()
	 return self:getCurrentImage():getHeight()
end

function Sprite:getCurrentImage()
	 return self.currentImage
end

function Sprite:getBoundingBox()
	 return self.x, self.y, self:getWidth(), self:getHeight()
end