require 'class'

Sprite = class()

function Sprite:getWidth()
  if os.getenv("LUA_TEST") then
    return 40
  else
    return self:getCurrentImage():getWidth()
  end
end

function Sprite:getHeight()
  if os.getenv("LUA_TEST") then
    return 30
  else
    return self:getCurrentImage():getHeight()
  end

end

function Sprite:getCurrentImage()
  return self.currentImage
end

function Sprite:getBoundingBox()
  return self.x, self.y, self:getWidth(), self:getHeight()
end
