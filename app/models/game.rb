# frozen_string_literal: true

class Game < ApplicationRecord
  serialize :frames, Array

  def roll(knocked_pins)
    frames << knocked_pins
  end

  def calculate_score; end
end
