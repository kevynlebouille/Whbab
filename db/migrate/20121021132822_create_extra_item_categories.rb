class CreateExtraItemCategories < ActiveRecord::Migration
  def change
    create_table :extra_item_categories do |t|
      t.references :army, :null => false
      t.string :name, :null => false
    end

    add_index :extra_item_categories, :army_id
  end
end
