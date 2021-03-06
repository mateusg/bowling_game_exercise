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

    context 'when not last frame' do
      before { allow(frame).to receive(:last?).and_return false }

      context 'when the pins knocked down is greater than 10' do
        it 'raises an error' do
          expect {
            frame.add_score 12
          }.to raise_error /Only a total of 10 pins can be knocked/
        end
      end

      context 'when the sum of pins knocked down plus the score of the frame is greater than 10' do
        before do
          allow(frame).to receive(:sum_of_scores).and_return 9
        end

        it 'raises an error' do
          expect {
            frame.add_score 2
          }.to raise_error /Only a total of 10 pins can be knocked/
        end
      end
    end
  end

  describe '#sum_of_scores' do
    before do
      frame.add_score 4
      frame.add_score 5
    end

    it 'sums the scores' do
      expect(frame.sum_of_scores).to eq 9
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

  describe '#total_score' do
    before do
      frame.add_score 4
      allow(frame).to receive(:bonus).and_return bonus
    end

    context 'when bonus is zero' do
      let(:bonus) { 0 }

      it 'is the sum of scores' do
        expect(frame.total_score).to eq frame.sum_of_scores
      end
    end

    context 'when bonus is not zero' do
      let(:bonus) { 5 }

      it 'is the sum of scores and the bonus' do
        expect(frame.total_score).to eq frame.sum_of_scores + bonus
      end
    end
  end

  describe '#over?' do
    context 'when not on the last frame' do
      before { allow(frame).to receive(:last?).and_return false }

      context 'when rolls a strike' do
        before { frame.add_score 10 }

        it 'is true' do
          expect(frame.over?).to be true
        end
      end

      context 'when has 1 score that is not a strike' do
        before { frame.add_score 9 }

        it 'is false' do
          expect(frame.over?).to be false
        end
      end

      context 'when has 2 scores' do
        before do
          frame.add_score 4
          frame.add_score 2
        end

        it 'is true' do
          expect(frame.over?).to be true
        end
      end
    end

    context 'when on the last frame' do
      before { allow(frame).to receive(:last?).and_return true }

      context 'when rolls a strike' do
        before do
          frame.add_score 10
        end

        it 'is allowed to roll 2 extra times' do
          expect(frame.over?).to be false

          frame.add_score 4
          expect(frame.over?).to be false

          frame.add_score 10
          expect(frame.over?).to be true
        end
      end

      context 'when rolls a spare' do
        before do
          frame.add_score 6
          frame.add_score 4
        end

        it 'is allowed to roll 1 extra time' do
          expect(frame.over?).to be false

          frame.add_score 10
          expect(frame.over?).to be true
        end
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
    context 'when the sum of scores is 10' do
      before do
        frame.add_score 8
        frame.add_score 2
      end

      it 'is true' do
        expect(frame.spare?).to be true
      end
    end

    context 'when the sum of scores is not 10' do
      before do
        frame.add_score 8
        frame.add_score 1
      end

      it 'is false' do
        expect(frame.spare?).to be false
      end
    end
  end

  describe '#last?' do
    before { frame.successor = successor }

    context 'when has no successor' do
      let(:successor) { nil }

      it 'is true' do
        expect(frame.last?).to be true
      end
    end

    context 'when has successor' do
      let(:successor) { double }

      it 'is false' do
        expect(frame.last?).to be false
      end
    end
  end
end
