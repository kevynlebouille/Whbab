class AddOverrideIdToMagicItems < ActiveRecord::Migration
  def change
    add_column :magic_items, :override_id, :integer
    add_index :magic_items, :override_id
  end
end
