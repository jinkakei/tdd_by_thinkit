require_relative 'frame'

class BowlingGame
  def initialize
    @spare_frame = nil
    @bonus_frames = []
    @frames = [ Frame.new ]
  end

  def record_shot(pins)
    frame = @frames.last
    frame.record_shot(pins)
    calc_bonus(pins)
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

  def calc_bonus(pins)
    distribute_bonus(pins)
    if @frames.last.need_bonus?
      @bonus_frames << @frames.last
    end
  end

  def distribute_bonus(pins)
    @bonus_frames.select(&:need_bonus?).each do |frame|
      frame.add_bonus(pins)
    end
  end

end
