import GlassJoe from require 'src/opponents/glass_joe'

describe "GlassJoe", ->
  local gj
  match = require "luassert.match"
  _ = match._

  before_each ->
    gj = GlassJoe!

  it "can draw", ->
    spy.on(love.graphics, "draw")
    gj\draw()
    assert.spy(love.graphics.draw).was.called_with(test_image, Quad(268, 24, 32, 100, 10, 10), _, _, _, _, _, _, _)

  it "changes animation on hitRight", ->
    gj.hitRight = true
    gj\update(1)
    assert.are.equal(gj.animations.currentAnimation["name"], "hitUpper")

  it "updates the animation", ->
    stub(gj.animations, "update")
    gj\update(0.01)
    assert.spy(gj.animations.update).was.called_with(gj.animations, 0.01)

  it "goes back to the default animation when the hit animation ends", ->
    gj.hitRight = true
    gj\update(1)
    gj.hitRight = false
    gj\update(1)
    gj\update(1)
    assert.are.equal(gj.animations.currentAnimation["name"], "blockingDown")

  it "can be hit left", ->
    gj.hitLeft = true
    gj\update(1)
    assert.are.equal(gj.animations.currentAnimation["name"], "hitUpper")
    gj\draw()
    assert.spy(love.graphics.draw).was.called_with(test_image, _, _, _, _, -4, _, 32, _)

  it "has a face", ->
    assert.are.same(gj\face(), {160, 110, 60, 70})


