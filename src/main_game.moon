import GlassJoe from require 'src/opponents/glass_joe'
import FistTracking from require 'src/input/fist_tracking'
import Fist from require 'src/input/fist'

class MainGame
  new: =>
    @fistTracking = FistTracking!

  load: =>
    @opponent = GlassJoe!

  draw: =>
    @opponent\draw()

  update: (dt) =>
    @opponent\update(dt)

  touchpressed: (id, x, y, dx, dy, pressure) =>
    fist = Fist(id, x, y, dx, dy, pressure)
    @fistTracking\startTracking(fist)

  touchmoved: (id, x, y, dx, dy, pressure) =>
    --if @fistTracking\hitUpperRight()
    --  @opponent.hitRight = true
    --if @fistTracking\hitUpperLeft()
    --  @opponent.hitLeft = true

    width, _ = love.graphics.getDimensions()
    if x > (width / 2)
      @opponent.hitLeft = true
    else
      @opponent.hitRight = true

{:MainGame}
