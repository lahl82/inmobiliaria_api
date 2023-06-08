class RenamePrivateColumnInProperties < ActiveRecord::Migration[7.0]
  def change
    rename_column :properties, :private, :is_private
  end
end
