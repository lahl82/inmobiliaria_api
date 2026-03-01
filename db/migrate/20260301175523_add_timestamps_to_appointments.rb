class AddTimestampsToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_timestamps :appointments, default: Time.zone.now, null: false
    change_column_default :appointments, :created_at, from: Time.zone.now, to: nil
    change_column_default :appointments, :updated_at, from: Time.zone.now, to: nil
  end
end
