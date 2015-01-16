class GameOver < RuntimeError; end

class InvalidNumberOfPins < ArgumentError
  def initialize(current_score)
    message = %{
      You already knocked down #{current_score} pins.
      Only a total of 10 pins can be knocked down every 2 attempts, except in the last round.
    }

    super message
  end
end
