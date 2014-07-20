require 'class'

Rect = class()

function Rect:init(left, top, width, height)
  self.l = left
  self.t = top
  self.w = width
  self.h = height
end

function Rect:left()
  return self.l
end

function Rect:right()
  return self.l + self.w
end

function Rect:bottom()
  return self.t + self.h
end

function Rect:top()
  return self.t
end

function Rect:width()
  return self.w
end

function Rect:height()
  return self.h
end
