require 'class'

Rect = class()

function Rect:init(left, top, right, bottom)
	 self.l = left
	 self.t = top
	 self.r = right
	 self.b = bottom
end

function Rect:left()
	 return self.l
end

function Rect:right()
	 return self.r
end

function Rect:bottom()
	 return self.b
end

function Rect:top()
	 return self.t
end

function Rect:width()
	 return self.r - self.l
end

function Rect:height()
	 return self.b - self.t
end
