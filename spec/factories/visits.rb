FactoryBot.define do
  factory :visit do
    date { Faker::Date.forward(days: 30) }

    association :client
    # association :agent
    association :property
  end
end
