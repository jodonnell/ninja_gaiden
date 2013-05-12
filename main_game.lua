require 'class'
require 'ninja'
require 'stage'

MainGame = class()

function MainGame:init()
end

function MainGame:load()
	 self.ninja = Ninja()
	 self.stage = Stage(self.ninja)
end

function MainGame:draw()
	 self.stage:draw()
	 self.ninja:draw()
	 love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10)
end

function MainGame:update()
	 local moveNinjaRight, moveNinjaLeft = self.stage:scrollScreen()
	 self.ninja:update(moveNinjaRight, moveNinjaLeft)
end

function MainGame:pressRight()
	 self.ninja.rightPressed = true
end

function MainGame:releaseRight()
	 self.ninja.rightPressed = false
end

function MainGame:pressLeft()
	 self.ninja.leftPressed = true
end

function MainGame:releaseLeft()
	 self.ninja.leftPressed = false
end

function MainGame:pressDown()
	 self.ninja.downPressed = true
end

function MainGame:releaseDown()
	 self.ninja.downPressed = false
end

function MainGame:pressJump()
	 self.ninja.jumpPressed = true
end

function MainGame:pressAttack()
	 self.ninja.attackPressed = true
end
