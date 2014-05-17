ActiveAdmin.register SpecialRule do
  menu :priority => 6

  controller do
    def create
      create! { new_admin_special_rule_url }
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

  collection_action :sort, :method => :post do
    params[:special_rule].each_with_index do |id, index|
      SpecialRule.update_all({ :position => index + 1 }, { :unit_id => params[:unit_id], :id => id })
    end
    render :nothing => true
  end

  action_item :only => :show do
    link_to "New Special Rule", new_admin_special_rule_path('special_rule[unit_id]' => special_rule.unit)
  end

  filter :unit
  filter :name

  index do
    selectable_column
    id_column
    column :unit, :sortable => :unit_id
    column :name
    column :troop, :sortable => :troop_id
    column :position
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :army_filter, :as => :select, :collection => Army.order(:name), :disabled => Army.disabled.pluck(:id), :label => "Army FILTER"
      f.input :unit, :collection => Unit.includes(:army).order('armies.name', 'units.name').collect { |u| [u.army.name + ' - ' + u.name, u.id] }
      f.input :troop, :collection => Troop.includes(:unit => [:army]).order('armies.name', 'units.name', 'troops.position').collect { |t| [t.unit.army.name + ' - ' + t.unit.name + ' - ' + t.name, t.id] }
      f.input :name
      f.input :position
    end
    f.buttons
  end
end
