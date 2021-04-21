# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :user, inverse_of: :game

  include HasBowling
end
