class RefactorMagicItemsLimitations < ActiveRecord::Migration
  def self.up
    add_column :unit_options, :is_magic_items, :boolean, :null => false
    add_column :unit_options, :is_magic_standards, :boolean, :null => false
    remove_column :units, :max_magic_items_value_points
    remove_column :units, :max_magic_standards_value_points
  end

  def self.down
    add_column :units, :max_magic_standards_value_points, :integer
    add_column :units, :max_magic_items_value_points, :integer
    remove_column :unit_options, :is_magic_standards
    remove_column :unit_options, :is_magic_items
  end
end
