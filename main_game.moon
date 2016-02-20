import GlassJoe from require 'glass_joe'

class MainGame
  new: =>

  load: =>
    @opponent = GlassJoe!

  draw: =>
    @opponent\draw()

  update: (dt) =>
    @opponent\update(dt)

{:MainGame}
