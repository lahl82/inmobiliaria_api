class AddDatabaseDefaultTimestampsToAppointments < ActiveRecord::Migration[7.1]
  def change
    change_column_default :appointments, :created_at, from: nil, to: -> { 'NOW()' }
    change_column_default :appointments, :updated_at, from: nil, to: -> { 'NOW()' }
  end
end
