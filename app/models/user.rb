# frozen_string_literal: true

class User < ApplicationRecord
  has_one :game, inverse_of: :user, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }

  before_create do
    build_game(frames: [])
  end
end
