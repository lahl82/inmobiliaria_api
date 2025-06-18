# typed: strict
# frozen_string_literal: true

class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.string :state
      t.datetime :state_changed_at
      
      t.references :appointment_slot_service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end
end
