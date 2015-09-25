require 'minitest/autorun'
require_relative 'frame'

class BowlingGameTest < MiniTest::Unit::TestCase
  def test_all_gutter_game
    frame = Frame.new
    frame.record_shot(0)
    frame.record_shot(0)
    assert_equal 0, frame.score
  end

  def test_all_1pin_game
    frame = Frame.new
    frame.record_shot(1)
    frame.record_shot(1)
    assert_equal 2, frame.score
  end
end
