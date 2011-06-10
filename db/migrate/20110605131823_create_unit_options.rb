class CreateUnitOptions < ActiveRecord::Migration
  def self.up
    create_table :unit_options do |t|
      t.references :unit, :null => false
      t.integer :parent_id
      t.string :label, :null => false
      t.integer :value_points, :null => false
      t.integer :position, :null => false
      t.boolean :is_per_model, :null => false
    end

    add_index :unit_options, :unit_id
    add_index :unit_options, :parent_id
  end

  def self.down
    drop_table :unit_options
  end
end
