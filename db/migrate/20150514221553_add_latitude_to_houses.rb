class AddLatitudeToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :latitude, :decimal, default: 0.0
    add_column :houses, :longitude, :decimal, default: 0.0
  end
end
