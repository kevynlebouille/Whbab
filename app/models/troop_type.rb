class TroopType < ActiveRecord::Base
  has_many :troops, :dependent => :destroy
end
