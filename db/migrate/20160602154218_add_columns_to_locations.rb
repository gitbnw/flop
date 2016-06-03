class AddColumnsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :name, :string
    add_column :locations, :types, :string, array: true, default: []
    add_column :locations, :place_id, :string
    add_column :locations, :open_now, :string
    add_column :locations, :icon, :string
  end
end
