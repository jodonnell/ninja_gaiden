module(..., package.seeall)
import Ninja from require 'ninja'

test_ninja_can_move: () ->
  ninja = Ninja!
  ninja.rightPressed = true
  ninja\update()
  assert_equal(21, ninja.x)
