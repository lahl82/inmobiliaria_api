class RenameCitiesIdInZones < ActiveRecord::Migration[7.0]
  def change
    rename_column :zones, :cities_id, :city_id
  end
end
