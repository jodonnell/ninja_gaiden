_ = require 'lib/underscore'

class FistTracking
  new: =>
    @_fists = {}

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
