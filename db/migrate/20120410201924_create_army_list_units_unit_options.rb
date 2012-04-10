class CreateArmyListUnitsUnitOptions < ActiveRecord::Migration
  def self.up
    create_table :army_list_units_unit_options, :id => false do |t|
      t.references :army_list_unit, :null => false
      t.references :unit_option, :null => false
    end

    add_index :army_list_units_unit_options, :army_list_unit_id
    add_index :army_list_units_unit_options, :unit_option_id
  end

  def self.down
    drop_table :army_list_units_unit_options
  end
end
