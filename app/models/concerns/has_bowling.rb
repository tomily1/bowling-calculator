# frozen_string_literal: true

module HasBowling
  ALLOWED_PINS_REGEX = %r{\A(x|X|-|/|[0-9])*\z}.freeze
  MAX_ALLOWED_FRAMES = 10
  MAX_ALLOWED_PINS = 10

  def pin_value(knocked_pins)
    case knocked_pins.to_s.upcase
    when 'X'
      10
    when '/'
      10 - frames.flatten.last
    when '-'
      0
    else
      knocked_pins.to_i
    end
  end

  def roll(knocked_pins)
    spare_pin_valid?(knocked_pins.to_s.upcase)
    pin_number_valid?(knocked_pins.to_s.upcase)
    return if errors.present?

    build_frame_for(knocked_pins)

    valid? && save
  end

  def build_frame_for(knocked_pins)
    last_frame = frames.last

    if frames.count < MAX_ALLOWED_FRAMES &&
       (last_frame.nil? ||
         last_frame.count == 2 ||
         last_frame.sum == MAX_ALLOWED_FRAMES)
      add_new_frame_for(knocked_pins)
    else
      add_score_for_frame(knocked_pins)
    end
  end

  def add_new_frame_for(knocked_pins)
    frames << [pin_value(knocked_pins)]
  end

  def add_score_for_frame(knocked_pins)
    frames.last << pin_value(knocked_pins)
  end
end
