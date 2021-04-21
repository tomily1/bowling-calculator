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
        game.roll(5)
        game.roll(5)
        game.roll(3)
        roll_many(17, 0)
        expect(game.calculate_score).to eq(16)
      end
    end
  end
end
