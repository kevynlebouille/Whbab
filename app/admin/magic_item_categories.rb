ActiveAdmin.register MagicItemCategory do
  menu :parent => "Magic Items"

  config.sort_order = "name_asc"

  filter :name
end
