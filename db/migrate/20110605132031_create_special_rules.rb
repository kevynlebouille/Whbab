class CreateSpecialRules < ActiveRecord::Migration
  def self.up
    create_table :special_rules do |t|
      t.references :unit, :null => false
      t.string :label, :null => false
      t.integer :position, :null => false
    end

    add_index :special_rules, :unit_id
  end

  def self.down
    drop_table :special_rules
  end
end
