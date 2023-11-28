class ChangeDateDataTypeInVisits < ActiveRecord::Migration[7.0]
  def change
    change_column :visits, :date, :date
  end
end
