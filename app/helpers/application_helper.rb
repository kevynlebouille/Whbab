module ApplicationHelper
  def value_points(vp)
    number_with_precision vp, :strip_insignificant_zeros => true, :delimiter => ' ', :separator => ','
  end
end
