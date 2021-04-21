# frozen_string_literal: true

require 'rails_helper'

describe Game, type: :model do
  let(:game) { described_class.new }

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

    context 'invalid game' do
      it 'returns an error' do
        game.roll(-3)
        expect(game.errors.full_messages).to include('Invalid pin value X or x or / or - or (0 to 9)')
      end
    end
  end
end
