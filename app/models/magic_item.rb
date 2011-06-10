class MagicItem < ActiveRecord::Base
  belongs_to :army
  belongs_to :magic_item_category
end
