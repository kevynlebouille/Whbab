class ArmyListChoice < ActiveRecord::Base
  belongs_to :army_list
  belongs_to :unit
  belongs_to :unit_category
  has_and_belongs_to_many :magic_items

  validates_presence_of :army_list_id, :unit_id, :unit_category_id, :name, :value_points, :size
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0
  validates_numericality_of :size, :greater_than_or_equal_to => 1
  validates_numericality_of :position, :greater_than_or_equal_to => 1, :only_integer => true, :allow_nil => true

  before_validation(:on => :create) do
    self.name = unit.name + " \#" + (army_list.army_list_choices.where(:unit_id => unit).count() + 1).to_s unless attribute_present?(:name)
    self.size = unit.min_size
    self.unit_category = unit.unit_category
    self.value_points = size * unit.value_points
  end

  acts_as_list :scope => :army_list
end
