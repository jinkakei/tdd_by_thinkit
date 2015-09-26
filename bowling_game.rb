require_relative 'frame'

class BowlingGame
  def initialize
    @spare_frame = nil
    @last_pins = 0
    @strike_frame = nil
    @double_frame = nil
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
    if @spare_frame && @spare_frame.need_bonus?
      @spare_frame.add_bonus(pins)
    end
    if @frames.last.spare?
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
      if @strike_frame && @strike_frame.need_bonus?
        @strike_frame.add_bonus(pins)
      end
    end

    def add_double_bonus(pins)
      if @double_frame && @double_frame.need_bonus?
        @double_frame.add_bonus(pins)
      end
    end

    def recognize_strike_bonus
      if @strike_frame.nil? || !@strike_frame.need_bonus?
        @strike_frame = @frames.last
      else
        @double_frame = @frames.last
      end
    end

end
