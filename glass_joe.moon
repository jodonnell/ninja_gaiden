import Sprite from require 'sprite'
import GlassJoeAnimations from require 'glass_joe_animations'

class GlassJoe extends Sprite
  new: =>
    @animations = GlassJoeAnimations!
    @animations\addObserver(self)
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
      @animations\setHitUpper()

  animationEnded: =>
    if @animations\currentName() == 'hitUpper'
      @animations\setBlockingDown()


{:GlassJoe}
