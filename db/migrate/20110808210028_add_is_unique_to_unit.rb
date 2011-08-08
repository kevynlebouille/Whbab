class AddIsUniqueToUnit < ActiveRecord::Migration
  def self.up
    add_column :units, :is_unique, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :units, :is_unique
  end
end
