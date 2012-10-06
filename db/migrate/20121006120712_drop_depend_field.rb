class DropDependField < ActiveRecord::Migration
  def up
    remove_index :unit_options, :depend_id
    remove_column :unit_options, :depend_id
  end

  def down
    add_column :unit_options, :depend_id, :integer
    add_index :unit_options, :depend_id
  end
end
