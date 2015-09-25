class Frame
  def initialize
    @score = 0
    @shot_count = 0
  end

  def record_shot(pins)
    @score += pins
    @shot_count += 1
  end

  def score
    @score
  end

  def finished?
    @score >= 10 || @shot_count > 1
  end

  def spare?
    @score == 10 && @shot_count > 1
  end

  def strike?
    @score == 10 && @shot_count == 1
  end
end
