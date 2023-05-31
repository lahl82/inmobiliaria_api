class CreateVisits < ActiveRecord::Migration[7.0]
  def change
    create_table :visits do |t|
      t.datetime :date, null: false
      t.references :property, null: false, foreign_key: true, on_delete: :cascade
      t.references :customer, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
