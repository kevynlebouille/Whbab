ActiveAdmin.register ExtraItemCategory do
  menu :parent => "Extra Items"

  config.sort_order = "name_asc"

  filter :army
  filter :name
end
