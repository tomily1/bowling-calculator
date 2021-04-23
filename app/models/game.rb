# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :user, inverse_of: :game, dependent: :destroy

  serialize :frames, Array

  include HasBowlingCalculator
  include HasBowling

  validate :validate_max_allowed_frames
  validate :validate_max_per_frame

  def pin_number_valid?(knocked_pins)
    if (knocked_pins =~ ALLOWED_PINS_REGEX) &&
       knocked_pins.to_i >= 0 &&
       knocked_pins.to_i < MAX_ALLOWED_PINS
      return
    end

    errors.add(:base, 'Invalid pin value X or x or / or - or (0 to 9)')
  end

  def validate_max_allowed_frames
    return if frames.count <= MAX_ALLOWED_FRAMES

    errors.add(:base, 'Max number of frames reached. Game Over!')
  end

  def validate_max_per_frame
    return if frames.count.zero?
    return if frames.last.count <= 2 && frames.last.sum <= 10
    return unless exceeded_maximum_round_per_frame?

    errors.add(:base, "Max number of knocked pins for frame #{frames.count} exceeded!. " \
                      "#{frames.count == 10 && 'End Game.'}")
  end

  def spare_pin_valid?(knocked_pins)
    return unless knocked_pins == '/'

    return unless frames.count.zero? ||
                  frames.last.last == MAX_ALLOWED_PINS ||
                  (frames.count != MAX_ALLOWED_FRAMES && frames.last.count == 2)

    errors.add(:base, 'Invalid spare sequence input')
  end

  private

  def maximum_allowed_frames?
    frames.count > MAX_ALLOWED_FRAMES
  end

  def exceeded_maximum_round_per_frame?
    (frames.last.count > 2 &&
      frames.last.first(2).sum < MAX_ALLOWED_PINS) ||
      frames.last.count > 3 ||
      maximum_allowed_frames?
  end
end
