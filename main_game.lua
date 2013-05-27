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

	 love.graphics.setNewFont("images/MEGAMAN10.ttf", 50)
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
	 local leftOffset = xPos + 100
	 love.graphics.print("SCORE - "..self.score, leftOffset, 10)
	 love.graphics.print("STAGE - 1 - 1", xPos + 500, 10)
	 love.graphics.print("P - "..0, xPos + 800, 10)

	 love.graphics.print("TIMER - "..0, leftOffset, 50)
	 love.graphics.print("NINJA - "..0, xPos + 500, 50)

	 love.graphics.print("MAGIC - "..0, leftOffset, 90)
	 love.graphics.print("ENEMY - "..0, xPos + 500, 90)

	 love.graphics.print(love.timer.getFPS(), xPos, 0)
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