FactoryBot.define do
  factory :property do
    title { Faker::Lorem.sentence(word_count: 4) }
    description { Faker::Lorem.sentence(word_count: 50) }
    direction { Faker::Address.full_address }
    price { Faker::Commerce.price(range: 1000.0..10_000_000.0) }
    area  { Faker::Number.decimal(l_digits: 3, r_digits: 2).to_f }

    mode { rand(0..1).round }
    type { rand(0..4).round }
    state { rand(0..3).round }

    qty_bedroom { rand(0..30).round }
    qty_bathroom { rand(0..30).round }
    qty_floor { rand(0..30).round }
    qty_kitchen { rand(0..10).round }
    qty_parking { rand(0..30).round }
    qty_hall { rand(0..10).round }

    send(:private) { Faker::Boolean.boolean }
    office { Faker::Boolean.boolean }
    shop { Faker::Boolean.boolean }
    yard { Faker::Boolean.boolean }
    garden { Faker::Boolean.boolean }
    social { Faker::Boolean.boolean }
  end
end
