class Frame
  attr_accessor :successor

  STANDARD_NUMBER_OF_SCORES = 2
  MAX_NUMBER_OF_SCORES = 3
  STRIKE_SCORE = 10

  def initialize
    @scores = []
  end

  def scores
    @scores.dup
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
    if last? && (strike? || spare?)
      scores.size >= MAX_NUMBER_OF_SCORES
    elsif strike?
      true
    else
      scores.size >= STANDARD_NUMBER_OF_SCORES
    end
  end

  def strike?
    scores.first == STRIKE_SCORE
  end

  def spare?
    sum_of_scores == STRIKE_SCORE
  end

  def last?
    successor.nil?
  end
end
