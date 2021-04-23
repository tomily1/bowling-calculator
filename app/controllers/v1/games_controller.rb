# frozen_string_literal: true

module V1
  class GamesController < ApplicationController
    def show; end

    def update
      game = Game.find_by(id: params[:id])

      if game
        if game.roll(game_params[:pins])
          BowlingCalculatorWorker.perform_async(game.id)
          render json: { game_id: game.id }, status: :ok
        else
          render json: { errors: game.errors }, status: :unprocessable_entity
        end
      else
        render json: { errors: 'game not found' }, status: :not_found
      end
    end

    def score
      game = Game.find_by(id: params[:id])

      if game
        BowlingCalculatorWorker.perform_async(game.id)
        render json: { score: game.cumulative_score.to_i, game_id: game.id }, status: :ok
      else
        render json: { errors: 'game not found' }, status: :not_found
      end
    end

    private

    def game_params
      params.require(:game).permit(:pins)
    end
  end
end
