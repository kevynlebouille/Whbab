class MagicItem < ActiveRecord::Base
  belongs_to :army
  belongs_to :magic_item_category
  has_and_belongs_to_many :army_list_units
  has_one :override, :class_name => "MagicItem", :foreign_key => "override_id"

  validates_presence_of :magic_item_category_id, :name, :value_points
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0

  scope :magic_standards, where(:magic_item_category_id => 4)
  scope :available_for, lambda { |army, value_points_limit|
    where("army_id = :army_id OR (army_id IS NULL AND id NOT IN (SELECT override_id FROM magic_items WHERE army_id = :army_id AND override_id IS NOT NULL))", {:army_id => army}).where("value_points <= ?", value_points_limit).order("value_points DESC", "name")
  }

  def is_magic_standard?
    magic_item_category.id == 4
  end
end
