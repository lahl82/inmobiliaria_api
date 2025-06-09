class AppointmentSlotService < ApplicationRecord
  belongs_to :appointment_slot
  belongs_to :service
end
