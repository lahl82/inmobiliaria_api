class CreateAppointmentSlotServices < ActiveRecord::Migration[7.1]
  def change
    create_table :appointment_slot_services do |t|
      t.references :appointment_slot, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.string :state
      t.datetime :state_changed_at

      t.timestamps
    end

    add_index :appointment_slot_services, [:appointment_slot_id, :service_id], unique: true
  end
end
