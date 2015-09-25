require 'minitest/autorun'
require_relative 'frame'

class FrameTest < MiniTest::Unit::TestCase
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

  def test_finish_frame_with_2throw
    frame = Frame.new
    frame.record_shot(1)
    refute frame.finished?, "2nd throw is possible"
    frame.record_shot(1)
    assert frame.finished?, "frame end"
  end

  def test_finish_frame_with_strike
    frame = Frame.new
    frame.record_shot(10)
    assert frame.finished?, "finish with strike"
  end

  def test_spare?
    frame = Frame.new
    frame.record_shot(5)
    refute frame.spare?, "1st throw is never spare"
    frame.record_shot(5)
    assert frame.spare?, "frame end"
  end

  def test_strike?
    frame = Frame.new
    refute frame.strike?, "Yon cannot get strike before throw"
    frame.record_shot(10)
    assert frame.strike?, "Strike! 1st throw get 10 pins"
  end
end