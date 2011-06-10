class Troop < ActiveRecord::Base
  belongs_to :troop_type
  belongs_to :unit
end
