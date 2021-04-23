# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :user, inverse_of: :game, dependent: :destroy

  serialize :frames, Array

  ALLOWED_PINS_REGEX = %r{\A(x|X|-|/|[0-9])*\z}.freeze
  MAX_ALLOWED_FRAMES = 10
  MAX_ALLOWED_PINS = 10

  include HasBowling

  validate :validate_maximum_allowed_for_last_frame
  validate :validate_max_allowed_frames

  def pin_number_valid?(knocked_pins)
    if (knocked_pins =~ ALLOWED_PINS_REGEX) && knocked_pins.to_i >= 0 && knocked_pins.to_i < MAX_ALLOWED_PINS
      return
    end

    errors.add(:base, 'Invalid pin value X or x or / or - or (0 to 9)')
  end

  def validate_max_allowed_frames
    return if frames.count <= MAX_ALLOWED_FRAMES

    errors.add(:base, 'Max number of frames reach. Game Over!')
  end

  def validate_maximum_allowed_for_last_frame
    return unless frames.count == MAX_ALLOWED_FRAMES

    if (frames.last.count > 2 &&
        frames.last.first(2).sum < MAX_ALLOWED_PINS) ||
       frames.last.count > 3
      errors.add(:base, 'Max number of knocked pins reached for round 10. Game Over!')
    end
  end

  def spare_pin_valid?(knocked_pins)
    return unless knocked_pins == '/'

    if frames.count.zero? || frames.last.last == 'X' || (frames.count != MAX_ALLOWED_FRAMES && frames.last.count == 2)
      errors.add(:base, 'Invalid spare sequence input')
    end
  end
end
