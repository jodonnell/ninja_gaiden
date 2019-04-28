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
        name: "readyHigh",
        frames: { 9, 10, 11, 10 },
        time: 550,
        loopCount: 0
      },
      {
        name: "hurt",
        frames: { 4, 5, 5, 5 },
        time: 800,
        loopCount: 1
      },
      {
        name: "lowerHurt",
        frames: { 6 },
        time: 800,
        loopCount: 1
      },
      {
        name: "lowerBlock",
        frames: { 7 },
        time: 800,
        loopCount: 1
      },
      {
        name: "upperBlock",
        frames: { 12 },
        time: 800,
        loopCount: 1
      },
      {
        name: "uppercut",
        frames: { 13, 14, 15 },
        time: 300,
        loopCount: 1
      },
      {
        name: "jab",
        frames: { 16 },
        time: 300,
        loopCount: 1
      },
    }

    @sheetOptions = {
      frames: {
        { -- idle block low 1
          x: 268,
          y: 24,
          width: 32,
          height: 100
        },
        { -- idle btlock low 2
          x: 346,
          y: 24,
          width: 30,
          height: 100
        },
        { -- idle block low 3
          x: 308,
          y: 24,
          width: 32,
          height: 100
        },
        { -- upper hit 1
          x: 54,
          y: 132,
          width: 32,
          height: 92
        },
        { -- upper hit 2
          x: 397,
          y: 136,
          width: 31,
          height: 101
        },
        { -- lower hit 1
          x: 10,
          y: 136,
          width: 33,
          height: 81
        },
        { -- lower block 1
          x: 185,
          y: 24,
          width: 33,
          height: 100
        },
        { -- lower block 2
          x: 225,
          y: 24,
          width: 33,
          height: 100
        },
        { -- idle block high 1
          x: 428,
          y: 24,
          width: 32,
          height: 100
        },
        { -- idle block high 2
          x: 470,
          y: 24,
          width: 30,
          height: 100
        },
        { -- idle block high 3
          x: 510,
          y: 24,
          width: 32,
          height: 100
        },
        { -- upper block 1
          x: 386,
          y: 24,
          width: 34,
          height: 100
        },
        { -- uppercut 1
          x: 200,
          y: 136,
          width: 38,
          height: 100
        },
        { -- uppercut 2
          x: 252,
          y: 136,
          width: 34,
          height: 100
        },
        { -- uppercut 3
          x: 298,
          y: 136,
          width: 41,
          height: 100
        },
        { -- jab
          x: 350,
          y: 136,
          width: 32,
          height: 100
        },
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

  setLowerHurtAnimation: (startX) =>
    @character\setSequence("lowerBlock")
    @character\play()
    if startX > display.contentCenterX
      @character.xScale = -10
    onHurtEnded = (event) ->
      if event.phase == "ended"
        self\setReadyAnimation()
        @character\removeEventListener("sprite", onHurtEnded)

    @character\addEventListener("sprite", onHurtEnded)

{:GlassJoe}
