class Unit < ActiveRecord::Base
  belongs_to :army
  belongs_to :unit_category
  has_many :army_list_units, :dependent => :destroy
  has_many :equipments, :order => "position", :dependent => :destroy
  has_many :special_rules, :order => "position", :dependent => :destroy
  has_many :troops, :order => "position", :dependent => :destroy
  has_many :unit_options, :order => ["parent_id", "position"], :dependent => :destroy
  has_many :mount_options, :class_name => "UnitOption", :foreign_key => "mount_id", :dependent => :nullify

  normalize_attributes :magic, :notes

  validates_presence_of :army_id, :unit_category_id, :name, :min_size
  validates_numericality_of :min_size, :greater_than_or_equal_to => 1, :only_integer => true
  validates_numericality_of :max_size, :greater_than_or_equal_to => :min_size, :only_integer => true, :allow_nil => true
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0, :allow_nil => true
  validates_inclusion_of :is_unique, :in => [true, false]

  scope :base_category, where(:unit_category_id => 3)
  scope :mount_category, where(:unit_category_id => 6)

  def self.for_select(army_list)
    army_list_units = army_list.army_list_units.collect { |alu| alu.unit }

    UnitCategory.where("id <> 6").map do |unit_category|
      [
        unit_category.name,
        unit_category.units
          .where(:army_id => army_list.army)
          .order("is_unique", "name")
          .reject { |unit| unit.in?(army_list_units) if unit.is_unique }
          .map { |u| [u.name, u.id] }
      ]
    end
  end

  def duplicate()
    new_troops = {}
    new_unit_options = {}

    new_unit = dup
    new_unit.name = "Copie de #{new_unit.name}"
    new_unit.troops << troops.collect { |troop| new_troops[troop.id] = troop.dup }
    new_unit.equipments << equipments.collect { |equipment| equipment.dup }
    new_unit.special_rules << special_rules.collect { |special_rule| special_rule.dup }
    new_unit.unit_options << unit_options.collect { |unit_option| new_unit_options[unit_option.id] = unit_option.dup }

    new_unit.unit_options.map do |unit_option|
      unit_option.parent = new_unit_options[unit_option.parent.id] unless unit_option.parent.nil?
      unit_option.troop = new_troops[unit_option.troop.id] unless unit_option.troop.nil?
    end

    new_unit
  end
end
