require 'spec_helper'

describe BowlingGame do
  let(:game) { described_class.new }
  let(:frames) { game.frames }
  let(:current_frame) { game.current_frame }

  it 'initializes 10 frames' do
    expect(frames.to_a.size).to eq 10
    expect(frames).to all be_a Frame
  end

  it "assigns for the successors first 9 frames" do
    expect(frames.first(9).map(&:successor)).to all be_a Frame
    expect(frames.to_a.last.successor).to be_nil
  end

  it 'initializes current_frame with the first' do
    expect(game.current_frame).to eq frames.first
  end

  describe '#roll' do
    it 'adds a score on the current frame' do
      game.roll 4
      expect(current_frame.scores.last).to eq 4
    end

    context 'when current frame is over' do
      let!(:successor_frame) { game.current_frame.successor }

      before do
        game.roll 7
        game.roll 3
      end

      it 'points to the successor frame' do
        expect(game.current_frame).to eq successor_frame
      end
    end

    context 'when there are no more frames' do
      before do
        12.times { game.roll 10 }
      end

      it 'raises GameOver' do
        expect {
          game.roll 5
        }.to raise_error
      end
    end
  end
end
