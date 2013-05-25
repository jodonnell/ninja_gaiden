require 'class'
require 'constants'

CollisionDetection = class()

function CollisionDetection:init(ninja, rects)
	 self.ninja = ninja
	 self.rects = rects
end

function CollisionDetection:isBottomColliding()
	 
	 for i, climbableRect in ipairs(self.rects) do
			local inBoundsX = self.ninja.x > climbableRect:left() and self.ninja.x < climbableRect:right()
			if inBoundsX and self.ninja.y >= climbableRect:top() and self.ninja.y - NINJA_FALL_SPEED <= climbableRect:top() then
				 self.ninja.y = climbableRect:top()
				 return true
			end
	 end
	 
	 return false
end

function CollisionDetection:isLeftColliding()
	 for i, climbableRect in ipairs(self.rects) do
			local inBoundsY = self.ninja.y > climbableRect:top() and self.ninja.y < climbableRect:bottom()
		
			if inBoundsY and self.ninja.x <= climbableRect:right() and self.ninja.x + 4 >= climbableRect:right() then
				 self.ninja.x = climbableRect:right()
				 return true
			end
	 end
	 
	 return false
end

function CollisionDetection:isRightColliding()
	 for i, climbableRect in ipairs(self.rects) do
			local inBoundsY = self.ninja.y > climbableRect:top() and self.ninja.y < climbableRect:bottom()
		
			if inBoundsY and self.ninja.x >= climbableRect:left() and self.ninja.x - 4 <= climbableRect:left() then
				 self.ninja.x = climbableRect:left()
				 return true
			end
	 end
	 
	 return false
end
