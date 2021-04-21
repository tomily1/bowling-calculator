# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :user, inverse_of: :game

  serialize :frames, Array

  ALLOWED_PINS_REGEX = %r{\A(x|X|-|/|[0-9])*\z}.freeze

  include HasBowling

  def pin_number_valid?(knocked_pins)
    return if (knocked_pins =~ ALLOWED_PINS_REGEX) && knocked_pins.to_i >= 0

    errors.add(:base, 'Invalid pin value X or x or / or - or (0 to 9)')
  end
end
