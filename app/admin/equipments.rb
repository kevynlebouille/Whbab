ActiveAdmin.register Equipment do
  controller do
    def create
      create! { new_admin_equipment_url }
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
    link_to "New Equipment", new_admin_equipment_path
  end

  index do
    column :id
    column :unit, :sortable => :unit_id
    column :name
    column :position
    default_actions
  end
end
