# frozen_string_literal: true

class User < ApplicationRecord
  has_one :game, inverse_of: :user

  validates :name, presence: true, length: { minimum: 3 }

  before_create do
    build_game(frames: Array.new(21))
  end
end
