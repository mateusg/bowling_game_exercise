require 'spec_helper'

describe Frame do
  let(:frame) { described_class.new }

  it 'initializes with no score' do
    expect(frame.scores).to be_empty
  end

  describe '#add_score' do
    it 'adds a score' do
      frame.add_score 3
      expect(frame.scores.last).to eq 3
    end
  end

  describe '#full?' do
    context 'when has 1 score' do
      before do
        frame.add_score 9
      end

      it 'is false' do
        expect(frame.full?).to be false
      end
    end

    context 'when has 2 scores' do
      before do
        frame.add_score 4
        frame.add_score 2
      end

      it 'is true' do
        expect(frame.full?).to be true
      end
    end
  end
end
