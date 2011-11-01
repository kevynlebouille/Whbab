class ArmyListChoice < ActiveRecord::Base
  belongs_to :army_list
  belongs_to :unit
  belongs_to :unit_category
  has_and_belongs_to_many :magic_items

  validates_presence_of :army_list_id, :unit_id, :unit_category_id, :name, :value_points, :size, :position
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0
  validates_numericality_of :size, :greater_than_or_equal_to => 1
  validates_numericality_of :position, :greater_than_or_equal_to => 1, :only_integer => true

  before_validation(:on => :create) do
    self.name = unit.name + " \#" + (army_list.where(:unit_id => unit).count() + 1).to_s unless attribute_present?(:name)
  end
end
