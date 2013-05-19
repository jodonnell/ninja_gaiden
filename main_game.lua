require 'class'
require 'ninja'
require 'hunchback'
require 'stage'
require 'constants'

MainGame = class()

function MainGame:init()
end

function MainGame:load()
	 self.ninja = Ninja()
	 self.stage = Stage(self.ninja)
	 self.enemies = {}
end

function MainGame:draw()
	 self:moveCamera()
	 self.stage:draw()
	 self.ninja:draw()

	 for i, enemy in ipairs(self.enemies) do
			enemy:draw()
	 end

	 love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10)
end

function MainGame:update()
	 self.ninja:update()

	 for i, enemy in ipairs(self.enemies) do
			enemy:update()
			
			local collision = self:checkCollision(self.ninja, enemy)
			if collision then
				 self.ninja:gotHurt()
			end
	 end



	 if self.ninja.x == 585 then
			table.insert(self.enemies, Hunchback(1050, 457, LEFT))
	 end
end

function MainGame:moveCamera()
	 local middleOfScreen = love.graphics.getWidth() / 2

	 if self.ninja.x > self.stage.endOfStageX - middleOfScreen then
			love.graphics.translate(-(self.stage.endOfStageX - middleOfScreen * 2), 0)
	 elseif self.ninja.x > middleOfScreen then
			love.graphics.translate(-self.ninja.x + middleOfScreen, 0)
	 end
end

function MainGame:checkCollision(obj1, obj2)
	 local ax1, ay1, aw, ah = obj1:getBoundingBox()
	 local bx1, by1, bw, bh = obj2:getBoundingBox()
	 local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
	 return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end