# typed: strict
# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.text :description, null: false
      t.datetime :sent_at, null: false
      t.string :state, null: false
      t.datetime :state_changed_at

      t.timestamps

      t.references :appointment, null: false, foreign_key: true
    end
  end
end
