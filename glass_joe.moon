import Sprite from require 'sprite'
import GlassJoeAnimations from require 'glass_joe_animations'

class GlassJoe extends Sprite
  new: =>
    @animations = GlassJoeAnimations!
    @rightPressed = false
    @x = 120
    @y = 60

  draw: =>
    rotation = 0
    scaleX = 4
    scaleY = 4

    love.graphics.draw(@animations.image, @animations\currentQuad(), @x, @y, rotation, scaleX, scaleY)

  update: (dt) =>
    @animations\update(dt)
    if @rightPressed
      @x += 1

{:GlassJoe}
