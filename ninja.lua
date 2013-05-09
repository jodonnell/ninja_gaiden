require 'class'

Ninja = class()

function Ninja:init()
	 self.image = love.graphics.newImage("images/ryu_stand_right.png")
	 self.x = 105
	 self.y = 150
end

function Ninja:update()
	 self.y = self.y + 10
end
