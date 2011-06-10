class UnitOption < ActiveRecord::Base
  belongs_to :unit
  belongs_to :parent, :class_name => 'UnitOption'
  has_many :children, :class_name => 'UnitOption', :foreign_key => 'parent_id', :dependent => :destroy
end
