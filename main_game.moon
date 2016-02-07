import Ninja from require 'ninja'

class MainGame
  new: =>

  load: =>
    @ninja = Ninja!

  draw: =>
    @ninja\draw()

  update: (dt) =>
    @ninja\update(dt)

{:MainGame}
