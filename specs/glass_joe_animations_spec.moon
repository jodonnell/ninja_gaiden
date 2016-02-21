import GlassJoeAnimations from require 'glass_joe_animations'

describe "GlassJoeAnimations", ->
  local gja

  before_each ->
    gja = GlassJoeAnimations!

  it "has an image", ->
    spy.on(love.graphics, "newImage")
    gja = GlassJoeAnimations!
    assert.spy(love.graphics.newImage).was.called_with("images/GlassJoe.png")

  it "blocks down", ->
    spy.on(love.graphics, "newQuad")
    assert.equals(gja\blockingDown(), "new_quad")
    assert.spy(love.graphics.newQuad).was.called_with(268, 24, 32, 100, 10, 10)
