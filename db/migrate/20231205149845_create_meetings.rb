# typed: strict
# frozen_string_literal: true

class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.datetime :starting, null: false
      t.integer :duration, null: false # en minutos
      t.integer :max_requests, null: false, default: 1
      t.string :state, null: false
      t.datetime :state_changed_at

      t.timestamps

      t.references :service, null: false, foreign_key: true
    end
  end
end
