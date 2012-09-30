ActiveAdmin.register Troop do
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
    link_to "New Troop", new_admin_troop_path
  end

  filter :unit
  filter :troop_type
  filter :name
  filter :value_points

  index do
    column :id
    column :unit, :sortable => :unit_id
    column :troop_type, :sortable => :troop_type_id
    column :name
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
    column :position
    default_actions
  end
end
