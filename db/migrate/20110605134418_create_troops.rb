class CreateTroops < ActiveRecord::Migration
  def self.up
    create_table :troops do |t|
      t.references :unit, :null => false
      t.references :troop_type, :null => false
      t.string :label, :null => false
      t.integer :value_points, :null => false
      t.integer :position, :null => false
      t.boolean :is_character, :null => false, :default => false
      t.boolean :is_special, :null => false, :default => false
      t.integer :M, :limit => 5
      t.integer :WS, :limit => 5
      t.integer :BS, :limit => 5
      t.integer :S, :limit => 5
      t.integer :T, :limit => 5
      t.integer :W, :limit => 5
      t.integer :I, :limit => 5
      t.integer :A, :limit => 5
      t.integer :LD, :limit => 5
    end

    add_index :troops, :troop_type_id
    add_index :troops, :unit_id
  end

  def self.down
    drop_table :troops
  end
end
