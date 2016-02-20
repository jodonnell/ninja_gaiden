import MainGame from require 'main_game'

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
    s = spy.on(mg.opponent, "update")
    mg\update(2)
    assert.spy(s).was_called_with(mg.opponent, 2)
