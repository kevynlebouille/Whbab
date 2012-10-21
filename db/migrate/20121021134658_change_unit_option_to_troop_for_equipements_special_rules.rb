class ChangeUnitOptionToTroopForEquipementsSpecialRules < ActiveRecord::Migration
  def up
    remove_index :equipments, :unit_option_id
    remove_index :special_rules, :unit_option_id

    remove_column :equipments, :unit_option_id
    remove_column :special_rules, :unit_option_id

    add_column :equipments, :troop_id, :integer
    add_column :special_rules, :troop_id, :integer

    add_index :equipments, :troop_id
    add_index :special_rules, :troop_id
  end

  def down
    remove_index :equipments, :troop_id
    remove_index :special_rules, :troop_id

    remove_column :equipments, :troop_id
    remove_column :special_rules, :troop_id

    add_column :equipments, :unit_option_id, :integer
    add_column :special_rules, :unit_option_id, :integer

    add_index :equipments, :unit_option_id
    add_index :special_rules, :unit_option_id
  end
end
