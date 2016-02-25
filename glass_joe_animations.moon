class GlassJoeAnimations
  new: =>
    @image = love.graphics.newImage("images/GlassJoe.png")
    @animation_index = 1
    @timer = 0
    @_observers = {}
    self\setBlockingDown()

  addObserver: (observer) =>
    table.insert(@_observers, observer)

  observers: () =>
    @_observers

  setBlockingDown: =>
    @current_animation = self\blockingDown()

  setHitUpper: =>
    @current_animation = self\hitUpper()

  blockingDown: =>
    if @blockingDownCache
      return @blockingDownCache

    @blockingDownCache = {{self\newQuad(268, 24, 300, 124), 0.3},
      {self\newQuad(346, 24, 376, 124), 0.15},
      {self\newQuad(308, 24, 340, 124), 0.1},
      {self\newQuad(346, 24, 376, 124), 0.15}}
    return @blockingDownCache

  hitUpper: =>
    if @hitUpperCache
      return @hitUpperCache

    @hitUpperCache = {{self\newQuad(54, 132, 86, 224), 1.0},
      {self\newQuad(397, 136, 428, 237), 1.15}}
    return @hitUpperCache

  currentQuad: =>
    @current_animation[@animation_index][1]

  currentSpeed: =>
    @current_animation[@animation_index][2]

  newQuad: (startX, startY, endX, endY) =>
    love.graphics.newQuad(startX, startY, endX - startX, endY - startY, @image\getWidth(), @image\getHeight())

  update: (dt) =>
    @timer += dt
    if @timer >= self\currentSpeed()
      @timer -= self\currentSpeed()
      @animation_index += 1
      if @animation_index > #@current_animation
        @animation_index = 1
        self\animationEnded()

  animationEnded: =>
    for observer in *@_observers do observer\animationEnded!


{:GlassJoeAnimations}
