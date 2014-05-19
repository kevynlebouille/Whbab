class ArmyListUnitMagicItem < ActiveRecord::Base
  self.table_name = 'army_list_units_magic_items'

  belongs_to :army_list_unit
  belongs_to :magic_item

  attr_accessible :id, :army_list_unit_id, :magic_item_id, :quantity
end
