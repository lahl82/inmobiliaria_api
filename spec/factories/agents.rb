FactoryBot.define do
  factory :agent do
    name { Faker::Name.name }
    last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
    address { Faker::Address.full_address }
    agency { Faker::Lorem.sentence(word_count: 3) }
    avatar { Faker::Avatar.image(size: '50x50') }
  end
end
