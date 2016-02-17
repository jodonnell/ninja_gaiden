module(..., package.seeall)
import GlassJoe from require 'glass_joe'

test_glass_joe_can_move: () ->
  glass_joe = GlassJoe!
  glass_joe.rightPressed = true
  glass_joe\update()
  assert_equal(21, glass_joe.x)
