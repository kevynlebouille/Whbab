class CreateArmyListUnitsMagicStandards < ActiveRecord::Migration
  def up
    create_table :army_list_units_magic_standards, :id => false do |t|
      t.references :army_list_unit, :null => false
      t.references :magic_standard, :null => false
    end

    add_index :army_list_units_magic_standards, :army_list_unit_id
    add_index :army_list_units_magic_standards, :magic_standard_id
  end

  def down
    drop_table :army_list_units_magic_standards
  end
end
