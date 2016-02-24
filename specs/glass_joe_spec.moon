import GlassJoe from require 'glass_joe'

describe "GlassJoe", ->
  local gj
  match = require "luassert.match"

  before_each ->
    gj = GlassJoe!

  it "can draw", ->
    spy.on(love.graphics, "draw")
    gj\draw()
    _ = match._
    assert.spy(love.graphics.draw).was.called_with(test_image, {268, 24, 32, 100, 10, 10}, _, _, _, _, _)

  it "moves right", ->
    gj\update(1)
    assert.are.equal(gj.x, 120)

    gj.rightPressed = true
    gj\update(1)
    assert.are.equal(gj.x, 121)

  it "updates the animation", ->
    stub(gj.animations, "update")
    gj\update(0.01)
    assert.spy(gj.animations.update).was.called_with(gj.animations, 0.01)
