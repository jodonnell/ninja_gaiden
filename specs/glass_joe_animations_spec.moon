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
    assert.are.same(gja\blockingDown()["quads"][1][1], Quad(268, 24, 32, 100, 10, 10))

  it "can first animation frame", ->
    gja\setBlockingDown()
    assert.are.same(gja\currentQuad(), Quad(268, 24, 32, 100, 10, 10))

  it "moves to second animation frame", ->
    gja\setBlockingDown()
    gja\update(0.3)
    assert.are.same(gja\currentQuad(), Quad(346, 24, 30, 100, 10, 10))

  it "moves to the third animation frame", ->
    gja\setBlockingDown()
    gja\update(0.3)
    gja\update(0.15)
    assert.are.same(gja\currentQuad(), Quad(308, 24, 32, 100, 10, 10))

  it "moves to the first animation frame after last", ->
    gja\setBlockingDown()
    gja\update(0.3)
    gja\update(0.15)
    gja\update(0.1)
    gja\update(0.15)
    assert.are.same(gja\currentQuad(), Quad(268, 24, 32, 100, 10, 10))

  it "will overflow", ->
    gja\setBlockingDown()
    gja\update(0.4)
    gja\update(0.1)
    assert.are.same(gja\currentQuad(), Quad(308, 24, 32, 100, 10, 10))

  it "adds observers", ->
    thing = {1}
    gja\addObserver(thing)
    assert.are.same(gja\observers(), {thing})

  it "alerts obeservers when the animation ends", ->
    t = { animationEnded: -> }
    m = mock(t)
    gja\setHitUpper()
    gja\addObserver(m)
    gja\update(1.2)
    gja\update(1.2)

    assert.spy(m.animationEnded).was.called()

  it "resets the animation index when it switches animations", ->
    gja\setBlockingDown()
    gja\update(0.3)

    gja\setHitUpper()
    assert.are.equal(gja.animationIndex, 1)
