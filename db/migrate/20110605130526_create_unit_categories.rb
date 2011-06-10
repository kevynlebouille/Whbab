class CreateUnitCategories < ActiveRecord::Migration
  def self.up
    create_table :unit_categories do |t|
      t.string :label, :null => false
    end
  end

  def self.down
    drop_table :unit_categories
  end
end
