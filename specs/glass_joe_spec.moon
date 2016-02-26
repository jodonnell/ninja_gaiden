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

  it "changes animation on rightPressed", ->
    gj.rightPressed = true
    gj\update(1)
    assert.are.equal(gj.animations.currentAnimation["name"], "hitUpper")

  it "updates the animation", ->
    stub(gj.animations, "update")
    gj\update(0.01)
    assert.spy(gj.animations.update).was.called_with(gj.animations, 0.01)

  it "goes back to the default animation when the hit animation ends", ->
    gj.rightPressed = true
    gj\update(1)
    gj.rightPressed = false
    gj\update(1)
    gj\update(1)
    assert.are.equal(gj.animations.currentAnimation["name"], "blockingDown")
