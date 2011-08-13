ActiveAdmin.register SpecialRule do
  menu :label => "(4) - Special Rule"

  controller do
    def create
      create! { new_admin_special_rule_url }
    end
  end

  action_item :only => :show do
    link_to "New Special Rule", new_admin_special_rule_path
  end

  index do
    column :id
    column :unit, :sortable => :unit_id
    column :name
    column :position
    default_actions
  end
end
