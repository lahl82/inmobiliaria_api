class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :last_name, null: false
      t.string :address, null: false
      t.string :phone, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
