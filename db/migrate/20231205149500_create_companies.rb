class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :state
      t.datetime :state_changed_at

      t.timestamps
    end
  end
end
