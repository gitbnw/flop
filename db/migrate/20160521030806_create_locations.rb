class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.boolean :participant
      t.string :longitude
      t.string :latitude

      t.timestamps null: false
    end
  end
end
