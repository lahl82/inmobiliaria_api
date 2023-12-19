# typed: strict
# frozen_string_literal: true

class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :images, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :aasm_state

      t.references :service_type, null: false, foreign_key: true, on_delete: :cascade
      t.references :user, null: false, foreign_key: true
    end
  end
end
