ActiveAdmin.register UnitOption do
  menu :parent => "Units"

  controller do
    def create
      create! { new_admin_unit_option_url }
    end
  end

  member_action :move_higher, :method => :post do
    resource.move_higher
    resource.save

    redirect_to admin_unit_url(resource.unit)
  end

  member_action :move_lower, :method => :post do
    resource.move_lower
    resource.save

    redirect_to admin_unit_url(resource.unit)
  end

  action_item :only => :show do
    link_to "New Unit Option", new_admin_unit_option_path('unit_option[unit_id]' => unit_option.unit)
  end

  filter :unit
  filter :parent, :collection => proc { UnitOption.includes(:unit).without_parent.collect { |r| [r.unit.name + ' - ' + r.name, r.id] } }
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
    column :is_extra_items
    column :is_unique_choice
    column :position
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :unit
      f.input :parent, :collection => UnitOption.includes(:unit).collect { |r| [r.unit.name + ' - ' + r.name, r.id] }
      f.input :name
      f.input :value_points
      f.input :position
      f.input :is_per_model
      f.input :is_magic_items
      f.input :is_magic_standards
      f.input :is_extra_items
      f.input :is_unique_choice
    end
    f.buttons
  end
end
