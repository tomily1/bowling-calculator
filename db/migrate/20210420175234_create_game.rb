# frozen_string_literal: true

class CreateGame < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.belongs_to :user

      t.string :frames
      t.integer :cumulative_score

      t.timestamps
    end
  end
end
