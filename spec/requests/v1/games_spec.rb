# frozen_string_literal: true

require 'rails_helper'

describe 'POST v1/game', type: :request do
  let!(:user) { create(:user) }

  context 'valid sequence' do
    it 'updates game frames' do
      ['9', '/', 'X', 'X', 'X', '3', '-', '7', '/', 4, '/', 'X', 8, '/', 'X'].each do |knocked_pins|
        put "/v1/games/#{user.game.id}", params: { game: { pins: knocked_pins } }

        expect(BowlingCalculatorWorker).to have_enqueued_sidekiq_job(user.game.id)

        expect(response.code).to eq '200'
      end

      record = Game.find_by(id: user.game.id)

      expect(record.frames.count).to eq 10
    end

    it 'updates the game frames' do
      %w[x x].each do |knocked_pins|
        put "/v1/games/#{user.game.id}", params: { game: { pins: knocked_pins } }

        expect(BowlingCalculatorWorker).to have_enqueued_sidekiq_job(user.game.id)

        expect(response.code).to eq '200'
      end

      record = Game.find_by(id: user.game.id)

      expect(record.frames.count).to eq 2
    end
  end

  context 'invalid game id' do
    it 'does not update the game frames' do
      %w[1 2].each do |knocked_pins|
        put '/v1/games/test', params: { game: { pins: knocked_pins } }

        expect(BowlingCalculatorWorker).not_to have_enqueued_sidekiq_job(user.game.id)

        expect(response.code).to eq '404'
      end
    end
  end

  context 'invalid sequence' do
    it 'does not update the game frames' do
      ['/', '/'].each do |knocked_pins|
        put "/v1/games/#{user.game.id}", params: { game: { pins: knocked_pins } }

        expect(BowlingCalculatorWorker).not_to have_enqueued_sidekiq_job(user.game.id)

        expect(response.code).to eq '422'
      end

      record = Game.find_by(id: user.game.id)

      expect(record.frames.count).to eq 0
    end
  end
end
