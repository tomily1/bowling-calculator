# frozen_string_literal: true

class V1::UsersController < ApplicationController
  def create; end
  def update; end

  private

  def user_params
    params.require(:users).permit(:name)
  end
end
