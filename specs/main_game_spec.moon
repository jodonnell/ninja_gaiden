import MainGame from require 'src/main_game'

describe "MainGame", ->
  local mg

  before_each ->
    mg = MainGame!
    mg\load()

  it "has an opponent", ->
    assert.is.truthy(mg.opponent)

  it "draws the opponent", ->
    s = spy.on(mg.opponent, "draw")
    mg\draw()
    assert.spy(s).was_called()

  it "updates the opponent", ->
    s = stub(mg.opponent, "update")
    mg\update(2)
    assert.spy(s).was_called_with(mg.opponent, 2)

  it "hits the player to the right", ->
    mg\touchpressed(0, 20, 100, 1, -1, 1)
    mg\touchmoved(0, 20, 100, 1, -1, 1)
    assert.is.truthy(mg.opponent.hitRight)

  it "hits the player to the left", ->
    mg\touchpressed(0, 300, 100, -1, -1, 1)
    mg\touchmoved(0, 300, 100, -1, -1, 1)
    assert.is.truthy(mg.opponent.hitLeft)

  it "ends tracking when the touch ends", ->
    mg\touchpressed(0, 300, 100, -1, -1, 1)
    mg\touchreleased(0, 300, 100, -1, -1, 1)
    assert.are.equal(#mg.fistTracking\fists(), 0)
