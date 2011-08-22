class ChangeValuePointsType < ActiveRecord::Migration
  def self.up
    change_column :army_lists, :value_points, :decimal, :precision => 5, :scale => 1
    change_column :army_list_choices, :value_points, :decimal, :precision => 5, :scale => 1
    change_column :magic_items, :value_points, :decimal, :precision => 5, :scale => 1
    change_column :troops, :value_points, :decimal, :precision => 5, :scale => 1
    change_column :units, :value_points, :decimal, :precision => 5, :scale => 1
    change_column :unit_options, :value_points, :decimal, :precision => 5, :scale => 1
  end

  def self.down
    change_column :unit_options, :value_points, :integer
    change_column :units, :value_points, :integer
    change_column :troops, :value_points, :integer
    change_column :magic_items, :value_points, :integer
    change_column :army_list_choices, :value_points, :integer
    change_column :army_lists, :value_points, :integer
  end
end