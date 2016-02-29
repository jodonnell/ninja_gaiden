class Fist
  new: (id, x, y, dx, dy, pressure) =>
    @id = id
    @x = x
    @y = y
    @dx = dx
    @dy = dy
    @pressure = pressure
    @hasFistConnected = false

  didHitUpperToRight: =>
    connected = not @hasFistConnected and @x <= self\middleOfScreen()
    if connected
      @hasFistConnected = true
    connected

  didHitUpperToLeft: =>
    connected = not @hasFistConnected and @x > self\middleOfScreen()
    if connected
      @hasFistConnected = true
    connected

  middleOfScreen: =>
    width, _ = love.graphics.getDimensions()
    width / 2


{:Fist}
