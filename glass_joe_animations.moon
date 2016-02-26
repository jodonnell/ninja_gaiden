class GlassJoeAnimations
  new: =>
    @image = love.graphics.newImage("images/GlassJoe.png")
    @animationIndex = 1
    @timer = 0
    @_observers = {}
    self\setBlockingDown()

  addObserver: (observer) =>
    table.insert(@_observers, observer)

  observers: () =>
    @_observers

  setBlockingDown: =>
    @animationIndex = 1
    @currentAnimation = self\blockingDown()

  setHitUpper: =>
    @animationIndex = 1
    @currentAnimation = self\hitUpper()

  blockingDown: =>
    if @blockingDownCache
      return @blockingDownCache

    @blockingDownCache = {quads: {{self\newQuad(268, 24, 300, 124), 0.3},
      {self\newQuad(346, 24, 376, 124), 0.15},
      {self\newQuad(308, 24, 340, 124), 0.1},
      {self\newQuad(346, 24, 376, 124), 0.15}},
      name: "blockingDown"}
    return @blockingDownCache

  hitUpper: =>
    if @hitUpperCache
      return @hitUpperCache

    @hitUpperCache = {quads: {{self\newQuad(54, 132, 86, 224), 1.0},
      {self\newQuad(397, 136, 428, 237), 1.15}},
      name: "hitUpper"}
    return @hitUpperCache

  currentQuad: =>
    @currentAnimation["quads"][@animationIndex][1]

  currentSpeed: =>
    @currentAnimation["quads"][@animationIndex][2]

  newQuad: (startX, startY, endX, endY) =>
    love.graphics.newQuad(startX, startY, endX - startX, endY - startY, @image\getWidth(), @image\getHeight())

  update: (dt) =>
    @timer += dt
    if @timer >= self\currentSpeed()
      @timer -= self\currentSpeed()
      @animationIndex += 1
      if @animationIndex > #@currentAnimation["quads"]
        @animationIndex = 1
        self\animationEnded()

  animationEnded: =>
    for observer in *@_observers do observer\animationEnded!


{:GlassJoeAnimations}
