FactoryBot.define do
  factory :property do
    title { Faker::Lorem.sentence(word_count: 4) }
    description { Faker::Lorem.sentence(word_count: 50) }
    direction { Faker::Address.full_address }
    price { Faker::Commerce.price(range: 1000.0..10_000_000.0) }
    area  { Faker::Number.decimal(l_digits: 3, r_digits: 2).to_f }

    mode { Property.modes.keys.sample }
    type { Property.types.keys.sample }
    state { Property.states.keys.sample }

    qty_bedroom { Faker::Number.between(from: 0, to: 30) }
    qty_bathroom { Faker::Number.between(from: 0, to: 30) }
    qty_floor { Faker::Number.between(from: 0, to: 30) }
    qty_kitchen { Faker::Number.between(from: 0, to: 10) }
    qty_parking { Faker::Number.between(from: 0, to: 30) }
    qty_hall { Faker::Number.between(from: 0, to: 10) }

    is_private { Faker::Boolean.boolean }
    office { Faker::Boolean.boolean }
    shop { Faker::Boolean.boolean }
    yard { Faker::Boolean.boolean }
    garden { Faker::Boolean.boolean }
    social { Faker::Boolean.boolean }
  end
end
