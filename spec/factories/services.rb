FactoryBot.define do
  factory :service do
    title { Faker::Lorem.sentence(word_count: 4) }
    description { Faker::Lorem.sentence(word_count: 50) }
    price { Faker::Commerce.price(range: 1000.0..10_000_000.0) }

    user
    service_type
  end
end
