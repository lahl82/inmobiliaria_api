# typed: strict
# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :description, null: false
      t.string :aasm_state

      t.references :user, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
    end
  end
end
