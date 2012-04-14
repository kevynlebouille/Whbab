class ArmyListUnit < ActiveRecord::Base
  belongs_to :army_list
  belongs_to :unit
  belongs_to :unit_category
  has_and_belongs_to_many :magic_items
  has_and_belongs_to_many :unit_options

  validates_presence_of :army_list_id, :unit_id, :unit_category_id, :name, :value_points, :size
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0
  validates_numericality_of :size, :greater_than_or_equal_to => 1
  validates_numericality_of :position, :greater_than_or_equal_to => 1, :only_integer => true, :allow_nil => true

  before_validation :on => :create do
    self.name = unit.name if unit.is_unique
    self.name = unit.name + " \#" + (army_list.army_list_units.where(:unit_id => unit).count() + 1).to_s unless name?
    self.size = unit.min_size
    self.unit_category = unit.unit_category
    self.value_points = size * (unit.value_points || unit.troops.first.value_points)
  end

  before_save do
    options_points = 0

    unit_options.reject{ |option| option.is_magic_standards || option.is_magic_items }.each do |option|
      factor = option.is_per_model ? size : 1
      options_points = options_points + factor * option.value_points
    end

    magic_items.each do |magic_item|
      options_points = options_points + magic_item.value_points
    end

    self.value_points = size * (unit.value_points || unit.troops.first.value_points) + options_points
  end

  after_save do
    army_list.value_points = army_list.army_list_units.sum('value_points')
    army_list.save
  end

  after_destroy do
    army_list.value_points = army_list.army_list_units.sum('value_points')
    army_list.save
  end

  acts_as_list :scope => :army_list
end
