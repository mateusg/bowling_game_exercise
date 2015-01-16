require 'spec_helper'

describe Game do
  let(:game) { described_class.new }
  let(:frames) { game.frames }
  let(:current_frame) { game.current_frame }

  it 'has 10 frames' do
    expect(frames.to_a.size).to eq 10
    expect(frames).to all be_a Frame
  end

  it 'initializes current_frame with the first' do
    expect(game.current_frame).to eq frames.first
  end

  describe '#roll' do
    it 'adds a score on the current frame' do
      game.roll 4
      expect(current_frame.scores.last).to eq 4
    end

    context 'when current frame gets full' do
      let!(:successor_frame) { frames.peek }

      before do
        game.roll 7
        game.roll 3
      end

      it 'points to the successor frame' do
        expect(current_frame).to eq successor_frame
      end
    end
  end
end
