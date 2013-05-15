require 'class'
require 'ninja'
require 'hunchback'
require 'stage'

MainGame = class()

function MainGame:init()
end

function MainGame:load()
	 self.ninja = Ninja()
	 self.stage = Stage(self.ninja)
	 self.hunchback = Hunchback()
end

function MainGame:draw()
	 self.stage:draw()
	 self.ninja:draw()
	 self.hunchback:draw()
	 love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10)
end

function MainGame:update()
	 self.ninja:update()
	 self.stage:scrollScreen()
end
