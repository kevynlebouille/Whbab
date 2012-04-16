class AddQuotasToUnitCategories < ActiveRecord::Migration
  def change
    add_column :unit_categories, :min_quota, :integer
    add_column :unit_categories, :max_quota, :integer
  end
end