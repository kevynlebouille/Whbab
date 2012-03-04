class RenameUnitOptionsMaster < ActiveRecord::Migration
  def up
    remove_index :unit_options, :master_id

    rename_column :unit_options, :master_id, :depend_id
    add_index :unit_options, :depend_id
  end

  def down
    remove_index :unit_options, :depend_id

    rename_column :unit_options, :depend_id, :master_id
    add_index :unit_options, :master_id
  end
end