class Unit < ActiveRecord::Base
  belongs_to :army
  belongs_to :unit_category
  has_many :army_list_units, :dependent => :destroy
  has_many :equipments, :order => 'position', :dependent => :destroy
  has_many :special_rules, :order => 'position', :dependent => :destroy
  has_many :troops, :order => 'position', :dependent => :destroy
  has_many :unit_options, :order => ['parent_id', 'position'], :dependent => :destroy

  validates_presence_of :army_id, :unit_category_id, :name, :min_size
  validates_numericality_of :min_size, :greater_than_or_equal_to => 1, :only_integer => true
  validates_numericality_of :max_size, :greater_than_or_equal_to => :min_size, :only_integer => true, :allow_nil => true
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0, :allow_nil => true
  validates_inclusion_of :is_unique, :in => [true, false]

  scope :base_category, where(:unit_category_id => 3)

  def self.for_select(army_list)
    used_units = army_list.army_list_units.collect { |alu| alu.unit }

    UnitCategory.all.map do |unit_category|
      [
        unit_category.name,
        unit_category.units
          .where(:army_id => army_list.army)
          .order("is_unique", "name")
          .reject { |unit| unit.in?(used_units) if unit.is_unique }
          .map { |u| [u.name, u.id] }
      ]
    end
  end
end
