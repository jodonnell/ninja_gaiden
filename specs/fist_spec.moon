import Fist from require 'src/input/fist'

describe "FistTracking", ->
  it "detects hit upper right", ->
    fist = Fist(0, 1, 1, 0, 0, 0)
    assert.is.truthy(fist\hitUpperRight())
    assert.is.falsy(fist\hitUpperLeft())

  it "detects hit upper left", ->
    fist = Fist(0, 300, 1, 0, 0, 0)
    assert.is.truthy(fist\hitUpperLeft())
    assert.is.falsy(fist\hitUpperRight())
