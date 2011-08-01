ActiveAdmin.register Unit do
  menu :label => "(1) - Units"

  controller do
    def create
      create! { new_admin_unit_url }
    end
  end

  action_item :only => :show do
    link_to "New Unit", new_admin_unit_path
  end

  index do
    column :id
    column :army
    column :name
    column :min_size
    column :max_size
    column :value_points
    default_actions
  end
end
