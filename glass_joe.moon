import Sprite from require 'sprite'
import GlassJoeAnimations from require 'glass_joe_animations'

class GlassJoe extends Sprite
  new: =>
    @animations = GlassJoeAnimations!
    @animations\addObserver(self)
    @hitRight = false
    @hitLeft = false
    @flipped = false
    @x = 120
    @y = 60

  draw: =>
    rotation = 0
    scaleX = 4
    scaleY = 4
    offsetX = 0
    offsetY = 0
    if @flipped
      scaleX *= -1
      offsetX = @animations\currentWidth()

    love.graphics.draw(@animations.image, @animations\currentQuad(), @x, @y, rotation, scaleX, scaleY, offsetX, offsetY)

  update: (dt) =>
    @animations\update(dt)
    if @hitRight
      @animations\setHitUpper()
      @flipped = false

    if @hitLeft
      @animations\setHitUpper()
      @flipped = true

  animationEnded: =>
    if @animations\currentName() == 'hitUpper'
      @animations\setBlockingDown()


{:GlassJoe}
