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

  describe '#total_score' do
    before do
      frame.add_score 4
      frame.add_score 5
    end

    it 'sums the scores' do
      expect(frame.total_score).to eq 9
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

  describe '#strike?' do
    context 'when all pins are knocked down' do
      before { frame.add_score 10 }

      it 'is true' do
        expect(frame.strike?).to be true
      end
    end

    context 'when not all pins are knocked down' do
      before { frame.add_score 9 }

      it 'is false' do
        expect(frame.strike?).to be false
      end
    end
  end

  describe '#spare?' do
    context 'when total score is 10' do
      before { allow(frame).to receive(:total_score).and_return 10 }

      it 'is true' do
        expect(frame.spare?).to be true
      end
    end

    context 'when total score is not 10' do
      before { allow(frame).to receive(:total_score).and_return 8 }

      it 'is false' do
        expect(frame.spare?).to be false
      end
    end
  end

  describe '#bonus' do
    let(:successor) { double scores: [5, 2] }

    before { allow(frame).to receive(:successor).and_return successor }

    context 'when strike' do
      before { allow(frame).to receive(:strike?).and_return true }

      it "is the sum of the successor's 2 scores" do
        expect(frame.bonus).to eq 7
      end
    end

    context 'when spare' do
      before { allow(frame).to receive(:spare?).and_return true }

      it "is the successor's first score" do
        expect(frame.bonus).to eq 5
      end
    end

    context 'when not strike, nor spare' do
      before do
        allow(frame).to receive(:strike?).and_return false
        allow(frame).to receive(:spare?).and_return false
      end

      it 'is zero' do
        expect(frame.bonus).to eq 0
      end
    end
  end
end
