class CreateArmies < ActiveRecord::Migration
  def self.up
    create_table :armies do |t|
      t.string :label, :null => false
    end
  end

  def self.down
    drop_table :armies
  end
end
