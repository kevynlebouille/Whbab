ActiveAdmin.register TroopType do
  menu :parent => "Troops"

  config.sort_order = "name_asc"

  filter :name
end
