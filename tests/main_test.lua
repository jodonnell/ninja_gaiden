module(..., package.seeall)
require 'tests.helpers'

function setup()
  love.graphics.newImage = function(path) return path end

  mainGame = MainGame()
  mainGame:load()
end

function teardown()
  mainGame = nil
end

function test_ninja_jump_attack_and_move_right()
  mainGame.ninja.x = 0
  mainGame.ninja:setY(450)
  mainGame.ninja.rightPressed = true
  mainGame.ninja:startJumping()
  
  for i=1, 10 do
    mainGame:update(ONE_FRAME)
  end

  mainGame.ninja.isAttacking = true

  local x = mainGame.ninja.x
  local y = mainGame.ninja.y
  mainGame:update(ONE_FRAME)

  assert_gt(x, mainGame.ninja.x, 'Should move right')
  assert_lt(y, mainGame.ninja.y, 'Should move up')
end

function test_enemy_appears_at_when_scrolling()
  mainGame.ninja.x = 584
  mainGame.ninja.rightPressed = true
  assert_equal(0, #mainGame.enemies, 'No enemies')

  mainGame:update(ONE_FRAME)
  assert_equal(1, #mainGame.enemies, 'One enemy')
end

function test_ninja_can_hit_enemy()
  mainGame.ninja.x = 100
  table.insert(mainGame.enemies, Hunchback(100, mainGame.ninja.y, LEFT, 0, 200))
  mainGame:update(ONE_FRAME)
  assert_true(mainGame.ninja.isHurt)
end

function test_ninja_cannot_hit_enemy_if_invincible()
  mainGame.ninja.x = 100
  mainGame.ninja.isInvincible = true
  table.insert(mainGame.enemies, Hunchback(100, mainGame.ninja.y, LEFT, 0, 200))
  mainGame:update(ONE_FRAME)
  assert_false(mainGame.ninja.isHurt)
end

function test_ninja_can_kill_enemy()
  mainGame.ninja.x = 100
  table.insert(mainGame.enemies, Hunchback(135, mainGame.ninja.y, LEFT, 0, 200))

  mainGame.ninja.isAttacking = true
  mainGame:update(ONE_FRAME)
  assert_equal(0, #mainGame.enemies, 'Enemy did not disappear')
  assert_equal(1, #mainGame.explosions, 'No explosions')
end

function test_ninja_dies()
  mainGame.ninja.life = 1
  mainGame.ninja:gotHurt()
  mainGame.enemies = {[1]=Hunchback(1, 1, LEFT, 1, 0, 200)}

  mainGame:update(ONE_FRAME)
  assert_equal(NINJA_STARTING_LIVES - 1, mainGame.ninja.lives)
  assert_equal(105, mainGame.ninja.x)
  assert_equal(150, mainGame.ninja.y)
  assert_equal(0, #mainGame.enemies, 'Enemy did not disappear')
end

function test_ninja_dies_if_falls_off_cliff()
  mainGame.ninja.y = love.graphics.getHeight() + 40
  mainGame.ninja.lastY = love.graphics.getHeight() + 40
  mainGame:update(ONE_FRAME)
  assert_equal(NINJA_STARTING_LIVES - 1, mainGame.ninja.lives)
end

function test_ninja_destroys_item_ball()
  mainGame.ninja.x = 100
  mainGame.stage.itemBalls={ItemBall(135, mainGame.ninja.y)}

  mainGame.ninja.isAttacking = true
  mainGame:update(ONE_FRAME)
  assert_equal(0, #mainGame.stage.itemBalls, 'Itemball did not disappear')
  assert_equal(1, #mainGame.powerups, 'Powerup appeared')
end

function advanceDraw(newX)
  mainGame.enemies[1].loveDraw = function(self, image, x, y) 
    assert_equal(newX, x, 'Moved relatively 4')
  end

  mainGame:update(ONE_FRAME)
  mainGame:draw()
end
