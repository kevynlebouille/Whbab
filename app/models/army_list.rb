class ArmyList < ActiveRecord::Base
  belongs_to :army
  belongs_to :user
  has_many :army_list_choices, :dependent => :destroy

  validates_presence_of :army_id, :user_id, :name, :value_points
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0
end
