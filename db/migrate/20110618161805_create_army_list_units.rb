class CreateArmyListUnits < ActiveRecord::Migration
  def self.up
    create_table :army_list_units do |t|
      t.references :army_list
      t.references :unit
      t.references :unit_category
      t.string :name
      t.integer :value_points
      t.integer :size
      t.integer :position

      t.timestamps
    end

    add_index :army_list_units, :army_list_id
    add_index :army_list_units, :unit_id
    add_index :army_list_units, :unit_category_id
  end

  def self.down
    drop_table :army_list_units
  end
end
