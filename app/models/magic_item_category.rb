class MagicItemCategory < ActiveRecord::Base
  has_many :magic_items, :dependent => :destroy

  validates_presence_of :name

  scope :not_magic_standards, where('id <> 4')
end
