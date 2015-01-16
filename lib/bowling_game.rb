require_relative 'errors'
require_relative 'frame'

class BowlingGame
  attr_reader :frames, :current_frame

  def initialize
    @frames = 10.times.map { Frame.new }.to_enum

    setup_frames!
    next_frame!
  end

  def roll(pins_knocked_down)
    raise GameOver if over?

    @current_frame.add_score pins_knocked_down

    if over?
      # puts 'GAME OVER'
    elsif @current_frame.over?
      next_frame!
    end

    pins_knocked_down
  end

  private

  def over?
    @current_frame.last? && @current_frame.over?
  end

  def next_frame!
    @current_frame = @frames.next
  end

  def setup_frames!
    while true do
      frame = @frames.next
      frame.successor = @frames.peek
    end
  rescue StopIteration => e
    @frames.rewind
  end
end
