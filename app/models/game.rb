# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :user, inverse_of: :game

  serialize :frames, Array

  include HasBowling

  def pin_number_valid?(knocked_pins)
    errors.add(:base, 'Invalid pin value X or x or / or - or (0 to 9)') unless knocked_pins =~/\A(x|X|-|\/|[0-9])*\z/
  end
end
