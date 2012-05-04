class ArmyList < ActiveRecord::Base
  belongs_to :army
  belongs_to :user
  has_many :army_list_units, :order => "position", :dependent => :destroy

  validates_presence_of :army_id, :user_id, :name, :value_points
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0

  attr_accessible :army_id, :name, :notes

  normalize_attributes :name, :notes

  before_validation(:on => :create) do
    self.name = "Liste " + army.name + " \#" + (user.army_lists.where(:army_id => army).count() + 1).to_s unless name?
    self.value_points = 0
  end

  def value_points_details
    rows = connection.select_all "SELECT uc.id id, uc.name name, uc.min_quota min_quota, uc.max_quota max_quota, COUNT(alu.id) count, COALESCE(SUM(alu.value_points), 0.0) value_points
      FROM unit_categories uc
      LEFT JOIN army_list_units alu ON alu.unit_category_id = uc.id AND
      alu.army_list_id = #{id}
      GROUP BY uc.id, uc.name, uc.min_quota, uc.max_quota
      ORDER BY uc.id"

    rows.each do |row|
      row['valid'] = row['value_points'] >= value_points * row['min_quota'] / 100 unless row['min_quota'].blank?
      row['valid'] = row['value_points'] <= value_points * row['max_quota'] / 100 unless row['max_quota'].blank?
    end
  end
end
