class AddValuePointsToUnits < ActiveRecord::Migration
  def self.up
    add_column :units, :value_points, :integer
  end

  def self.down
    remove_column :units, :value_points
  end
end