module(..., package.seeall)
require 'tests.helpers'

function setup()
  love.graphics.newImage = function(path) return path end

  animations = NinjaAnimations(Ninja())
end

function teardown()
  animations = nil
end

function test_fall_animation()
  animations:fall()
  assert_equal(animations.images['falling'], animations:getCurrentImage())
end

function test_stand_animation()
  animations:stand()
  assert_equal(animations.images['standing'], animations:getCurrentImage())
end

function test_hurt_animation()
  animations:hurt()
  assert_equal(animations.images['hurt'], animations:getCurrentImage())
end

function test_duck_animation()
  animations:duck()
  assert_equal(animations.images['ducking'], animations:getCurrentImage())
end

function test_attack_animation()
  animations:attack()
  assert_equal(animations.images['attacking1'], animations:getCurrentImage())

  advanceFrames(5)
  assert_equal(animations.images['attacking2'], animations:getCurrentImage())

  advanceFrames(5)
  assert_equal(animations.images['attacking3'], animations:getCurrentImage())
end

function test_ducking_attack_animation()
  animations:duck()
  animations:attack()
  assert_equal(animations.images['duckingAttack1'], animations:getCurrentImage())

  advanceFrames(5)
  assert_equal(animations.images['duckingAttack2'], animations:getCurrentImage())

  advanceFrames(5)
  assert_equal(animations.images['duckingAttack3'], animations:getCurrentImage())
end


function test_attack_when_falling_does_a_different_animation()
  animations.currentImage = 'falling'
  animations:attack()
  assert_equal(animations.images['fallingAttack1'], animations:getCurrentImage(), 'not first attack animation')

  advanceFrames(6)
  assert_equal(animations.images['fallingAttack2'], animations:getCurrentImage(), 'not second attack animation')

  advanceFrames(6)
  assert_equal(animations.images['falling'], animations:getCurrentImage(), 'not original fall animation')
  
end


function test_ninja_moving_left_runs_animation()
  animations:runLeft()
  assert_equal(animations.images['running1'], animations:getCurrentImage())
  
  advanceFrames(5)
  assert_equal(animations.images['running2'], animations:getCurrentImage())
  
  advanceFrames(5)
  assert_equal(animations.images['running3'], animations:getCurrentImage())

  advanceFrames(6)
  assert_equal(animations.images['running1'], animations:getCurrentImage())
end

function test_ninja_moving_right_runs_animation()
  animations:runRight()
  assert_equal(animations.images['running1'], animations:getCurrentImage())
  
  advanceFrames(5)
  assert_equal(animations.images['running2'], animations:getCurrentImage())
  
  advanceFrames(5)
  assert_equal(animations.images['running3'], animations:getCurrentImage())

  advanceFrames(6)
  assert_equal(animations.images['running1'], animations:getCurrentImage())
end

function test_climbing_animation()
  animations.ninja.upPressed = true
  animations:climb()
  assert_equal(animations.images['climbing1'], animations:getCurrentImage())
  
  advanceFrames(6)
  assert_equal(animations.images['climbing2'], animations:getCurrentImage())
  
  advanceFrames(6)
  assert_equal(animations.images['climbing1'], animations:getCurrentImage())
end


function advanceFrames(numFrames)
  for i=1, numFrames do
    animations:changeAnimation(ONE_FRAME)
  end
end
