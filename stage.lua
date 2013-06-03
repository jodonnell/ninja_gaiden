require 'class'
require 'rect'
require 'item_ball'

Stage = class()

function Stage:init(ninja)
	 self.image = love.graphics.newImage("images/first_stage.png")

	 self.screenScrollX = 0
	 self.endOfStageX = 2038
	 self.ninja = ninja
	 self:createClimbableRects()
	 self.ninja:setClimbableRects(self.rects)
	 self.itemBalls = {ItemBall(300, 350)}
end

function Stage:draw()
	 love.graphics.draw(self.image, -self.screenScrollX, 128)

	 for i, itemBall in ipairs(self.itemBalls) do
			itemBall:draw()
	 end

	 -- for i, rect in ipairs(self.rects) do
	 -- 		love.graphics.rectangle("fill", rect:left(), rect:top(), rect:width(), rect:height() )
	 -- end
end

function Stage:update(dt, enemies)
	 for i, itemBall in ipairs(self.itemBalls) do
			itemBall:update(dt)
	 end

	 self:insertEnemyAt(enemies, 585, 457, 100, self.endOfStageX - 40)
	 self:insertEnemyAt(enemies, 720, 250, 1090, 1320)
	 self:insertEnemyAt(enemies, 1000, 457, 100, self.endOfStageX - 40)
	 self:insertEnemyAt(enemies, 1400, 457, 100, self.endOfStageX - 40)
	 self:insertEnemyAt(enemies, 1600, 457, 100, self.endOfStageX - 40)
end

function Stage:createClimbableRects()
	 self.rects = {}
	 self.rects[1] = Rect(1, 121, 80, 506)
	 self.rects[2] = Rect(932, 238, 80, 204)
	 self.rects[3] = Rect(1111, 322, 240, 122)
	 self.rects[4] = Rect(714, 531, 821, 97)
	 self.rects[5] = Rect(87, 533, 508, 92)
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