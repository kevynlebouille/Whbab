ActiveAdmin.register Troop do
  menu :priority => 4

  controller do
    def create
      create! { new_admin_troop_url }
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
    link_to "New Troop", new_admin_troop_path('troop[unit_id]' => troop.unit)
  end

  filter :unit
  filter :troop_type
  filter :name
  filter :value_points

  index do
    selectable_column
    id_column
    column :unit, :sortable => :unit_id
    column :troop_type, :sortable => :troop_type_id
    column :name
    column :unit_option, :sortable => :unit_option_id
    column :value_points
    # column :M
    # column :WS
    # column :BS
    # column :S
    # column :T
    # column :W
    # column :I
    # column :A
    # column :LD
    column :min_size
    column :position
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :army_filter, :as => :select, :collection => Army.order(:name), :disabled => Army.disabled.pluck(:id), :label => "Army FILTER"
      f.input :unit, :collection => Unit.includes(:army).order('armies.name', 'units.name').collect { |u| [u.army.name + ' - ' + u.name, u.id] }
      f.input :unit_option, :collection => UnitOption.includes(:unit => [:army]).order('armies.name', 'units.name', 'unit_options.parent_id', 'unit_options.position').collect { |uo| [uo.unit.army.name + ' - ' + uo.unit.name + ' - ' + uo.name, uo.id] }
      f.input :troop_type, :collection => TroopType.order(:name)
      f.input :name
      f.input :M
      f.input :WS
      f.input :BS
      f.input :S
      f.input :T
      f.input :W
      f.input :I
      f.input :A
      f.input :LD
      f.input :value_points
      f.input :min_size
      f.input :position
    end
    f.buttons
  end
end
