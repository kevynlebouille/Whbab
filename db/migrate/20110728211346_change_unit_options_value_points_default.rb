class ChangeUnitOptionsValuePointsDefault < ActiveRecord::Migration
  def self.up
    change_column :unit_options, :value_points, :integer, :null => true, :default => nil
  end

  def self.down
    change_column :unit_options, :value_points, :integer, :null => false, :default => 0
  end
end