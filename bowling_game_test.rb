require 'minitest/autorun'
require_relative 'bowling_game'

class BowlingGameTest < MiniTest::Unit::TestCase
  def setup
    @game = BowlingGame.new
  end

  def test_all_gutter_game
    20.times do
      @game.record_shot(0)
    end
    assert_equal 0, @game.score
  end

  def test_all_onepin_game
    20.times do
      @game.record_shot(1)
    end
    assert_equal 20, @game.score
  end
  
  def test_add_after_spare
    @game.record_shot(3)
    @game.record_shot(7) # spare: 3 + 7 = 10
    @game.record_shot(4) # x 2: spare bonus
    record_many_shots(17,0) # remains are all gutter.
    assert_equal 18, @game.score
  end

  def test_spare_through_frame
    @game.record_shot(2)
    @game.record_shot(5) # frame end
    @game.record_shot(5) # not spare
    @game.record_shot(1)
    record_many_shots(16,0) # remains are all gutter.
    assert_equal 13, @game.score
  end
  
  def test_strike_v01
    @game.record_shot(10) # strike: 10 + 3 + 3
    @game.record_shot(3)
    @game.record_shot(3)
    @game.record_shot(1)
    record_many_shots(15,0) # remains are all gutter.
    assert_equal 23, @game.score
  end

  def test_double
    @game.record_shot(10) # strike: 10 + 10 + 3 = 23
    @game.record_shot(10) # strike: 10 +  3 + 1 = 14
    @game.record_shot(3)
    @game.record_shot(1)
    record_many_shots(14,0) # remains are all gutter.
    assert_equal 41, @game.score
  end

  def test_turkey
    @game.record_shot(10) # + 10 + 10 = 30
    @game.record_shot(10) # + 10 +  3 = 23
    @game.record_shot(10) # +  3 + 1 = 14
    @game.record_shot(3)
    @game.record_shot(1)
    record_many_shots(17,0) # remains are all gutter.
    assert_equal 71, @game.score
  end

  def test_spare_after_strike
    @game.record_shot(10) # + 5 + 5 = 20
    @game.record_shot(5)
    @game.record_shot(5) # spare: + 3 = 8
    @game.record_shot(3)
    record_many_shots(15,0) # remains are all gutter.
    assert_equal 36, @game.score
  end

  def test_spare_after_double
    @game.record_shot(10) # + 10 + 5 = 25
    @game.record_shot(10) # + 5 + 5 = 20
    @game.record_shot(5)
    @game.record_shot(5) # spare: + 3 = 8
    @game.record_shot(3)
    record_many_shots(13,0) # remains are all gutter.
    assert_equal 61, @game.score
  end

  def test_score_at_1stframe_with_allgutter
    record_many_shots( 20, 0)
    assert_equal 0, @game.frame_score(1)
  end

  def test_scores_at_allframe_with_all1pin
    record_many_shots( 20, 1)
    10.times do | i |
      frame_no = i + 1
      assert_equal 2, @game.frame_score( frame_no )
    end
  end

  private

  def record_many_shots( count, pins)
    count.times do
      @game.record_shot(pins)
    end
  end
end # class BowlingGameTest


