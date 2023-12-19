FactoryBot.define do
  factory :question do
    description { Faker::Lorem.sentence(word_count: 50) }

    association :user
    association :service
  end
end
