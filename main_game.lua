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
	 end

	 if self.ninja.x == 585 then
			table.insert(self.enemies, Hunchback(1050, 457, LEFT))
	 end

	 if self.ninja.x == 581 then
			self.ninja:gotHurt()
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