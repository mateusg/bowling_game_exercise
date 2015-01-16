class Frame
  attr_reader :scores

  MAX_NUMBER_OF_SCORES = 2
  STRIKE_SCORE = 10

  def initialize
    @scores = []
  end

  def add_score(pins_knocked_down)
    @scores << pins_knocked_down
  end

  def total_score
    scores.inject &:+
  end

  def full?
    scores.size >= MAX_NUMBER_OF_SCORES
  end

  def strike?
    scores.first == STRIKE_SCORE
  end

  def spare?
    total_score == STRIKE_SCORE
  end
end
