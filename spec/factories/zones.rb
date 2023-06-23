FactoryBot.define do
  factory :zone do
    name { Faker::Address.street_name }

    association :city
  end
end
