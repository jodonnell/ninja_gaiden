require 'class'
require 'constants'

HUD = class()

function HUD:init()
end

function HUD:draw(xPos, score, lives, life)
  local firstColumnX = xPos + 100
  local secondColumnX = xPos + 400
  local thirdColumnX = xPos + 800
  love.graphics.print("SCORE: "..score, firstColumnX, 10)
  love.graphics.print("STAGE: 1.1", secondColumnX, 10)
  love.graphics.print("P: " .. lives, thirdColumnX, 10)

  love.graphics.print("TIMER: "..0, firstColumnX, 50)
  love.graphics.print("NINJA: ", secondColumnX, 50)

  self:drawLifeBars(secondColumnX + 190, 45, life)

  love.graphics.print("MAGIC: "..0, firstColumnX, 90)
  love.graphics.print("ENEMY: ", secondColumnX, 90)
  self:drawLifeBars(secondColumnX + 190, 85, life)

  love.graphics.print(love.timer.getFPS(), xPos, 10)
end

function HUD:drawLifeBars(startingX, y, life)
  love.graphics.setColor( 255, 100, 100 )

  for i = 0, NINJA_MAX_LIFE - 1 do
    local barX = startingX + (i * 14)
    local fillMode = 'line'
    if life > i then 
      fillMode = 'fill'
    end
    love.graphics.rectangle(fillMode, barX, y, 10, 25 )
  end
  love.graphics.setColor( 255, 255, 255 )

end
