ActiveAdmin.register Unit do
  menu :label => "(1) - Unit"

  controller do
    def create
      create! { new_admin_unit_url }
    end
  end

  member_action :duplicate, :method => :post do
    new_unit = resource.clone
    new_unit.troops << resource.troops.collect { |troop| troop.clone }
    new_unit.equipments << resource.equipments.collect { |equipment| equipment.clone }
    new_unit.special_rules << resource.special_rules.collect { |special_rule| special_rule.clone }
    new_unit.unit_options << resource.unit_options.collect { |unit_option| unit_option.clone }
    new_unit.save

    redirect_to edit_admin_unit_url(new_unit)
  end

  action_item :only => :show do
    link_to "New Unit", new_admin_unit_path
    link_to "Duplicate Unit", duplicate_admin_unit_path, :method => :post
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
    column :is_unique
    default_actions
  end

  # show do
  #   attributes_table do
  #     row :id
  #     row :army
  #     row :unit_category
  #     row :name
  #     row :min_size
  #     row :max_size
  #     row :value_points
  #     row :magic
  #     row :notes
  #   end
  # 
  #   table_for unit.troops do
  #     column :id
  #     column :troop_type
  #     column :name
  #     column :M
  #     column :WS
  #     column :BS
  #     column :S
  #     column :T
  #     column :W
  #     column :I
  #     column :A
  #     column :LD
  #     column :value_points
  #     column :position
  #   end
  # 
  #   table_for unit.equipments do
  #     column :id
  #     column :name
  #     column :position
  #   end
  # 
  #   table_for unit.special_rules do
  #     column :id
  #     column :name
  #     column :position
  #   end
  # 
  #   table_for unit.unit_options do
  #     column :id
  #     column :name
  #     column :position
  #   end
  # 
  #   active_admin_comments_for unit
  # end
end
