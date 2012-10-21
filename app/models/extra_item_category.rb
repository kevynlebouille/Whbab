class ExtraItemCategory < ActiveRecord::Base
  belongs_to :army
  has_many :extra_items, :dependent => :destroy

  validates_presence_of :army_id, :name
end
