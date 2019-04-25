class GlassJoe
  new: =>
    @sequence = {
      {
        name: "ready",
        frames: { 1, 2, 3, 2 },
        time: 550,
        loopCount: 0
      },
      {
        name: "hurt",
        frames: { 4, 5, 5, 5 },
        time: 800,
        loopCount: 1
      },
    }

    @sheetOptions = {
      frames: {
        {
          x: 268,
          y: 24,
          width: 32,
          height: 100
        },
        {
          x: 346,
          y: 24,
          width: 30,
          height: 100
        },
        {
          x: 308,
          y: 24,
          width: 32,
          height: 100
        },
        {
          x: 54,
          y: 132,
          width: 32,
          height: 92
        },
        {
          x: 397,
          y: 136,
          width: 31,
          height: 101
        }
      }
    }

    objectSheet = graphics.newImageSheet("images/GlassJoe.png", @sheetOptions)
    @character = display.newSprite(objectSheet, @sequence)
    @character.x = display.contentCenterX
    @character.y = display.contentCenterY
    @character.id = "GlassJoe"
    @character\scale(10, 10)
    @character\setSequence("ready")
    @character\play()

  setReadyAnimation: =>
    @character.xScale = 10
    @character\setSequence("ready")
    @character\play()

  setHurtAnimation: (startX) =>
    @character\setSequence("hurt")
    @character\play()
    if startX > display.contentCenterX
      @character.xScale = -10
    onHurtEnded = (event) ->
      if event.phase == "ended"
        self\setReadyAnimation()
        @character\removeEventListener("sprite", onHurtEnded)

    @character\addEventListener("sprite", onHurtEnded)

{:GlassJoe}
