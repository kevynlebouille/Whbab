class Equipment < ActiveRecord::Base
  belongs_to :unit

  validates_presence_of :unit_id, :name, :position
  validates_numericality_of :position, :greater_than_or_equal_to => 1, :only_integer => true
end
