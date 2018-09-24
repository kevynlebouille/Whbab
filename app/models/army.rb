# encoding: UTF-8

class Army < ActiveRecord::Base
  has_many :army_lists, :dependent => :destroy
  has_many :magic_items, :dependent => :destroy
  has_many :extra_item_categories, :dependent => :destroy
  has_many :units, :order => "name", :dependent => :destroy
  has_many :favorite_users, :class_name => 'User', :dependent => :nullify, :foreign_key => "favorite_army_id"

  validates_presence_of :name

  scope :disabled, where('id NOT IN (SELECT DISTINCT army_id FROM units)')
  scope :disabled_or_obsolete, where('id NOT IN (SELECT DISTINCT army_id FROM units) OR name LIKE \'%obsolète%\'')
end
