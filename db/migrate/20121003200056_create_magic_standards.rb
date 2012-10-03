class CreateMagicStandards < ActiveRecord::Migration
  def up
    create_table :magic_standards do |t|
      t.references :army
      t.string :name, :null => false
      t.integer :value_points, :null => false
      t.integer :override_id
    end

    add_index :magic_standards, :army_id
    add_index :magic_standards, :override_id
  end

  def down
    drop_table :magic_standards
  end
end
