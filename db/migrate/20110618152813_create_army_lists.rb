class CreateArmyLists < ActiveRecord::Migration
  def self.up
    create_table :army_lists do |t|
      t.references :army, :null => false
      t.references :user, :null => false
      t.string :name, :null => false
      t.integer :value_points, :null => false

      t.timestamps
    end

    add_index :army_lists, :army_id
    add_index :army_lists, :user_id
  end

  def self.down
    drop_table :army_lists
  end
end
