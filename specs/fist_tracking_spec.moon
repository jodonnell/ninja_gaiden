import Fist from require 'src/input/fist'
import FistTracking from require 'src/input/fist_tracking'

describe "FistTracking", ->
  local ft

  before_each ->
    ft = FistTracking({100, 100, 50, 50})

  it "takes in fists to track", ->
    fist = ft\createFist(0, 1, 1, 0, 0, 0)
    ft\startTracking(fist)
    assert.are.same(ft\fists(), {fist})

  it "detects hit upper right", ->
    fist = ft\createFist(0, 100, 100, 0, 0, 0)
    ft\startTracking(fist)
    assert.is.truthy(ft\didHitUpperToRight())
    assert.is.falsy(ft\didHitUpperToLeft())

  it "detects hit upper left", ->
    fist = ft\createFist(0, 300, 1, 0, 0, 0)
    ft\startTracking(fist)
    assert.is.truthy(ft\didHitUpperToLeft())
    assert.is.falsy(ft\didHitUpperToRight())

  it "find fist", ->
    fist = ft\createFist(0, 300, 1, 0, 0, 0)
    ft\startTracking(fist)

    fist2 = ft\createFist(1, 0, 1, 0, 0, 0)
    ft\startTracking(fist2)

    assert.are.equal(ft\findFist(1), fist2)

  it "endTracking", ->
    fist = ft\createFist(0, 300, 1, 0, 0, 0)
    ft\startTracking(fist)
    ft\endTracking(fist)

    assert.are.same({}, ft\fists())
