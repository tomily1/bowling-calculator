# frozen_string_literal: true

class BowlingCalculatorWorker
  include Sidekiq::Worker

  def perform(id)
    game = Game.find_by(id: id)
    return unless game.present?

    game.with_lock do
      game.calculate_score
      game.save!
    end
  end
end
