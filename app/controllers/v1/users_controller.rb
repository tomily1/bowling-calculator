class UsersController < ApplicationController

  def create
  end

private

  def user_params
    params.require(:users).permit(:name)
  end
end
