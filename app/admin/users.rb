ActiveAdmin.register User do
  filter :email
  filter :name

  index do
    column :id
    column :email
    column :name
    column :created_at
    column :updated_at
    default_actions
  end
end
