class AddMagicArmyListUnits < ActiveRecord::Migration
  class MagicArmyListUnit < ActiveRecord::Base
  end

  def up
    add_column :army_list_units, :magic, :string

    MagicArmyListUnit.reset_column_information

    Unit.where('magic IS NOT NULL').each do |unit|
      unit.army_list_units.map{ |alu| alu.update_attributes!(:magic => alu.unit.magic) }

      say "Unit #{unit.name} magic updated!"
    end
  end

  def down
    remove_column :army_list_units, :magic
  end
end
