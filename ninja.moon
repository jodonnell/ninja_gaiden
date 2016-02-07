import Sprite from require 'sprite'

class Ninja extends Sprite
  new: =>
    @rightPressed = false
    @x = 20

  draw: =>
    image = love.graphics.newImage("images/ninja/ryu_stand.png")
    y = 0
    rotation = 0
    scaleX = 1
    scaleY = 1
    love.graphics.draw(image, @x, y, rotation, scaleX, scaleY)

  update: =>
    if @rightPressed
      @x += 1

{:Ninja}
