class AddUserToAppointmentSlots < ActiveRecord::Migration[7.1]
  def change
    add_reference :appointment_slots, :user, null: false, foreign_key: true
  end
end
