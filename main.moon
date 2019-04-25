import GlassJoe from require 'src.opponents.glass_joe'


display.setStatusBar( display.HiddenStatusBar )

background = display.newRect(0, 0, display.contentWidth * 2, display.contentHeight *2 )
background\setFillColor(0, 0, 1)

glassJoe = GlassJoe!

onObjectTouch = (event) ->
  if event.phase == "began"
    glassJoe\setHurtAnimation(event.xStart)
  true

background\addEventListener("touch", onObjectTouch)
