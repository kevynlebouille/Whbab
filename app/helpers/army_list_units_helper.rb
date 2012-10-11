module ArmyListUnitsHelper
  def characteristic(charac)
    if charac.blank?
      return '-'
    end
    charac
  end
end
