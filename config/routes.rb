# frozen_string_literal: true

Rails.application.routes.draw do
  
  namespace :v1 do
    resources :users, only: %i[create update]
  end
end
