class RemoveServiceIdFromAppointmentSlots < ActiveRecord::Migration[7.1]
  def change
    remove_reference :appointment_slots, :service, foreign_key: true
  end
end
