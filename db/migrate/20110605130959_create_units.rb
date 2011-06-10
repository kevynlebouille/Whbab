class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.references :army, :null => false
      t.references :unit_category, :null => false
      t.string :label, :null => false
      t.integer :min_size, :null => false, :default => 1
      t.integer :max_size
      t.integer :magic_items_value_points
    end

    add_index :units, :army_id
    add_index :units, :unit_category_id
  end

  def self.down
    drop_table :units
  end
end
