class GlassJoeAnimations
  new: =>
    @image = love.graphics.newImage("images/GlassJoe.png")
    @animation_index = 1
    @timer = 0
    self\setBlockingDown()

  setBlockingDown: =>
    @current_animation = self\blockingDown()

  blockingDown: =>
    {{self\newQuad(268, 24, 300, 124), 0.2}, {self\newQuad(308, 24, 340, 124), 0.1}, {self\newQuad(346, 24, 376, 124), 0.05}}

  currentQuad: =>
    self\blockingDown()[@animation_index][1]

  newQuad: (startX, startY, endX, endY) =>
    love.graphics.newQuad(startX, startY, endX - startX, endY - startY, @image\getWidth(), @image\getHeight())

  update: (dt) =>
    animation_speed = 0.2
    @timer += dt
    if @timer >= animation_speed
      @timer -= animation_speed
      @animation_index += 1
      if @animation_index > #@current_animation
        @animation_index = 1



{:GlassJoeAnimations}
