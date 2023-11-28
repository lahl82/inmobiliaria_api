class RenameTypeColumnInProperties < ActiveRecord::Migration[7.0]
  def change
    rename_column :properties, :type, :property_type
  end
end
