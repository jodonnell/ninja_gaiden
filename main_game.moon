import GlassJoe from require 'glass_joe'

class MainGame
  new: =>

  load: =>
    @glass_joe = GlassJoe!

  draw: =>
    @glass_joe\draw()

  update: (dt) =>
    @glass_joe\update(dt)

{:MainGame}
