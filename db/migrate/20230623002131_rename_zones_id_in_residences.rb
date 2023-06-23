class RenameZonesIdInResidences < ActiveRecord::Migration[7.0]
  def change
    rename_column :residences, :zones_id, :zone_id
  end
end
