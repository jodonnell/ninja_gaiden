import Fist from require 'src/input/fist'
import FistTracking from require 'src/input/fist_tracking'

describe "FistTracking", ->
  local ft

  before_each ->
    ft = FistTracking!

  it "takes in fists to track", ->
    fist = Fist(0, 1, 1, 0, 0, 0)
    ft\startTracking(fist)
    assert.are.same(ft\fists(), {fist})

  it "detects hit upper right", ->
    fist = Fist(0, 1, 1, 0, 0, 0)
    ft\startTracking(fist)
    assert.is.truthy(ft\hitUpperRight())
    assert.is.falsy(ft\hitUpperLeft())

  it "detects hit upper left", ->
    fist = Fist(0, 300, 1, 0, 0, 0)
    ft\startTracking(fist)
    assert.is.truthy(ft\hitUpperLeft())
    assert.is.falsy(ft\hitUpperRight())
