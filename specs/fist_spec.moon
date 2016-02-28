import Fist from require 'src/input/fist'

describe "FistTracking", ->
  it "detects hit upper right", ->
    fist = Fist(0, 1, 1, 0, 0, 0)
    assert.is.truthy(fist\didHitUpperToRight())
    assert.is.falsy(fist\didHitUpperToLeft())

  it "detects hit upper left", ->
    fist = Fist(0, 300, 1, 0, 0, 0)
    assert.is.truthy(fist\didHitUpperToLeft())
    assert.is.falsy(fist\didHitUpperToRight())
