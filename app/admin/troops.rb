ActiveAdmin.register Troop do
  menu :label => "(2) - Troops"

  controller do
    def create
      create! { new_admin_troop_url }
    end
  end

  action_item :only => :show do
    link_to "New Troop", new_admin_troop_path
  end

  index do
    column :id
    column :unit
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
    column :is_character
    column :is_special
    column :position
    default_actions
  end
end
