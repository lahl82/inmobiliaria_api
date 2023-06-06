FactoryBot.define do
  factory :residence do
    name { Faker::Address.community }
  end
end
