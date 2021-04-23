# frozen_string_literal: true

require 'rails_helper'

describe Game, type: :model do
  let(:game) { described_class.new(user: build(:user)) }

  describe '#calculate_score' do
    def roll_many(count, knocked_pins)
      count.times { game.roll(knocked_pins) }
    end

    context 'gutter game' do
      it 'equals 0 total' do
        roll_many(20, 0)
        expect(game.calculate_score).to eq(0)
      end
    end

    context 'all 1 game' do
      it 'equals 20 total' do
        roll_many(20, 1)
        expect(game.calculate_score).to eq(20)
      end
    end

    context 'one spare game' do
      it 'calculates the total' do
        game.roll(3)
        game.roll('/')
        game.roll(3)
        roll_many(17, 0)
        expect(game.calculate_score).to eq(16)
      end
    end

    context 'one strike game' do
      it 'calculates the total' do
        game.roll('X')
        game.roll(3)
        game.roll(4)
        roll_many(17, 0)
        expect(game.calculate_score).to eq(24)
      end
    end

    context 'perfect game' do
      it 'calculates the total' do
        roll_many(12, 'X')
        expect(game.calculate_score).to eq(300)
      end
    end

    context 'for valid game' do
    end

    context 'for invalid game' do
      it 'should return an error for more than 10 pins input' do
        game.roll(30)
        expect(game.errors.full_messages).to include('Invalid pin value X or x or / or - or (0 to 9)')
      end

      it 'should return an error for more than 21 rolls for valid extra roll' do
        roll_many(19, 3)
        roll_many(2, 7)

        expect(game.roll(3)).to be_falsey

        expect(game.errors.full_messages).to include('Max number of knocked pins for frame 10 exceeded!. End Game.')
      end

      it 'should allow only two tries for the 10th game if no spare or strike' do
        roll_many(20, 1)
        game.roll(1)

        expect(game.errors.full_messages).to include('Max number of knocked pins for frame 10 exceeded!. End Game.')
      end
    end
  end
end
