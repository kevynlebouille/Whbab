# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140904200602) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "armies", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "army_list_unit_troops", :force => true do |t|
    t.integer "army_list_unit_id", :null => false
    t.integer "troop_id",          :null => false
    t.integer "size"
    t.integer "position"
  end

  add_index "army_list_unit_troops", ["army_list_unit_id"], :name => "index_army_list_unit_troops_on_army_list_unit_id"
  add_index "army_list_unit_troops", ["troop_id"], :name => "index_army_list_unit_troops_on_troop_id"

  create_table "army_list_units", :force => true do |t|
    t.integer  "army_list_id"
    t.integer  "unit_id"
    t.integer  "unit_category_id"
    t.string   "name"
    t.decimal  "value_points",     :precision => 7, :scale => 1
    t.integer  "size"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.string   "magic"
  end

  add_index "army_list_units", ["army_list_id"], :name => "index_army_list_units_on_army_list_id"
  add_index "army_list_units", ["unit_category_id"], :name => "index_army_list_units_on_unit_category_id"
  add_index "army_list_units", ["unit_id"], :name => "index_army_list_units_on_unit_id"

  create_table "army_list_units_extra_items", :id => false, :force => true do |t|
    t.integer "army_list_unit_id", :null => false
    t.integer "extra_item_id",     :null => false
  end

  add_index "army_list_units_extra_items", ["army_list_unit_id"], :name => "index_army_list_units_extra_items_on_army_list_unit_id"
  add_index "army_list_units_extra_items", ["extra_item_id"], :name => "index_army_list_units_extra_items_on_extra_item_id"

  create_table "army_list_units_magic_items", :force => true do |t|
    t.integer "army_list_unit_id",                :null => false
    t.integer "magic_item_id",                    :null => false
    t.integer "quantity",          :default => 1, :null => false
  end

  add_index "army_list_units_magic_items", ["army_list_unit_id"], :name => "index_army_list_units_magic_items_on_army_list_unit_id"
  add_index "army_list_units_magic_items", ["magic_item_id"], :name => "index_army_list_units_magic_items_on_magic_item_id"

  create_table "army_list_units_magic_standards", :id => false, :force => true do |t|
    t.integer "army_list_unit_id", :null => false
    t.integer "magic_standard_id", :null => false
  end

  add_index "army_list_units_magic_standards", ["army_list_unit_id"], :name => "index_army_list_units_magic_standards_on_army_list_unit_id"
  add_index "army_list_units_magic_standards", ["magic_standard_id"], :name => "index_army_list_units_magic_standards_on_magic_standard_id"

  create_table "army_list_units_unit_options", :id => false, :force => true do |t|
    t.integer "army_list_unit_id", :null => false
    t.integer "unit_option_id",    :null => false
  end

  add_index "army_list_units_unit_options", ["army_list_unit_id"], :name => "index_army_list_units_unit_options_on_army_list_unit_id"
  add_index "army_list_units_unit_options", ["unit_option_id"], :name => "index_army_list_units_unit_options_on_unit_option_id"

  create_table "army_lists", :force => true do |t|
    t.integer  "army_id",                                    :null => false
    t.integer  "user_id",                                    :null => false
    t.string   "name",                                       :null => false
    t.decimal  "value_points", :precision => 7, :scale => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
  end

  add_index "army_lists", ["army_id"], :name => "index_army_lists_on_army_id"
  add_index "army_lists", ["user_id"], :name => "index_army_lists_on_user_id"

  create_table "equipments", :force => true do |t|
    t.integer "unit_id",  :null => false
    t.string  "name",     :null => false
    t.integer "position", :null => false
    t.integer "troop_id"
  end

  add_index "equipments", ["troop_id"], :name => "index_equipments_on_troop_id"
  add_index "equipments", ["unit_id"], :name => "index_equipments_on_unit_id"

  create_table "extra_item_categories", :force => true do |t|
    t.integer "army_id", :null => false
    t.string  "name",    :null => false
  end

  add_index "extra_item_categories", ["army_id"], :name => "index_extra_item_categories_on_army_id"

  create_table "extra_items", :force => true do |t|
    t.integer "extra_item_category_id",                               :null => false
    t.string  "name",                                                 :null => false
    t.decimal "value_points",           :precision => 7, :scale => 1, :null => false
  end

  add_index "extra_items", ["extra_item_category_id"], :name => "index_extra_items_on_extra_item_category_id"

  create_table "magic_item_categories", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "magic_items", :force => true do |t|
    t.integer "magic_item_category_id",                                                  :null => false
    t.integer "army_id"
    t.string  "name",                                                                    :null => false
    t.decimal "value_points",           :precision => 7, :scale => 1,                    :null => false
    t.integer "override_id"
    t.boolean "is_multiple",                                          :default => false, :null => false
  end

  add_index "magic_items", ["army_id"], :name => "index_magic_items_on_army_id"
  add_index "magic_items", ["magic_item_category_id"], :name => "index_magic_items_on_magic_item_category_id"
  add_index "magic_items", ["override_id"], :name => "index_magic_items_on_override_id"

  create_table "magic_standards", :force => true do |t|
    t.integer "army_id"
    t.string  "name",         :null => false
    t.integer "value_points", :null => false
    t.integer "override_id"
  end

  add_index "magic_standards", ["army_id"], :name => "index_magic_standards_on_army_id"
  add_index "magic_standards", ["override_id"], :name => "index_magic_standards_on_override_id"

  create_table "special_rules", :force => true do |t|
    t.integer "unit_id",  :null => false
    t.string  "name",     :null => false
    t.integer "position", :null => false
    t.integer "troop_id"
  end

  add_index "special_rules", ["troop_id"], :name => "index_special_rules_on_troop_id"
  add_index "special_rules", ["unit_id"], :name => "index_special_rules_on_unit_id"

  create_table "troop_types", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "troops", :force => true do |t|
    t.integer "unit_id",                                                   :null => false
    t.integer "troop_type_id"
    t.string  "name",                                                      :null => false
    t.decimal "value_points",                :precision => 7, :scale => 1
    t.integer "position",                                                  :null => false
    t.string  "M",              :limit => 5
    t.string  "WS",             :limit => 5
    t.string  "BS",             :limit => 5
    t.string  "S",              :limit => 5
    t.string  "T",              :limit => 5
    t.string  "W",              :limit => 5
    t.string  "I",              :limit => 5
    t.string  "A",              :limit => 5
    t.string  "LD",             :limit => 5
    t.integer "min_size"
    t.integer "unit_option_id"
  end

  add_index "troops", ["troop_type_id"], :name => "index_troops_on_troop_type_id"
  add_index "troops", ["unit_id"], :name => "index_troops_on_unit_id"
  add_index "troops", ["unit_option_id"], :name => "index_troops_on_unit_option_id"

  create_table "unit_categories", :force => true do |t|
    t.string  "name",      :null => false
    t.integer "min_quota"
    t.integer "max_quota"
  end

  create_table "unit_options", :force => true do |t|
    t.integer "unit_id",                                          :null => false
    t.integer "parent_id"
    t.string  "name",                                             :null => false
    t.decimal "value_points",       :precision => 7, :scale => 1
    t.integer "position",                                         :null => false
    t.boolean "is_per_model",                                     :null => false
    t.boolean "is_magic_items",                                   :null => false
    t.boolean "is_magic_standards",                               :null => false
    t.boolean "is_unique_choice",                                 :null => false
    t.boolean "is_extra_items",                                   :null => false
    t.integer "mount_id"
  end

  add_index "unit_options", ["mount_id"], :name => "index_unit_options_on_mount_id"
  add_index "unit_options", ["parent_id"], :name => "index_unit_options_on_parent_id"
  add_index "unit_options", ["unit_id"], :name => "index_unit_options_on_unit_id"

  create_table "units", :force => true do |t|
    t.integer "army_id",                                                           :null => false
    t.integer "unit_category_id",                                                  :null => false
    t.string  "name",                                                              :null => false
    t.integer "min_size",                                       :default => 1,     :null => false
    t.integer "max_size"
    t.decimal "value_points",     :precision => 7, :scale => 1
    t.string  "magic"
    t.text    "notes"
    t.boolean "is_unique",                                      :default => false, :null => false
  end

  add_index "units", ["army_id"], :name => "index_units_on_army_id"
  add_index "units", ["unit_category_id"], :name => "index_units_on_unit_category_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "favorite_army_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["favorite_army_id"], :name => "index_users_on_favorite_army_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
