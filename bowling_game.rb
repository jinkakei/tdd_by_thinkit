require_relative 'frame'

class BowlingGame
  def initialize
    @score = 0
    @spare = false
    @last_pins = 0
    @strike_bonus_count = 0
    @double_bonus_count = 0
    @frames = [ Frame.new ]
  end

  def record_shot(pins)
    frame = @frames.last
    frame.record_shot(pins)
    @score += pins
    calc_spare_bonus(pins)
    calc_strike_bonus(pins)
    if frame.finished?
      @frames << Frame.new
    end
  end

  def score
    return @score
  end

  def frame_score(frame_no)
    return @frames[ frame_no - 1].score
  end

  private

  def calc_spare_bonus(pins)
    if @spare
      @score += pins
      @spare = false
    end
    #if spare?(pins)
    if @frames.last.spare?
      @spare = true
    end
  end

  def calc_strike_bonus(pins)
    add_strike_bonus(pins)
    add_double_bonus(pins)
    if @frames.last.strike?
      recognize_strike_bonus
    end
  end
    def add_strike_bonus(pins)
      if @strike_bonus_count > 0
        @score += pins
        @strike_bonus_count -= 1
      end
    end

    def add_double_bonus(pins)
      if @double_bonus_count > 0
        @score += pins
        @double_bonus_count -= 1
      end
    end

    def recognize_strike_bonus
      if @strike_bonus_count == 0
        @strike_bonus_count = 2
      else
        @double_bonus_count = 2
      end
    end

end
