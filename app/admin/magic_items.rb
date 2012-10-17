ActiveAdmin.register MagicItem do
  config.sort_order = "name_asc"

  controller do
    def create
      create! { new_admin_magic_item_url }
    end
  end

  action_item :only => :show do
    link_to "New Magic Item", new_admin_magic_item_path
  end

  index do
    column :id
    column :army, :sortable => :army_id
    column :magic_item_category, :sortable => :magic_item_category_id
    column :name
    column :value_points
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :army, :collection => Army.order(:name)
      f.input :magic_item_category, :collection => MagicItemCategory.order(:name)
      f.input :override, :collection => MagicItem.where(:army_id => nil).order(:name)
      f.input :name
      f.input :value_points
    end
    f.buttons
  end
end
