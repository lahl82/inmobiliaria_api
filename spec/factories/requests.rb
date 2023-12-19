# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :request do
    date { Faker::Time.forward(days: 10) }

    association :user
    association :service
  end
end
