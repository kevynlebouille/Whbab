ActiveAdmin.register Army do
  menu :priority => 2

  config.sort_order = "name_asc"

  filter :name
end
