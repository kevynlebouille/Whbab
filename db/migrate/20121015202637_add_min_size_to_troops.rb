class AddMinSizeToTroops < ActiveRecord::Migration
  def change
    add_column :troops, :min_size, :integer
  end
end
