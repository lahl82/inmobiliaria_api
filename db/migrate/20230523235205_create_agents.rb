class CreateAgents < ActiveRecord::Migration[7.0]
  def change
    create_table :agents do |t|
      t.string :name, null: false
      t.string :last_name, null: false
      t.string :phone, null: false
      t.text :address
      t.string :agency, null: false
      t.string :avatar
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
