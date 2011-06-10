class RenameLabelToName < ActiveRecord::Migration
  def self.up
    rename_column :armies, :label, :name
    rename_column :equipments, :label, :name
    rename_column :magic_item_categories, :label, :name
    rename_column :magic_items, :label, :name
    rename_column :special_rules, :label, :name
    rename_column :troop_types, :label, :name
    rename_column :troops, :label, :name
    rename_column :unit_categories, :label, :name
    rename_column :unit_options, :label, :name
    rename_column :units, :label, :name
  end

  def self.down
    rename_column :units, :name, :label
    rename_column :unit_options, :name, :label
    rename_column :unit_categories, :name, :label
    rename_column :troops, :name, :label
    rename_column :troop_types, :name, :label
    rename_column :special_rules, :name, :label
    rename_column :magic_items, :name, :label
    rename_column :magic_item_categories, :name, :label
    rename_column :equipments, :name, :label
    rename_column :armies, :name, :label
  end
end