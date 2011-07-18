class CreateArmyListChoicesMagicItems < ActiveRecord::Migration
  def self.up
    create_table :army_list_choices_magic_items, :id => false do |t|
      t.references :army_list_choice, :null => false
      t.references :magic_item, :null => false
    end

    add_index :army_list_choices_magic_items, :army_list_choice_id
    add_index :army_list_choices_magic_items, :magic_item_id
  end

  def self.down
    drop_table :army_list_choices_magic_items
  end
end
