class RemoveFieldsFromTroops < ActiveRecord::Migration
  def self.up
    remove_column :troops, :is_character
    remove_column :troops, :is_special
  end

  def self.down
    add_column :troops, :is_special, :boolean, :default => false, :null => false
    add_column :troops, :is_character, :boolean, :default => false, :null => false
  end
end
