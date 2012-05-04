class AddNotesToArmyListsAndArmyListUnits < ActiveRecord::Migration
  def change
    add_column :army_lists, :notes, :text
    add_column :army_list_units, :notes, :text
  end
end
