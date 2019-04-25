import GlassJoe from require 'src.opponents.glass_joe'


display.setStatusBar( display.HiddenStatusBar )
background = display.newRect(display.contentCenterX, display.contentCenterY, display.viewableContentWidth, display.viewableContentHeight)
background\setFillColor(0, 0, 1)

glassJoe = GlassJoe!

onObjectTouch = (event) ->
  if event.phase == "began"
    glassJoe\setHurtAnimation(event.xStart)
  true

background\addEventListener("touch", onObjectTouch)
