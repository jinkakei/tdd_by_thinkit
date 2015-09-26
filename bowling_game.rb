require_relative 'frame'

class BowlingGame
  def initialize
    @spare_frame = nil
    @strikes = []
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
    @frames.inject(0) do | total, frame | total + frame.score end
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
    if @frames.last.strike?
      recognize_strike_bonus
    end
  end

    def recognize_strike_bonus
      @strikes << @frames.last
    end

    def add_strike_bonus(pins)
      @strikes.each do | strike | 
        if strike.need_bonus?
          strike.add_bonus(pins)
        end
      end
    end

end
