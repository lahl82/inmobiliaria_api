FactoryBot.define do
  factory :property do
    association :agent

    title { Faker::Lorem.sentence(word_count: 4) }
    description { Faker::Lorem.sentence(word_count: 50) }
    direction { Faker::Address.full_address }
    price { Faker::Commerce.price(range: 1000.0..10_000_000.0) }
    area  { Faker::Number.decimal(l_digits: 3, r_digits: 2).to_f }
    mode { Property.modes.keys.sample }
    property_type { Property.property_types.keys.sample }
    state { Property.states.keys.sample }

    trait :type_house do
      is_private { Faker::Boolean.boolean }
      qty_bedroom { Faker::Number.between(from: 0, to: 30) }
      qty_bathroom { Faker::Number.between(from: 0, to: 30) }
      qty_floor { Faker::Number.between(from: 0, to: 30) }
      qty_kitchen { Faker::Number.between(from: 0, to: 10) }
      qty_parking { Faker::Number.between(from: 0, to: 30) }
      qty_hall { Faker::Number.between(from: 0, to: 10) }
      office { Faker::Boolean.boolean }
      shop { Faker::Boolean.boolean }
      yard { Faker::Boolean.boolean }
      garden { Faker::Boolean.boolean }
      social { Faker::Boolean.boolean }
    end

    trait :type_apartament_or_annex do
      is_private { Faker::Boolean.boolean }
      qty_bedroom { Faker::Number.between(from: 0, to: 30) }
      qty_bathroom { Faker::Number.between(from: 0, to: 30) }
      qty_kitchen { Faker::Number.between(from: 0, to: 10) }
      qty_hall { Faker::Number.between(from: 0, to: 10) }
      qty_floor { Faker::Number.between(from: 0, to: 30) }
      qty_parking { Faker::Number.between(from: 0, to: 30) }
      social { Faker::Boolean.boolean }
    end

    trait :type_shop do
      is_private { Faker::Boolean.boolean }
      qty_bathroom { Faker::Number.between(from: 0, to: 30) }
      qty_floor { Faker::Number.between(from: 0, to: 30) }
      office { Faker::Boolean.boolean }
    end

    trait :type_shed do
      is_private { Faker::Boolean.boolean }
      qty_bathroom { Faker::Number.between(from: 0, to: 30) }
      qty_floor { Faker::Number.between(from: 0, to: 30) }
      office { Faker::Boolean.boolean }
      shop { Faker::Boolean.boolean }
      yard { Faker::Boolean.boolean }
    end
  end
end
