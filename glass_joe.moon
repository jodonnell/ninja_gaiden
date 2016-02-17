import Sprite from require 'sprite'
import GlassJoeAnimations from require 'glass_joe_animations'

class GlassJoe extends Sprite
  new: =>
    @animations = GlassJoeAnimations!
    @rightPressed = false
    @x = 20

  draw: =>
    y = 0
    rotation = 0
    scaleX = 2
    scaleY = 2

    love.graphics.draw(@animations.image, @animations\currentQuad(), @x, y, rotation, scaleX, scaleY)

  update: (dt) =>
    @animations\update(dt)
    if @rightPressed
      @x += 1

{:GlassJoe}
