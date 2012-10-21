class CreateExtraItems < ActiveRecord::Migration
  def change
    create_table :extra_items do |t|
      t.references :extra_item_category, :null => false
      t.string :name, :null => false
      t.decimal :value_points, :precision => 7, :scale => 1, :null => false
    end

    add_index :extra_items, :extra_item_category_id

    add_column :unit_options, :is_extra_items, :boolean, :null => false
  end
end
