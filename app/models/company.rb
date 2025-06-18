class Company < ApplicationRecord
    has_many :users
    has_many :appointment_slots
    has_many :services
end
