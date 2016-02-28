_ = require 'lib/underscore'

class FistTracking
  new: =>
    @_fists = {}

  startTracking: (fist) =>
    table.insert(@_fists, fist)

  fists: =>
    @_fists

  hitUpperRight: =>
    results = [fist\hitUpperRight() for fist in *@_fists]
    _.any(results)

  hitUpperLeft: =>
    results = [fist\hitUpperLeft() for fist in *@_fists]
    _.any(results)


{:FistTracking}
