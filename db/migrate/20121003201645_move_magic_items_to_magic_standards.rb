class MoveMagicItemsToMagicStandards < ActiveRecord::Migration
  def up
    MagicItem.where('magic_item_category_id = 4').each do |magic_item|
      magic_standard = MagicStandard.new
      magic_standard.name = magic_item.name
      magic_standard.value_points = magic_item.value_points
      magic_standard.army = magic_item.army
      magic_standard.save

      say "MagicStandard #{magic_standard.name} created!"

      magic_item.destroy
    end

    MagicItemCategory.destroy(4)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
