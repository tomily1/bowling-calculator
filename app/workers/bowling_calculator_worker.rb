class BowlingCalculatorWorker
  include Sidekiq::Worker

  def perform(id)
    game =  Game.find_by(id: id)
    if game.present?
      game.with_lock do
        game.calculate_score
        game.save!
      end
    end
  end
end
