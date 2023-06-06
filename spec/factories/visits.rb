FactoryBot.define do
  factory :visit do
    date { Faker::Date.forward(days: 30) }
  end
end
