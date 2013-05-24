require 'class'

Rect = class()

function Rect:init(left, top, right, bottom)
	 self.left = left
	 self.top = top
	 self.right = right
	 self.bottom = bottom
end

function Rect:left()
	 return self.left
end

function Rect:right()
	 return self.right
end

function Rect:bottom()
	 return self.bottom
end

function Rect:top()
	 return self.top
end

function Rect:width()
	 return self.right - self.left
end

function Rect:height()
	 return self.bottom - self.top
end
