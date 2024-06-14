class RemoveLocationFromWarehouse < ActiveRecord::Migration[7.1]
  def change
    remove_column :warehouses, :location_id, foreign_key: true
  end
end
