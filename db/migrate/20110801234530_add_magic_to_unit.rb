class AddMagicToUnit < ActiveRecord::Migration
  def self.up
    add_column :units, :magic, :string
  end

  def self.down
    remove_column :units, :magic
  end
end
