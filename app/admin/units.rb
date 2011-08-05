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

  filter :army
  filter :unit_category
  filter :name
  filter :value_points

  index do
    column :id
    column :army, :sortable => :army_id
    column :unit_category, :sortable => :unit_category_id
    column :name
    column :min_size
    column :max_size
    column :value_points
    default_actions
  end
end
