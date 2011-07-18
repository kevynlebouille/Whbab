class Troop < ActiveRecord::Base
  belongs_to :troop_type
  belongs_to :unit

  validates_presence_of :troop_type_id, :unit_id, :name, :value_points, :position
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0
  validates_numericality_of :position, :greater_than_or_equal_to => 1, :only_integer => true
  #validates_inclusion_of :is_character, :in => 0..1
  #validates_inclusion_of :is_special, :in => 0..1
end
