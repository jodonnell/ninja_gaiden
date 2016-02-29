import Fist from require 'src/input/fist'

describe "FistTracking", ->
  face = {100, 100, 50, 50}

  it "detects hit upper right", ->
    fist = Fist(0, 1, 1, 0, 0, 0, face)
    assert.is.falsy(fist\didHitUpperToRight())
    fist\update(125, 125, 10, -10, 1)
    assert.is.truthy(fist\didHitUpperToRight())

  it "detects hit upper left", ->
    fist = Fist(0, 300, 1, 0, 0, 0, face)
    assert.is.truthy(fist\didHitUpperToLeft())
    assert.is.falsy(fist\didHitUpperToRight())

  it "only hits once", ->
    fist = Fist(0, 300, 1, 0, 0, 0, face)
    assert.is.truthy(fist\didHitUpperToLeft())
    assert.is.falsy(fist\didHitUpperToLeft())
