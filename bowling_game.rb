require_relative 'frame'

class BowlingGame
  def initialize
    @spare = false
    @spare_frame = nil
    @last_pins = 0
    @strike_frame = nil
    @strike_bonus_count = 0
    @double_frame = nil
    @double_bonus_count = 0
    @frames = [ Frame.new ]
  end

  def record_shot(pins)
    frame = @frames.last
    frame.record_shot(pins)
    calc_spare_bonus(pins)
    calc_strike_bonus(pins)
    if frame.finished?
      @frames << Frame.new
    end
  end

  def score
    total = 0
    @frames.each do |frame|
      total += frame.score
    end
    total
  end

  def frame_score(frame_no)
    return @frames[ frame_no - 1].score
  end

  private

  def calc_spare_bonus(pins)
    if @spare
      @spare = false
      @spare_frame.add_bonus(pins)
      @spare_frame = nil
    end
    #if spare?(pins)
    if @frames.last.spare?
      @spare = true
      @spare_frame = @frames.last
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
        @strike_bonus_count -= 1
        @strike_frame.add_bonus(pins)
      end
    end

    def add_double_bonus(pins)
      if @double_bonus_count > 0
        @double_bonus_count -= 1
        @double_frame.add_bonus(pins)
      end
    end

    def recognize_strike_bonus
      if @strike_bonus_count == 0
        @strike_bonus_count = 2
        @strike_frame = @frames.last
      else
        @double_bonus_count = 2
        @double_frame = @frames.last
      end
    end

end
