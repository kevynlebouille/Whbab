class Troop < ActiveRecord::Base
  belongs_to :troop_type
  belongs_to :unit
  belongs_to :unit_option
  has_many :equipments, :dependent => :nullify
  has_many :special_rules, :dependent => :nullify

  validates_presence_of :unit_id, :name
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0, :allow_nil => true
  validates_numericality_of :position, :greater_than_or_equal_to => 1, :only_integer => true, :allow_nil => true

  acts_as_list :scope => :unit

  attr_accessor :army_filter

  def army_filter
    army_filter ||= unit.try(:army).try(:id)
  end
end
