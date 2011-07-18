class MagicItem < ActiveRecord::Base
  belongs_to :army
  belongs_to :magic_item_category
  has_and_belongs_to_many :army_list_choices

  validates_presence_of :magic_item_category_id, :name, :value_points
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0
end
