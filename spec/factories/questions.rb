FactoryBot.define do
  factory :question do
    description { Faker::Lorem.sentence(word_count: 50) }

    user
    service
  end
end
