class Frame
  attr_reader :scores

  def initialize
    @scores = []
  end

  def add_score(pins_knocked_down)
    @scores << pins_knocked_down
  end

  def full?
    scores.size >= 2
  end
end
