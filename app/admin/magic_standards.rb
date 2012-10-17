ActiveAdmin.register MagicStandard do
  menu :parent => "Magic Items", :priority => 1

  config.sort_order = "name_asc"

  controller do
    def create
      create! { new_admin_magic_standard_url }
    end
  end

  action_item :only => :show do
    link_to "New Magic Standard", new_admin_magic_standard_url
  end

  index do
    column :id
    column :army, :sortable => :army_id
    column :name
    column :value_points
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :army, :collection => Army.order(:name)
      f.input :override, :collection => MagicStandard.where(:army_id => nil).order(:name)
      f.input :name
      f.input :value_points
    end
    f.buttons
  end
end
