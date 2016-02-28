class FistTracking
  new: =>
    @_fists = {}

  startTracking: (fist) =>
    table.insert(@_fists, fist)

  fists: =>
    @_fists
    
    
{:FistTracking}
