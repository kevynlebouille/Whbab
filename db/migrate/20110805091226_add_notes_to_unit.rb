class AddNotesToUnit < ActiveRecord::Migration
  def self.up
    add_column :units, :notes, :text
  end

  def self.down
    remove_column :units, :notes
  end
end
