class CreateArmyListUnitTroops < ActiveRecord::Migration
  def up
    create_table :army_list_unit_troops do |t|
      t.references :army_list_unit, :null => false
      t.references :troop, :null => false
      t.integer :size
      t.integer :position
    end

    add_index :army_list_unit_troops, :army_list_unit_id
    add_index :army_list_unit_troops, :troop_id
  end

  def down
    drop_table :army_list_unit_troops
  end
end
