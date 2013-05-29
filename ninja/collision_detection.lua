require 'class'
require 'constants'

CollisionDetection = class()

function CollisionDetection:init(ninja, rects)
	 self.ninja = ninja
	 self.rects = rects
end

function CollisionDetection:isBottomColliding(dt)
	 
	 for i, climbableRect in ipairs(self.rects) do
			local inBoundsX = self.ninja.x > climbableRect:left() and self.ninja.x < climbableRect:right()

			if inBoundsX and self.ninja.y >= climbableRect:top() and self.ninja.lastY <= climbableRect:top() then
				 self.ninja:setY(climbableRect:top())
				 self.ninja.lastY = climbableRect:top()
				 return true
			end
	 end
	 
	 return false
end

function CollisionDetection:isLeftColliding()
	 for i, climbableRect in ipairs(self.rects) do
			local inBoundsY = self.ninja.y > climbableRect:top() and self.ninja.y < climbableRect:bottom()
		
			if inBoundsY and self.ninja.x <= climbableRect:right() and self.ninja.lastX >= climbableRect:right() then
				 self.attachedToRect = climbableRect
				 self.ninja.x = climbableRect:right()
				 return true
			end
	 end
	 
	 return false
end

function CollisionDetection:isRightColliding()
	 for i, climbableRect in ipairs(self.rects) do
			local inBoundsY = self.ninja.y > climbableRect:top() and self.ninja.y < climbableRect:bottom()
		
			if inBoundsY and self.ninja.x >= climbableRect:left() and self.ninja.lastX <= climbableRect:left() then
				 self.ninja.x = climbableRect:left()
				 self.attachedToRect = climbableRect
				 return true
			end
	 end
	 
	 return false
end

function CollisionDetection:isAtTop()
	 if self.ninja.y <= self.attachedToRect:top() then
			self.ninja.y = self.attachedToRect:top()
	 end
end

function CollisionDetection:isAtBottom()
	 if self.ninja.y >= self.attachedToRect:bottom() then
			self.ninja.isClimbing = false
	 end
end
