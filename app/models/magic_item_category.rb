class MagicItemCategory < ActiveRecord::Base
  has_many :magic_items, :dependent => :destroy

  validates_presence_of :name
end
