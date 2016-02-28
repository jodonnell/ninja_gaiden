_ = require 'lib/underscore'

class FistTracking
  new: =>
    @_fists = {}

  startTracking: (fist) =>
    table.insert(@_fists, fist)

  fists: =>
    @_fists

  didHitUpperToRight: =>
    results = [fist\didHitUpperToRight() for fist in *@_fists]
    _.any(results)

  didHitUpperToLeft: =>
    results = [fist\didHitUpperToLeft() for fist in *@_fists]
    _.any(results)


{:FistTracking}
