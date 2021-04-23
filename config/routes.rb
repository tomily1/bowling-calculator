# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    resources :users, only: %i[create update]
    resources :games, only: %i[show create update]
  end
end
