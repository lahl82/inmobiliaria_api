# typed: strict
# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :description, null: false
      t.text :answer
      t.string :state
      t.datetime :state_changed_at
      
      t.timestamps

      t.references :user, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
    end
  end
end
