class Frame
  attr_reader :scores

  MAX_NUMBER_OF_SCORES = 2

  def initialize
    @scores = []
  end

  def add_score(pins_knocked_down)
    @scores << pins_knocked_down
  end

  def full?
    scores.size >= MAX_NUMBER_OF_SCORES
  end
end
