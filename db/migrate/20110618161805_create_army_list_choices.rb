class CreateArmyListChoices < ActiveRecord::Migration
  def self.up
    create_table :army_list_choices do |t|
      t.references :army_list
      t.references :unit
      t.references :unit_category
      t.string :name
      t.integer :value_points
      t.integer :size
      t.integer :position

      t.timestamps
    end

    add_index :army_list_choices, :army_list_id
    add_index :army_list_choices, :unit_id
    add_index :army_list_choices, :unit_category_id
  end

  def self.down
    drop_table :army_list_choices
  end
end
