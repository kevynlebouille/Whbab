class UnitCategory < ActiveRecord::Base
  has_many :units, :dependent => :destroy

  validates_presence_of :name
end
