# typed: strict
# frozen_string_literal: true

class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.text :description, null: false
      t.integer :score, null: false
      t.string :state
      t.datetime :state_changed_at

      t.references :user, null: false, foreign_key: true
      t.references :request, null: false, foreign_key: true
    end
  end
end
