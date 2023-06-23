class CreateResidences < ActiveRecord::Migration[7.0]
  def change
    create_table :residences do |t|
      t.string :name, null: false
      t.references :zones, null: false, foreign_key: true

      t.timestamps
    end
  end
end
