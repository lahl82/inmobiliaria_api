FactoryBot.define do
  factory :rating do
    description { Faker::Lorem.sentence(word_count: 50) }

    user
    service
  end
end
