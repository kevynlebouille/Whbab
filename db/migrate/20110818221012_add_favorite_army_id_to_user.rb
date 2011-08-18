class AddFavoriteArmyIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :favorite_army_id, :integer
    add_index :users, :favorite_army_id
  end

  def self.down
    remove_index :users, :favorite_army_id
    remove_column :users, :favorite_army_id
  end
end