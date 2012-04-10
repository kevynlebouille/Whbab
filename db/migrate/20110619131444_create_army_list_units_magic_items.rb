class CreateArmyListUnitsMagicItems < ActiveRecord::Migration
  def self.up
    create_table :army_list_units_magic_items, :id => false do |t|
      t.references :army_list_unit, :null => false
      t.references :magic_item, :null => false
    end

    add_index :army_list_units_magic_items, :army_list_unit_id
    add_index :army_list_units_magic_items, :magic_item_id
  end

  def self.down
    drop_table :army_list_units_magic_items
  end
end
