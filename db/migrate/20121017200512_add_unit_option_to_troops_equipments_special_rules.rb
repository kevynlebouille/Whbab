class AddUnitOptionToTroopsEquipmentsSpecialRules < ActiveRecord::Migration
  def change
    add_column :troops, :unit_option_id, :integer
    add_column :equipments, :unit_option_id, :integer
    add_column :special_rules, :unit_option_id, :integer

    add_index :troops, :unit_option_id
    add_index :equipments, :unit_option_id
    add_index :special_rules, :unit_option_id
  end
end
