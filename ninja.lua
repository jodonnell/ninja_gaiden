require 'class'
require 'ninja_animations'

Ninja = class()

function Ninja:init()
	 self.animations = NinjaAnimations(self);

	 self.x = 105
	 self.y = 150

	 self.rightPressed = false
	 self.leftPressed = false
	 self.downPressed = false
	 self.jumpPressed = false
	 self.attackPressed = false

	 self.jumping = false

	 self.timer = 0
end

function Ninja:update(moveNinjaRight, moveNinjaLeft)
	 self:move(moveNinjaRight, moveNinjaLeft)

	 self.animations:changeAnimation()

	 if self:isFalling() then
			self:fall()
	 elseif self.jumpPressed then
			self.jumpPressed = false
			self.jumping = true
			self.timer = 0
			self.animations:jump()
	 elseif self.attackPressed then
			self.animations:attack()
	 elseif not (self.leftPressed or self.rightPressed or self.jumping) then
			if self.downPressed then
				 self.animations:duck()
			else
				 self.animations:stand()
			end
	 end

	 if self.jumping then
			self:jump()
	 end

end

function Ninja:isFalling()
	 return self.y < 450 and self.jumping == false
end

function Ninja:getCurrentImage()
	 return self.animations:getCurrentImage()
end

function Ninja:fall()
	 self.y = self.y + 10
	 self.animations:fall()
end

function Ninja:jump()
	 self.timer = self.timer + 1

	 if self.timer <= 8 then
			self.y = self.y - 8
	 elseif self.timer <= 13 then
			self.y = self.y - 6
	 elseif self.timer <= 17 then
			self.y = self.y - 4
	 elseif self.timer <= 21 then
			self.y = self.y - 2
	 elseif self.timer <= 30 then
	 else
			self.timer = 0
			self.jumping = false
	 end
end

function Ninja:move(moveNinjaRight, moveNinjaLeft)
	 if self:isMovingRight() then
			self:moveRight(moveNinjaRight)
	 elseif self:isMovingLeft() then
			self:moveLeft(moveNinjaLeft)
	 end
end

function Ninja:isMovingRight()
	 return self.rightPressed and (self.attackPressed == false or (self:isAttacking() and (self:isFalling() or self:isJumping())))
end

function Ninja:isMovingLeft()
	 return self.leftPressed and self.attackPressed == false
end

function Ninja:moveRight(moveNinjaRight)
	 if moveNinjaRight then
			self.x = self.x + 4
	 end

	 self.animations:runRight()
end

function Ninja:moveLeft(moveNinjaLeft)
	 if moveNinjaLeft then
			self.x = self.x - 4
	 end

	 self.animations:runLeft()
end

function Ninja:isAttacking()
	 return self.attackPressed
end

function Ninja:isJumping()
	 return self.jumping
end

function Ninja:draw()
	 love.graphics.draw(self:getCurrentImage(), self.x, self.y)
end