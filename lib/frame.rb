class Frame
  attr_reader :scores
  attr_accessor :successor

  MAX_NUMBER_OF_SCORES = 2
  STRIKE_SCORE = 10

  def initialize
    @scores = []
  end

  def add_score(pins_knocked_down)
    @scores << pins_knocked_down
  end

  def total_score
    sum_of_scores + bonus
  end

  def sum_of_scores
    scores.inject :+
  end

  def bonus
    if strike?
      successor.scores.slice(0..1).map(&:to_i).inject :+
    elsif spare?
      successor.scores.first.to_i
    else
      0
    end
  end

  def over?
    scores.size >= MAX_NUMBER_OF_SCORES
  end

  def strike?
    scores.first == STRIKE_SCORE
  end

  def spare?
    sum_of_scores == STRIKE_SCORE
  end
end
