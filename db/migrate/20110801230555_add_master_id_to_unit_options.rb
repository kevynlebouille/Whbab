class AddMasterIdToUnitOptions < ActiveRecord::Migration
  def self.up
    add_column :unit_options, :master_id, :integer
    add_index :unit_options, :master_id
  end

  def self.down
    remove_index :unit_options, :master_id
    remove_column :unit_options, :master_id
  end
end