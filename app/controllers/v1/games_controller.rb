# frozen_string_literal: true

module V1
  class GamesController < ApplicationController
    before_action :fetch_game

    def show
      render json: { game_id: @game.id, frames: @game.frames }, status: :ok
    end

    def update
      if @game.roll(game_params[:pins])
        BowlingCalculatorWorker.perform_async(@game.id)
        render json: { game_id: @game.id, frames: @game.frames }, status: :ok
      else
        render json: { errors: @game.errors }, status: :unprocessable_entity
      end
    end

    def score
      BowlingCalculatorWorker.perform_async(@game.id)
      render json: { score: @game.cumulative_score.to_i, game_id: @game.id }, status: :ok
    end

    private

    def fetch_game
      @game = Game.find_by(id: params[:id])

      render json: { errors: 'game not found' }, status: :not_found unless @game
    end

    def game_params
      params.require(:game).permit(:pins)
    end
  end
end
