class TroopType < ActiveRecord::Base
  has_many :troops, :dependent => :destroy

  validates_presence_of :name
end
