class UnitOption < ActiveRecord::Base
  belongs_to :unit
  belongs_to :parent, :class_name => 'UnitOption'
  has_many :children, :class_name => 'UnitOption', :foreign_key => 'parent_id', :dependent => :destroy

  validates_presence_of :unit_id, :name, :value_points, :position, :is_per_model
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0
  validates_numericality_of :position, :greater_than_or_equal_to => 1, :only_integer => true
  validates_inclusion_of :is_per_model, :in => 0..1
end
