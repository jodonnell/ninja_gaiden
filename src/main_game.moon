import GlassJoe from require 'src.opponents.glass_joe'

class MainGame
  new: =>

  load: =>
    @opponent = GlassJoe!

  draw: =>
    @opponent\draw()

  update: (dt) =>
    @opponent\update(dt)

  touchpressed: (id, x, y, dx, dy, pressure) =>
    @opponent.hitRight = true

  touchmoved: (id, x, y, dx, dy, pressure) =>
    width, _ = display.getDimensions()
    if x > (width / 2)
      @opponent.hitLeft = true
    else
      @opponent.hitRight = true

{:MainGame}
