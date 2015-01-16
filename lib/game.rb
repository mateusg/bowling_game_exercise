require_relative 'frame'

class Game
  attr_reader :frames, :current_frame

  def initialize
    @frames = 10.times.map { Frame.new }.to_enum

    next_frame!
  end

  def roll(pins_knocked_down)
    @current_frame.add_score pins_knocked_down

    next_frame! if @current_frame.full?

    pins_knocked_down
  end

  private

  def next_frame!
    @current_frame = @frames.next
  end
end
