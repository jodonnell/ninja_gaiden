require 'class'

Images = class()

function Images:init()
	 self.images = { 
			itemBall1 = love.graphics.newImage("images/item_ball1.png"),
			itemBall2 = love.graphics.newImage("images/item_ball2.png"),
			itemBall3 = love.graphics.newImage("images/item_ball3.png"),
			itemBall4 = love.graphics.newImage("images/item_ball4.png")
	 }
end

images = Images()