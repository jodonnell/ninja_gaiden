import Sprite from require 'src.sprite'
import GlassJoeAnimations from require 'src.opponents.animations.glass_joe_animations'

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
    1

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
