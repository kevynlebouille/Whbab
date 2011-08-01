ActiveAdmin.register UnitOption do
  menu :label => "(5) - Unit Options"

  filter :unit
  filter :parent, :collection => proc { UnitOption.includes(:unit).where('value_points IS NULL').collect { |r| [r.unit.name + ' - ' + r.name.slice(0..15) + '...', r.id] } }
  filter :name
  filter :value_points

  form do |f|
    f.inputs do
      f.input :unit
      f.input :parent, :collection => UnitOption.includes(:unit).where('value_points IS NULL').collect { |r| [r.unit.name + ' - ' + r.name, r.id] }
      f.input :name
      f.input :value_points
      f.input :position
      f.input :is_per_model
      f.input :is_magic_items
      f.input :is_magic_standards
    end
    f.buttons
  end
end
