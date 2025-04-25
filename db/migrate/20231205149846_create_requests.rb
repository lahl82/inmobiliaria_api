# typed: strict
# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :state
      t.datetime :state_changed_at
      
      t.references :meeting, null: false, foreign_key: true, on_delete: :cascade
      t.references :user, null: false, foreign_key: true, on_delete: :cascade
    end
  end
end
