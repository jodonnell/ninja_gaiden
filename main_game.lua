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
	 self.stage:draw()
	 self.ninja:draw()

	 for i, enemy in ipairs(self.enemies) do
			enemy:draw(self.stage.screenScrollX)
	 end

	 love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10)
end

function MainGame:update()
	 self.ninja:update()
	 self.stage:scrollScreen()

	 for i, enemy in ipairs(self.enemies) do
			enemy:update()
	 end

	 if self.stage.screenScrollX == 4 then
			table.insert(self.enemies, Hunchback(1050, 450, LEFT))
	 end
end
