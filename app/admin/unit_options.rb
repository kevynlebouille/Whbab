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
    column :mount, :sortable => :mount_id
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
      f.input :army_filter, :as => :select, :collection => Army.order(:name), :disabled => Army.disabled.pluck(:id), :label => "Army FILTER"
      f.input :unit, :collection => Unit.includes(:army).order('armies.name', 'units.name').collect { |u| [u.army.name + ' - ' + u.name, u.id] }
      f.input :parent, :collection => UnitOption.includes(:unit => [:army]).order('armies.name', 'units.name', 'unit_options.position').collect { |uo| [uo.unit.army.name + ' - ' + uo.unit.name + ' - ' + uo.name, uo.id] }
      f.input :mount, :collection => Unit.includes(:army).mount_category.order('armies.name', 'units.name').collect { |u| [u.army.name + ' - ' + u.name, u.id] }
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
