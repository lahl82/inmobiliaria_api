# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name.gsub('.', '') }
    last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
    address { Faker::Address.full_address }
    avatar { Faker::Avatar.image(size: '50x50') }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    role { 2 }
  end
end
