class Army < ActiveRecord::Base
  has_many :army_lists, :dependent => :destroy
  has_many :magic_items, :dependent => :destroy
  has_one  :extra_item_category, :dependent => :destroy
  has_many :units, :order => "name", :dependent => :destroy
  has_many :favorite_users, :foreign_key => "favorite_army_id", :dependent => :nullify

  validates_presence_of :name

  scope :disabled, where('id NOT IN (SELECT DISTINCT army_id FROM units)')
end
