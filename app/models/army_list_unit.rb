class ArmyListUnit < ActiveRecord::Base
  belongs_to :army_list
  belongs_to :unit
  belongs_to :unit_category
  has_and_belongs_to_many :magic_items
  has_and_belongs_to_many :magic_standards
  has_and_belongs_to_many :unit_options
  has_many :army_list_unit_troops, :order => 'position', :dependent => :destroy

  accepts_nested_attributes_for :army_list_unit_troops

  normalize_attributes :name, :notes

  validates_presence_of :army_list_id, :unit_id, :unit_category_id, :name, :value_points, :size
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0
  validates_numericality_of :size, :greater_than_or_equal_to => 0, :only_integer => true
  validates_numericality_of :position, :greater_than_or_equal_to => 1, :only_integer => true, :allow_nil => true

  before_validation :on => :create do
    self.name = unit.name if unit.is_unique
    self.name = unit.name + " \#" + (army_list.army_list_units.where(:unit_id => unit).count() + 1).to_s unless name?
    self.unit_category = unit.unit_category
    self.size = 0
    self.value_points = 0.0
    self.notes = unit.notes
  end

  before_save do
    if army_list_unit_troops.empty?
      unit.troops.each do |troop|
        if unit.value_points
          army_list_unit_troops.build :troop => troop, :size => troop.position == 1 ? unit.min_size : nil, :position => troop.position
        elsif troop.value_points
          army_list_unit_troops.build :troop => troop, :size => troop.min_size, :position => troop.position
        end
      end
    end

    self.size = 0
    self.value_points = 0.0

    unit_options.reject{ |option| option.is_magic_standards || option.is_magic_items }.each do |option|
      factor = option.is_per_model ? army_list_unit_troops.first.size.to_i : 1
      self.value_points = self.value_points + factor * option.value_points
    end

    magic_items.each do |magic_item|
      self.value_points = self.value_points + magic_item.value_points
    end

    magic_standards.each do |magic_standard|
      self.value_points = self.value_points + magic_standard.value_points
    end

    if unit.value_points
      self.size = army_list_unit_troops.first.size.to_i + self.size
      self.value_points = army_list_unit_troops.first.size.to_i * unit.value_points + self.value_points
    else
      army_list_unit_troops.reject{ |alut| alut.troop.value_points.nil? }.each do |army_list_unit_troop|
        self.size = army_list_unit_troop.size.to_i + self.size
        self.value_points = army_list_unit_troop.size.to_i * army_list_unit_troop.troop.value_points + self.value_points
      end
    end
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

  def unit_options_value_points()
    value_points = 0

    unit_options.reject{ |option| option.is_magic_standards || option.is_magic_items }.each do |option|
      factor = option.is_per_model ? army_list_unit_troops.first.size.to_i : 1
      value_points = value_points + factor * option.value_points
    end

    return value_points
  end

  def magic_items_value_points()
    return magic_items.sum('value_points')
  end

  def magic_standards_value_points()
    return magic_standards.sum('value_points')
  end
end
