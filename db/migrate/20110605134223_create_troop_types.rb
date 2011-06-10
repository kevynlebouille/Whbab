class CreateTroopTypes < ActiveRecord::Migration
  def self.up
    create_table :troop_types do |t|
      t.string :label, :null => false
    end
  end

  def self.down
    drop_table :troop_types
  end
end
