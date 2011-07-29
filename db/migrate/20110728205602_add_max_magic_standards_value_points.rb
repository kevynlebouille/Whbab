class AddMaxMagicStandardsValuePoints < ActiveRecord::Migration
  def self.up
    add_column :units, :max_magic_standards_value_points, :integer
  end

  def self.down
    remove_column :units, :max_magic_standards_value_points
  end
end