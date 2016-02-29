boundingBox = require 'lib/geometry'

class Fist
  new: (id, x, y, dx, dy, pressure, face) =>
    @id = id
    @x = x
    @y = y
    @dx = dx
    @dy = dy
    @pressure = pressure
    self\setFace(face)
    @hasFistConnected = false
    @didStartOnLeft = @x <= self\middleOfScreen()
    @didStartOnRight = @x > self\middleOfScreen()

  update: (x, y, dx, dy, pressure) =>
    @x = x
    @y = y
    @dx = dx
    @dy = dy
    @pressure = pressure

  didHitUpperToRight: =>
    self\didConnectUpper(@didStartOnLeft)

  didHitUpperToLeft: =>
    self\didConnectUpper(@didStartOnRight)

  didConnectUpper: (connectOnSide) =>
    connected = not @hasFistConnected and connectOnSide and boundingBox(@face, @x, @y)
    if connected
      @hasFistConnected = true
    connected

  middleOfScreen: =>
    width, _ = love.graphics.getDimensions()
    width / 2

  setFace: (face) =>
    endX = face[1] + face[3]
    endY = face[2] + face[4]
    @face = {{x: face[1], y: face[2]}, {x: endX, y: endY}}


{:Fist}
