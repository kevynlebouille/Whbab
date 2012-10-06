class AddIsUniqueChoiceToUnitOption < ActiveRecord::Migration
  class UnitOption < ActiveRecord::Base
  end

  def change
    add_column :unit_options, :is_unique_choice, :boolean, :null => false
    UnitOption.reset_column_information
    UnitOption.where('parent_id IS NOT NULL').each do |unit_option|
      unit_option.update_attributes!(:is_unique_choice => true)
    end
  end
end
