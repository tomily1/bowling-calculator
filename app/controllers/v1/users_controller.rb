# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    def create
      user = User.new(name: user_params[:name])

      if user.save
        render json: { name: user.name, game_id: user.game.id }, status: :created
      else
        render json: { errors: user.errors }, status: :unprocessable_entity
      end
    end

    def update
      user = User.find_by(id: params[:id])

      return render json: { errors: 'user not found' }, status: :not_found unless user

      if user.update(name: user_params[:name])
        render json: { name: user.name }, status: :ok
      else
        render json: { errors: user.errors }, status: :unprocessible_entity
      end
    end

    def destroy
      user = User.find_by(id: params[:id])

      return render json: { errors: 'user not found' }, status: :not_found unless user

      if user.destroy
        render status: :ok
      else
        render json: { errors: user.errors }, status: :unprocessible_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name)
    end
  end
end
