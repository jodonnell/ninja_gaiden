class Fist
  new: (id, x, y, dx, dy, pressure) =>
    @id = id
    @x = x
    @y = y
    @dx = dx
    @dy = dy
    @pressure = pressure

  hitUpperRight: =>
    return @x <= self\middleOfScreen()

  hitUpperLeft: =>
    return @x > self\middleOfScreen()

  middleOfScreen: =>
    width, _ = love.graphics.getDimensions()
    width / 2


{:Fist}
