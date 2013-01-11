ActiveAdmin.register Unit do
  menu :priority => 3

  controller do
    def create
      create! { new_admin_unit_url }
    end
  end

  member_action :duplicate, :method => :post do
    new_unit = resource.dup
    new_unit.troops << resource.troops.collect { |troop| troop.dup }
    new_unit.equipments << resource.equipments.collect { |equipment| equipment.dup }
    new_unit.special_rules << resource.special_rules.collect { |special_rule| special_rule.dup }
    # new_unit.unit_options << resource.unit_options.collect { |unit_option| unit_option.dup }
    new_unit.unit_options << resource.unit_options.without_parent.collect { |unit_option| unit_option.dup_with_associations(new_unit) }
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

  form do |f|
    f.inputs do
      f.input :army, :collection => Army.order(:name)
      f.input :unit_category
      f.input :name
      f.input :value_points
      f.input :min_size
      f.input :max_size
      f.input :is_unique
      f.input :magic
      f.input :notes
    end
    f.buttons
  end

  show do
    attributes_table do
      row :id
      row :army
      row :unit_category
      row :name
      row :min_size
      row :max_size
      row :value_points
      row :magic
      row :notes
      row :is_unique
    end

    panel "Troops details" do
      div :class => "unit_troops_details" do
        table_for unit.troops do
          column :id
          column :troop_type
          column :name
          column :M
          column :WS
          column :BS
          column :S
          column :T
          column :W
          column :I
          column :A
          column :LD
          column :value_points
          column :min_size
          column :unit_option
          column :position
          column do |troop|
            link_to "Mont.", move_higher_admin_troop_path(troop), :method => :post unless troop.first?
          end
          column do |troop|
            link_to "Desc.", move_lower_admin_troop_path(troop), :method => :post unless troop.last?
          end
          column do |troop|
            link_to "Voir", admin_troop_path(troop)
          end
        end
      end
    end

    panel "Equipments Details" do
      div :class => "unit_equipments_details" do
        table_for unit.equipments, "data-url" => sort_admin_equipments_path(:unit_id => unit) do
          column :id
          column :name
          column :troop
          column :position
          column do |equipment|
            link_to "Mont.", move_higher_admin_equipment_path(equipment), :method => :post unless equipment.first?
          end
          column do |equipment|
            link_to "Desc.", move_lower_admin_equipment_path(equipment), :method => :post unless equipment.last?
          end
          column do |equipment|
            link_to "Voir", admin_equipment_path(equipment)
          end
        end
      end
    end

    panel "Special Rules Details" do
      div :class => "unit_special_rules_details" do
        table_for unit.special_rules, "data-url" => sort_admin_special_rules_path(:unit_id => unit) do
          column :id
          column :name
          column :troop
          column :position
          column do |special_rule|
            link_to "Mont.", move_higher_admin_special_rule_path(special_rule), :method => :post unless special_rule.first?
          end
          column do |special_rule|
            link_to "Desc.", move_lower_admin_special_rule_path(special_rule), :method => :post unless special_rule.last?
          end
          column do |special_rule|
            link_to "Voir", admin_special_rule_path(special_rule)
          end
        end
      end
    end

    panel "Options Details" do
      div :class => "unit_unit_options_details" do
        table_for unit.unit_options do
          column :id
          column :name
          column :mount
          column :value_points
          column :is_per_model
          column :is_magic_items
          column :is_magic_standards
          column :is_extra_items
          column :is_unique_choice
          column :position
          column do |unit_option|
            link_to "Mont.", move_higher_admin_unit_option_path(unit_option), :method => :post unless unit_option.first?
          end
          column do |unit_option|
            link_to "Desc.", move_lower_admin_unit_option_path(unit_option), :method => :post unless unit_option.last?
          end
          column do |unit_option|
            link_to "Voir", admin_unit_option_path(unit_option)
          end
        end
      end
    end

    active_admin_comments_for unit
  end
end
