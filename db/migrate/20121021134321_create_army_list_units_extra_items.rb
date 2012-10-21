class CreateArmyListUnitsExtraItems < ActiveRecord::Migration
  def change
    create_table :army_list_units_extra_items, :id => false do |t|
      t.references :army_list_unit, :null => false
      t.references :extra_item, :null => false
    end

    add_index :army_list_units_extra_items, :army_list_unit_id
    add_index :army_list_units_extra_items, :extra_item_id
  end
end
