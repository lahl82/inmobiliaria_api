class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.integer :role, default: 2
      t.boolean :temporal_password, default: false

      t.timestamps
    end
  end
end
