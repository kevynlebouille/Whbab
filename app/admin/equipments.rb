ActiveAdmin.register Equipment do
  menu :label => "(3) - Equipment"

  controller do
    def create
      create! { new_admin_equipment_url }
    end
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
