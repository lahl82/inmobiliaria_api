FactoryBot.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password(min_length: 8) }
    role { 2 }
    temporal_password { false }
  end
end
