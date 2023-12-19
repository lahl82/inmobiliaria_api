class AddJtiToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :email, :string, default: ''
    add_column :users, :jti, :string, null: false
    add_index :users, :jti, unique: true
  end
end
