module ApplicationHelper
  def value_points(vp)
    number_with_precision vp, :strip_insignificant_zeros => true, :delimiter => ' ', :separator => ','
  end

  def transliterate(str)
    return ActiveSupport::Inflector.transliterate(str)
  end
end
