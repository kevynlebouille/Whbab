class UnitCategory < ActiveRecord::Base
  has_many :units, :dependent => :destroy
end
