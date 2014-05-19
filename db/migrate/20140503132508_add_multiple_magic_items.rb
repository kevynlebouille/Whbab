class AddMultipleMagicItems < ActiveRecord::Migration
  def change
    add_column :magic_items, :is_multiple, :boolean, :default => false, :null => false
    add_column :army_list_units_magic_items, :id, :primary_key
    add_column :army_list_units_magic_items, :quantity, :integer, :default => 1, :null => false
  end
end
