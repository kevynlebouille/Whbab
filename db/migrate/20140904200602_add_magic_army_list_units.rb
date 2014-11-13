class AddMagicArmyListUnits < ActiveRecord::Migration
  class MagicArmyListUnit < ActiveRecord::Base
  end

  def up
    add_column :army_list_units, :magic, :string

    ArmyListUnit.reset_column_information

    Unit.where('magic IS NOT NULL').each do |unit|
      ArmyListUnit.where('unit_id = ?', unit.id).update_all(:magic => unit.magic)

      say "Unit #{unit.name} magic updated!"
    end
  end

  def down
    remove_column :army_list_units, :magic
  end
end
