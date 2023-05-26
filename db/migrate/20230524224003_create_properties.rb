class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      # t.boolean :available, default: true
      # t.boolean :suspended, default: false
      # t.boolean :sold_in
      # t.boolean :sold_out
      t.string :title, null: false
      t.text :description, null: false
      t.string :images, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.float :area
      t.integer :mode
      t.integer :type
      t.integer :state

      t.integer :qty_bedroom
      t.integer :qty_bathroom
      t.integer :qty_floor
      t.integer :qty_kitchen
      t.integer :qty_parking
      t.integer :qty_hall

      t.boolean :private
      t.boolean :office, default: false
      t.boolean :shop, default: false
      t.boolean :yard, default: false
      t.boolean :garden, default: false
      t.boolean :social, default: false

      t.references :agent, null: false, foreign_key: true
      t.references :residences, default: undefined
      t.references :zones

      t.timestamps
    end
  end
end
