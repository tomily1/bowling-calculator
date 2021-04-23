# frozen_string_literal: true

module HasBowlingCalculator
  def calculate_score
    score = 0
    frame_index = 0

    10.times do |_frame|
      if strike?(frame_index)
        score += (10 + strike_bonus(frame_index))
        frame_index += 1
      elsif spare?(frame_index)
        score += (10 + spare_bonus(frame_index))
        frame_index += 2
      else
        score += sum_of_balls_in_frame(frame_index)
        frame_index += 2
      end

      break if frames.flatten[frame_index].nil?
    end

    score
  end

  private

  def strike?(frame_index)
    point_at(frame_index) == 10
  end

  def spare?(frame_index)
    (point_at(frame_index) + point_at(frame_index + 1)) == 10
  end

  def sum_of_balls_in_frame(frame_index)
    point_at(frame_index) + point_at(frame_index + 1)
  end

  def spare_bonus(frame_index)
    point_at(frame_index + 2)
  end

  def strike_bonus(frame_index)
    point_at(frame_index + 1) + point_at(frame_index + 2)
  end

  def point_at(index)
    frames.flatten[index].to_i
  end
end
