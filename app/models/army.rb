class Army < ActiveRecord::Base
  has_many :army_lists, :dependent => :destroy
  has_many :magic_items, :dependent => :destroy
  has_many :units, :dependent => :destroy
  has_many :favorite_users, :foreign_key => "favorite_army_id", :dependent => :nullify

  validates_presence_of :name

  default_scope order('name')
end
