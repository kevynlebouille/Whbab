class ChangeTroopsColumns < ActiveRecord::Migration
  def self.up
    change_column :troops, :troop_type_id, :integer, :null => true
    change_column :troops, :value_points, :integer, :null => true, :default => nil

    change_column :troops, :M, :string, :limit => 5
    change_column :troops, :WS, :string, :limit => 5
    change_column :troops, :BS, :string, :limit => 5
    change_column :troops, :S, :string, :limit => 5
    change_column :troops, :T, :string, :limit => 5
    change_column :troops, :W, :string, :limit => 5
    change_column :troops, :I, :string, :limit => 5
    change_column :troops, :A, :string, :limit => 5
    change_column :troops, :LD, :string, :limit => 5
  end

  def self.down
    change_column :troops, :troop_type_id, :integer, :null => false
    change_column :troops, :value_points, :integer, :null => false, :default => 0

    change_column :troops, :M, :integer, :limit => 5
    change_column :troops, :WS, :integer, :limit => 5
    change_column :troops, :BS, :integer, :limit => 5
    change_column :troops, :S, :integer, :limit => 5
    change_column :troops, :T, :integer, :limit => 5
    change_column :troops, :W, :integer, :limit => 5
    change_column :troops, :I, :integer, :limit => 5
    change_column :troops, :A, :integer, :limit => 5
    change_column :troops, :LD, :integer, :limit => 5
  end
end