require 'class'
require 'rect'

Stage = class()

function Stage:init(ninja)
	 self.image = love.graphics.newImage("images/first_stage.png")

	 self.screenScrollX = 0
	 self.endOfStageX = 2038
	 self.ninja = ninja
	 self:createClimbableRects()
	 self.ninja:setClimbableRects(self.rects)
end

function Stage:draw()
	 love.graphics.draw(self.image, -self.screenScrollX, 128)

	 -- for i, rect in ipairs(self.rects) do
	 -- 		love.graphics.rectangle("fill", rect:left(), rect:top(), rect:width(), rect:height() )
	 -- end
end

function Stage:update(enemies)
	 self:insertEnemyAt(enemies, 585, 457, 100, self.endOfStageX - 40)
	 self:insertEnemyAt(enemies, 720, 250, 1090, 1320)
	 self:insertEnemyAt(enemies, 1000, 457, 100, self.endOfStageX - 40)
	 self:insertEnemyAt(enemies, 1400, 457, 100, self.endOfStageX - 40)
	 self:insertEnemyAt(enemies, 1600, 457, 100, self.endOfStageX - 40)
end

function Stage:createClimbableRects()
	 self.rects = {}
	 self.rects[1] = Rect(0, 120, 81, 510)
	 self.rects[2] = Rect(86, 518, 509, 111)
	 self.rects[3] = Rect(716, 519, 214, 108)
end

function Stage:climbableRects()
	 return self.rects
end

function Stage:insertEnemyAt(enemies, xPos, yPos, leftBound, rightBound)
	 if self.ninja.x > xPos and self.ninja.x < xPos + 10 then
			for i, enemy in ipairs(enemies) do
				 if enemy.id == xPos then
						return false
				 end
			end
			table.insert(enemies, Hunchback(xPos + 465, yPos, LEFT, xPos, leftBound, rightBound))
	 end
end