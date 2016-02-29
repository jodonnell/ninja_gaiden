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
    assert.is.truthy(ft\didHitUpperToRight())
    assert.is.falsy(ft\didHitUpperToLeft())

  it "detects hit upper left", ->
    fist = Fist(0, 300, 1, 0, 0, 0)
    ft\startTracking(fist)
    assert.is.truthy(ft\didHitUpperToLeft())
    assert.is.falsy(ft\didHitUpperToRight())

  it "find fist", ->
    fist = Fist(0, 300, 1, 0, 0, 0)
    ft\startTracking(fist)

    fist2 = Fist(1, 0, 1, 0, 0, 0)
    ft\startTracking(fist2)

    assert.are.equal(ft\findFist(1), fist2)

  it "endTracking", ->
    fist = Fist(0, 300, 1, 0, 0, 0)
    ft\startTracking(fist)
    ft\endTracking(fist)

    assert.are.same({}, ft\fists())
