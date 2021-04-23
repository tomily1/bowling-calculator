# frozen_string_literal: true

module V1
  class GamesController < ApplicationController
    def show; end

    def update
      game = Game.find_by(id: params[:id])

      if game
        if game.roll(game_params[:pins])
          render status: :ok
        else
          render json: { errors: game.errors }, status: :unprocessable_entity
        end
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
