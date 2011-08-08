class Troop < ActiveRecord::Base
  belongs_to :troop_type
  belongs_to :unit

  validates_presence_of :unit_id, :name
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0, :allow_nil => true
  validates_numericality_of :position, :greater_than_or_equal_to => 1, :only_integer => true, :allow_nil => true

  acts_as_list :scope => :unit
end
