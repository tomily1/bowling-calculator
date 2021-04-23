# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    resources :users, only: %i[create update destroy]
    resources :games, only: %i[show create update] do
      get :score, on: :member
    end
  end
end
