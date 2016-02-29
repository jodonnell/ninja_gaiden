_ = require 'lib/underscore'
import Fist from require 'src/input/fist'

class FistTracking
  new: (face) =>
    @_face = face
    @_fists = {}

  createFist: (id, x, y, dx, dy, pressure) =>
    Fist(id, x, y, dx, dy, pressure, @_face)

  startTracking: (fist) =>
    table.insert(@_fists, fist)

  fists: =>
    @_fists

  didHitUpperToRight: =>
    _.any([fist\didHitUpperToRight() for fist in *@_fists])

  didHitUpperToLeft: =>
    _.any([fist\didHitUpperToLeft() for fist in *@_fists])

  findFist: (id) =>
    _.detect(@_fists, (fist) -> fist.id == id)

  endTracking: (removeFist) =>
    @_fists = _.reject(@_fists, (fist) -> fist == removeFist)


{:FistTracking}
