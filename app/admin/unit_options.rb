ActiveAdmin.register UnitOption do
  controller do
    def create
      create! { new_admin_unit_option_url }
    end
  end

  action_item :only => :show do
    link_to "New Unit Option", new_admin_unit_option_path
  end

  filter :unit
  filter :parent, :collection => proc { UnitOption.includes(:unit).only_parents.collect { |r| [r.unit.name + ' - ' + r.name, r.id] } }
  filter :name
  filter :value_points

  index do
    column :id
    column :unit, :sortable => :unit_id
    column :name
    column :value_points
    column :is_per_model
    column :is_magic_items
    column :is_magic_standards
    column :position
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :unit
      f.input :parent, :collection => UnitOption.includes(:unit).where('value_points IS NULL').collect { |r| [r.unit.name + ' - ' + r.name, r.id] }
      f.input :depend, :collection => UnitOption.includes(:unit).where('value_points IS NOT NULL').collect { |r| [r.unit.name + ' - ' + r.name, r.id] }
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
