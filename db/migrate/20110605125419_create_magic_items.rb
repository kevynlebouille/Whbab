class CreateMagicItems < ActiveRecord::Migration
  def self.up
    create_table :magic_items do |t|
      t.references :magic_item_category, :null => false
      t.references :army, :null => false
      t.string :label, :null => false
      t.integer :value_points, :null => false
    end

    add_index :magic_items, :magic_item_category_id
    add_index :magic_items, :army_id
  end

  def self.down
    drop_table :magic_items
  end
end
