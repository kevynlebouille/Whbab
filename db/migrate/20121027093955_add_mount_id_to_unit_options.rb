class AddMountIdToUnitOptions < ActiveRecord::Migration
  def change
    add_column :unit_options, :mount_id, :integer
    add_index :unit_options, :mount_id
  end
end
