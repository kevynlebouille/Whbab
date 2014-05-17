ActiveAdmin.register ExtraItem do
  menu :priority => 7

  config.sort_order = "name_asc"

  controller do
    def create
      create! { new_admin_extra_item_url }
    end
  end

  action_item :only => :show do
    link_to "New Extra Item", new_admin_extra_item_path
  end

  filter :extra_item_category
  filter :name
  filter :value_points

  index do
    selectable_column
    id_column
    column :extra_item_category, :sortable => :extra_item_category_id
    column :name
    column :value_points
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :extra_item_category, :collection => ExtraItemCategory.includes(:army).order(:name).collect { |ei| [ei.army.name + ' - ' + ei.name, ei.id] }
      f.input :name
      f.input :value_points
    end
    f.buttons
  end
end
