class MagicStandard < ActiveRecord::Base
  belongs_to :army
  has_and_belongs_to_many :army_list_units
  has_one :override, :class_name => "MagicStandard", :foreign_key => "override_id"

  validates_numericality_of :value_points, :greater_than_or_equal_to => 0

  scope :available_for, lambda { |army, value_points_limit|
    if value_points_limit.nil?
      where("army_id = :army_id OR (army_id IS NULL AND id NOT IN (SELECT override_id FROM magic_items WHERE army_id = :army_id AND override_id IS NOT NULL))", {:army_id => army}).order("value_points DESC", "name")
    else
      where("army_id = :army_id OR (army_id IS NULL AND id NOT IN (SELECT override_id FROM magic_items WHERE army_id = :army_id AND override_id IS NOT NULL))", {:army_id => army}).where("value_points <= ?", value_points_limit).order("value_points DESC", "name")
    end
  }
end
