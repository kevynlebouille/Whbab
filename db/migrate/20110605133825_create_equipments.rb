class CreateEquipments < ActiveRecord::Migration
  def self.up
    create_table :equipments do |t|
      t.references :unit, :null => false
      t.string :label, :null => false
      t.integer :position, :null => false
    end

    add_index :equipments, :unit_id
  end

  def self.down
    drop_table :equipments
  end
end
