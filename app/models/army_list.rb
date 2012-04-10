class ArmyList < ActiveRecord::Base
  belongs_to :army
  belongs_to :user
  has_many :army_list_units, :order => "position", :dependent => :destroy

  validates_presence_of :army_id, :user_id, :name, :value_points
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0

  attr_accessible :army_id, :name

  before_validation(:on => :create) do
    self.name = "Liste " + army.name + " \#" + (user.army_lists.where(:army_id => army).count() + 1).to_s unless name?
    self.value_points = 0
  end

  def value_points_details
    connection.select_all "SELECT unit_categories.name name, COUNT(army_list_units.id) count, SUM(army_list_units.value_points) value_points
      FROM unit_categories
      LEFT JOIN army_list_units ON army_list_units.unit_category_id = unit_categories.id AND
      army_list_units.army_list_id = #{id}
      GROUP BY unit_categories.name
      ORDER BY unit_categories.id"
  end
end
