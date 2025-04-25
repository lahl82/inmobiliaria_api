# typed: strict
# frozen_string_literal: true

class CreateServiceTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :service_types do |t|
      t.string :name, null: false
      t.string :state
      t.datetime :state_changed_at
      
      t.timestamps
    end
  end
end
