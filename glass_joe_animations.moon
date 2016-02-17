class GlassJoeAnimations
  new: =>
    @image = love.graphics.newImage("images/GlassJoe.png")

  blockingDown: =>
    self\newQuad(268, 24, 300, 124)

  currentQuad: =>
    self\blockingDown()

  newQuad: (startX, startY, endX, endY) =>
    love.graphics.newQuad(startX, startY, endX - startX, endY - startY, @image\getWidth(), @image\getHeight())

  update: (dt) =>


{:GlassJoeAnimations}
