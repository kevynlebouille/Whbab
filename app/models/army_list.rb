class ArmyList < ActiveRecord::Base
  belongs_to :army
  belongs_to :user
  has_many :army_list_choices, :dependent => :destroy

  validates_presence_of :army_id, :user_id, :name, :value_points
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0

  attr_accessible :army_id, :name

  before_validation(:on => :create) do
    self.name = "Liste " + army.name + " \#" + (user.army_lists.where(:army_id => army).count() + 1).to_s unless attribute_present?(:name)
    self.value_points = rand(1000)
  end
end
