FactoryBot.define do
  factory :residence do
    name { Faker::Address.community }

    association :zone
  end
end
