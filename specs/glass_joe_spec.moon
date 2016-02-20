import GlassJoe from require 'glass_joe'

describe "GlassJoe", ->
  local gj

  before_each ->
    gj = GlassJoe!

  it "can draw", ->
    spy.on(love.graphics, "draw")
    gj\draw()
    assert.spy(love.graphics.draw).was.called_with(test_image, 1, 20, 0, 0, 2, 2)

  it "moves right", ->
    gj\update(1)
    assert.are.equal(gj.x, 20)

    gj.rightPressed = true
    gj\update(1)
    assert.are.equal(gj.x, 21)
