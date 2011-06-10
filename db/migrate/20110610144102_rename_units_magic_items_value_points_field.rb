class RenameUnitsMagicItemsValuePointsField < ActiveRecord::Migration
  def self.up
    rename_column :units, :magic_items_value_points, :max_magic_items_value_points
  end

  def self.down
    rename_column :units, :max_magic_items_value_points, :magic_items_value_points
  end
end