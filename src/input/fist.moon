class Fist
  new: (id, x, y, dx, dy, pressure) =>
    @id = id
    @x = x
    @y = y
    @dx = dx
    @dy = dy
    @pressure = pressure

  didHitUpperToRight: =>
    return @x <= self\middleOfScreen()

  didHitUpperToLeft: =>
    return @x > self\middleOfScreen()

  middleOfScreen: =>
    width, _ = love.graphics.getDimensions()
    width / 2


{:Fist}
