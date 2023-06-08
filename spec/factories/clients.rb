FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.full_address }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }

    association :user
  end
end
