class AddLatLonToLocations < ActiveRecord::Migration
  def change
    # add_column :locations, :latitude, :decimal, :precision => 15, :scale => 13
    # add_column :locations, :longitude, :decimal, :precision => 15, :scale => 13
    add_column :locations, :latitude, :float
    add_column :locations, :longitude, :float
  end
end
