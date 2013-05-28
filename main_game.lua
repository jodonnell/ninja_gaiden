require 'class'
require 'ninja'
require 'hunchback'
require 'stage'
require 'explosion'
require 'constants'

MainGame = class()

function MainGame:init()
end

function MainGame:load()
	 self.score = 0
	 self.ninja = Ninja()
	 self.enemies = {}
	 self.explosions = {}
	 self.stage = Stage(self.ninja, self.enemies)

	 love.graphics.setNewFont("images/PressStart2P.ttf", 30)
end

function MainGame:draw()
	 self:moveCamera()
	 self.stage:draw()
	 self.ninja:draw()

	 for i, explosion in ipairs(self.explosions) do
			explosion:draw()
	 end

	 for i, enemy in ipairs(self.enemies) do
			enemy:draw()
	 end

	 self:drawHUD()
end

function MainGame:drawHUD()
	 local xPos = -(self:getCameraX())
	 local firstColumnX = xPos + 100
	 local secondColumnX = xPos + 400
	 local thirdColumnX = xPos + 800
	 love.graphics.print("SCORE: "..self.score, firstColumnX, 10)
	 love.graphics.print("STAGE: 1.1", secondColumnX, 10)
	 love.graphics.print("P: 2", thirdColumnX, 10)

	 love.graphics.print("TIMER: "..0, firstColumnX, 50)
	 love.graphics.print("NINJA: ", secondColumnX, 50)

	 self:drawLifeBars(secondColumnX + 190)

	 love.graphics.print("MAGIC: "..0, firstColumnX, 90)
	 love.graphics.print("ENEMY: "..0, secondColumnX, 90)

	 love.graphics.print(love.timer.getFPS(), xPos, 10)
end

function MainGame:update()
	 self.ninja:update()

	 for i, explosion in ipairs(self.explosions) do
			explosion:update()
			if explosion:isExplosionFinished() then
				 table.remove(self.explosions, i)
			end
	 end

	 for i, enemy in ipairs(self.enemies) do
			enemy:update()
			
			if not self.ninja.isInvincible then
				 local collision = self:checkCollisionsBetweenSprites(self.ninja, enemy)
				 if collision then
						self.ninja:gotHurt(self:collidedBounceLeft(enemy))
				 end
			end

			if self.ninja.isAttacking then
				 local collision = self:checkCollisionsBetweenSwordAndSprite(enemy)
				 if collision then
						table.insert(self.explosions, Explosion(enemy.x, enemy.y))
						table.remove(self.enemies, i)
				 end
				 
			end
	 end

	 self.stage:update()
end

function MainGame:moveCamera()
	 love.graphics.translate(self:getCameraX(), 0)
end

function MainGame:getCameraX()
	 local middleOfScreen = love.graphics.getWidth() / 2
	 local x = 0
	 if self.ninja.x > self.stage.endOfStageX - middleOfScreen then
			x = -(self.stage.endOfStageX - middleOfScreen * 2)
	 elseif self.ninja.x > middleOfScreen then
			x = -self.ninja.x + middleOfScreen
	 end
	 return x
end

function MainGame:checkCollisionsBetweenSwordAndSprite(obj2)
	 local ax, ay, aw, ah = self.ninja:getSwordBoundingBox()
	 local bx, by, bw, bh = obj2:getBoundingBox()
	 return self:checkCollision(ax, ay, aw, ah, bx, by, bw, bh)
end

function MainGame:checkCollisionsBetweenSprites(obj1, obj2)
	 local ax, ay, aw, ah = obj1:getBoundingBox()
	 local bx, by, bw, bh = obj2:getBoundingBox()
	 return self:checkCollision(ax, ay, aw, ah, bx, by, bw, bh)
end

function MainGame:checkCollision(ax1, ay1, aw, ah, bx1, by1, bw, bh)
	 local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
	 return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

function MainGame:collidedBounceLeft(enemy)
	 local ax, ay, aw, ah = self.ninja:getBoundingBox()
	 local bx, by, bw, bh = enemy:getBoundingBox()
	 if ax + aw / 2 > bx + bw / 2 then
			return true
	 end
	 return false
end

function MainGame:drawLifeBars(startingX)
	 love.graphics.setColor( 255, 100, 100 )

	 for i = 0, NINJA_MAX_LIFE - 1 do
			local barX = startingX + (i * 14)
			local fillMode = 'line'
			if self.ninja.life > i then 
				 fillMode = 'fill'
			end
			love.graphics.rectangle(fillMode, barX, 45, 10, 25 )
	 end
	 love.graphics.setColor( 255, 255, 255 )

end