class MagicItem < ActiveRecord::Base
  belongs_to :army
  belongs_to :magic_item_category
  has_and_belongs_to_many :army_list_units

  validates_presence_of :magic_item_category_id, :name, :value_points
  validates_numericality_of :value_points, :greater_than_or_equal_to => 0

  scope :by_category_and_army, lambda { |category, army| category.magic_items.where(:army_id => army).order("value_points DESC", "name") }
  scope :magic_standards, where(:magic_item_category_id => 4)
  scope :by_army, lambda { |army| where(:army_id => army) }

  # def self.for_select(army)
  #   MagicItemCategory.all.map do |magic_item_category|
  #     [magic_item_category.name, magic_item_category.magic_items.where(:army_id => army).order("value_points DESC", "name").map { |mi| ["#{mi.name} #{ApplicationController.helpers.value_points(mi.value_points)}pts", mi.id] }]
  #   end
  # end
end
