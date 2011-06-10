class CreateMagicItemCategories < ActiveRecord::Migration
  def self.up
    create_table :magic_item_categories do |t|
      t.string :label, :null => false
    end
  end

  def self.down
    drop_table :magic_item_categories
  end
end
