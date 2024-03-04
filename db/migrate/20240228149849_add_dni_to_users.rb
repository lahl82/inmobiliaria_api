class AddDniToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :document_type, :string, null: false
    add_column :users, :dni, :string, null: false

    add_index :users, :dni, unique: true
  end
end
