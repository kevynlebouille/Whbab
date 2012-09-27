ActiveAdmin.register_page "Dashboard" do

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do

      column do
        panel "How to create a full stack Unit" do
          ol do
            li link_to("New Unit", new_admin_unit_path)
            li link_to("New Troop", new_admin_troop_path)
            li link_to("New Equipment", new_admin_equipment_path)
            li link_to("New Special Rule", new_admin_special_rule_path)
            li link_to("New Unit Option", new_admin_unit_option_path)
          end
        end
      end

    end # columns

  end # content

end
