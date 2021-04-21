# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "Testuser #{rand(1...1000)}" }
  end
end
