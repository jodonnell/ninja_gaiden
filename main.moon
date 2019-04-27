import GlassJoe from require 'src.opponents.glass_joe'
import GestureDetector from require 'src.gesture_detector'


display.setStatusBar( display.HiddenStatusBar )
background = display.newRect(display.contentCenterX, display.contentCenterY, display.viewableContentWidth, display.viewableContentHeight)
background\setFillColor(0, 0, 1)

glassJoe = GlassJoe!

gestureDetector = nil
onObjectTouch = (event) ->
  if event.phase == "began"
    gestureDetector = GestureDetector!
    gestureDetector\addPoint(event.x, event.y)
  elseif event.phase == "moved"
    gestureDetector\addPoint(event.x, event.y)
  elseif event.phase == "ended" or event.phase == "cancelled"
    gestureDetector\addPoint(event.x, event.y)

  if gestureDetector\isUppercut()
    gestureDetector\clear()
    glassJoe\setHurtAnimation(event.xStart)

  true

background\addEventListener("touch", onObjectTouch)
