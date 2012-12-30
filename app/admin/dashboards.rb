ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    @users = User.includes(:army_lists).sort do |b,a|
      a.army_lists.size <=> b.army_lists.size
    end

    @troops = []
    @equipments = []
    @special_rules = []
    @unit_options = []

    # Unit.all.each do |unit|
    #   unit.troops.includes(:unit_option).each do |troop|
    #     unless troop.unit_option.nil?
    #       @troops.push troop unless troop.unit_option.unit.id == unit.id
    #     end
    #   end
    # 
    #   unit.equipments.includes(:troop).each do |equipment|
    #     unless equipment.troop.nil?
    #       @equipments.push equipment unless equipment.troop.unit.id == unit.id
    #     end
    #   end
    # 
    #   unit.special_rules.includes(:troop).each do |special_rule|
    #     unless special_rule.troop.nil?
    #       @special_rules.push special_rule unless special_rule.troop.unit.id == unit.id
    #     end
    #   end
    # 
    #   unit.unit_options.includes(:parent).each do |unit_option|
    #     unless unit_option.parent.nil?
    #       @unit_options.push unit_option unless unit_option.parent.unit.id == unit.id
    #     end
    #   end
    # end

    columns do

      column do
        if @troops.any?
          panel "Troops inconsistency" do
            table_for @troops do
              column :id
              column :name
              column "Unit" do |troop|
                link_to troop.unit.name, admin_unit_path(troop.unit)
              end
              column "Unit's unit option" do |troop|
                link_to troop.unit_option.unit.name, admin_unit_path(troop.unit_option.unit)
              end
              column do |troop|
                link_to "Voir", admin_troop_path(troop)
              end
            end
          end
        end

        if @equipments.any?
          panel "Equipments inconsistency" do
            table_for @equipments do
              column :id
              column :name
              column "Unit" do |equipment|
                link_to equipment.unit.name, admin_unit_path(equipment.unit)
              end
              column "Unit's troop" do |equipment|
                link_to equipment.troop.unit.name, admin_unit_path(equipment.troop.unit)
              end
              column do |equipment|
                link_to "Voir", admin_equipment_path(equipment)
              end
            end
          end
        end

        if @special_rules.any?
          panel "Special rules inconsistency" do
            table_for @special_rules do
              column :id
              column :name
              column "Unit" do |special_rule|
                link_to special_rule.unit.name, admin_unit_path(special_rule.unit)
              end
              column "Unit's troop" do |special_rule|
                link_to special_rule.troop.unit.name, admin_unit_path(special_rule.troop.unit)
              end
              column do |special_rule|
                link_to "Voir", admin_special_rule_path(special_rule)
              end
            end
          end
        end

        if @unit_options.any?
          panel "Options inconsistency" do
            table_for @unit_options do
              column :id
              column :name
              column "Unit" do |unit_option|
                link_to unit_option.unit.name, admin_unit_path(unit_option.unit)
              end
              column "Unit's parent" do |unit_option|
                link_to unit_option.parent.unit.name, admin_unit_path(unit_option.parent.unit)
              end
              column do |unit_option|
                link_to "Voir", admin_unit_option_path(unit_option)
              end
            end
          end
        end

      end # column

      column do
        panel "How to create a full stack Unit" do
          ol do
            li link_to "New Unit", new_admin_unit_path
            li link_to "New Troop", new_admin_troop_path
            li link_to "New Equipment", new_admin_equipment_path
            li link_to "New Special Rule", new_admin_special_rule_path
            li link_to "New Unit Option", new_admin_unit_option_path
          end
        end

        panel "Top 10 users" do
          ol do
            @users[0..9].each do |user|
              li link_to user.name, admin_user_path(user)
            end
          end
        end
      end # column

    end # columns

  end # content

end
