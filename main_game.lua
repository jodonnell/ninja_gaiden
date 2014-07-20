require 'class'
require 'ninja'
require 'hunchback'
require 'stage'
require 'explosion'
require 'powerup'
require 'constants'
require 'hud'

MainGame = class()

function MainGame:init()
end

function MainGame:load()
  self.score = 0
  self.ninja = Ninja()
  self.hud = HUD()
  self.enemies = {}
  self.explosions = {}
  self.powerups = {}
  self.stage = Stage(self.ninja)

  love.graphics.setNewFont("images/PressStart2P.ttf", 30)

end

function MainGame:draw()
  self:moveCamera()
  self.stage:draw()
  self.ninja:draw()

  for i, explosion in ipairs(self.explosions) do
    explosion:draw()
  end

  for i, powerup in ipairs(self.powerups) do
    powerup:draw()
  end

  for i, enemy in ipairs(self.enemies) do
    enemy:draw()
  end

  self.hud:draw(-(self:getCameraX()), self.score, self.ninja.lives, self.ninja.life)
end


function MainGame:update(dt)
  self.ninja:update(dt)

  self:updateExplosion(dt)

  for i, powerup in ipairs(self.powerups) do
    powerup:update(dt)
  end

  self:checkForBreakingItemBall()
  self:updateEnemies(dt)

  self.stage:update(dt, self.enemies)

  if self.ninja:hasLostLife() then
    self.ninja:lostLife()
    self.enemies = {}
  end

end

function MainGame:updateExplosion(dt)
  for i, explosion in ipairs(self.explosions) do
    explosion:update(dt)
    if explosion:isExplosionFinished() then
      table.remove(self.explosions, i)
    end
  end
end

function MainGame:updateEnemies(dt)
  for i, enemy in ipairs(self.enemies) do
    enemy:update(dt, {ninja=self.ninja})
    
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
end

function MainGame:checkForBreakingItemBall()
  if self.ninja.isAttacking == false then
    return
  end

  for i, itemBall in ipairs(self.stage.itemBalls) do
    local collision = self:checkCollisionsBetweenSwordAndSprite(itemBall)
    if collision then
      table.insert(self.powerups, Powerup(itemBall.x, itemBall.y, self.stage.rects))
      table.remove(self.stage.itemBalls, i)
    end
  end
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
