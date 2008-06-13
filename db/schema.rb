# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080613115813) do

  create_table "bookmark_accounts", :force => true do |t|
    t.integer  "user_id",    :limit => 11, :null => false
    t.string   "service"
    t.string   "login"
    t.string   "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id",           :limit => 11
    t.integer  "parent_comment_id", :limit => 11
    t.text     "body",                                               :null => false
    t.integer  "user_id",           :limit => 11
    t.string   "user_email"
    t.string   "user_website"
    t.boolean  "published",                       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "user_name"
    t.boolean  "subscribed",                      :default => false
    t.integer  "site_id",           :limit => 11
  end

  create_table "goldberg_content_pages", :force => true do |t|
    t.string   "title"
    t.string   "name"
    t.integer  "markup_style_id", :limit => 11
    t.text     "content"
    t.integer  "permission_id",   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content_cache"
    t.string   "markup_style"
  end

  add_index "goldberg_content_pages", ["permission_id"], :name => "fk_content_page_permission_id"
  add_index "goldberg_content_pages", ["markup_style_id"], :name => "fk_content_page_markup_style_id"

  create_table "goldberg_controller_actions", :force => true do |t|
    t.integer "site_controller_id", :limit => 11
    t.string  "name"
    t.integer "permission_id",      :limit => 11
    t.string  "url_to_use"
  end

  add_index "goldberg_controller_actions", ["permission_id"], :name => "fk_controller_action_permission_id"
  add_index "goldberg_controller_actions", ["site_controller_id"], :name => "fk_controller_action_site_controller_id"

  create_table "goldberg_menu_items", :force => true do |t|
    t.integer "parent_id",            :limit => 11
    t.string  "name"
    t.string  "label"
    t.integer "seq",                  :limit => 11
    t.integer "controller_action_id", :limit => 11
    t.integer "content_page_id",      :limit => 11
  end

  add_index "goldberg_menu_items", ["controller_action_id"], :name => "fk_menu_item_controller_action_id"
  add_index "goldberg_menu_items", ["content_page_id"], :name => "fk_menu_item_content_page_id"
  add_index "goldberg_menu_items", ["parent_id"], :name => "fk_menu_item_parent_id"

  create_table "goldberg_permissions", :force => true do |t|
    t.string "name", :default => ""
  end

  create_table "goldberg_roles", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id",       :limit => 11
    t.string   "description",                   :default => "", :null => false
    t.integer  "default_page_id", :limit => 11
    t.text     "cache"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "start_path"
  end

  add_index "goldberg_roles", ["parent_id"], :name => "fk_role_parent_id"
  add_index "goldberg_roles", ["default_page_id"], :name => "fk_role_default_page_id"

  create_table "goldberg_roles_permissions", :force => true do |t|
    t.integer "role_id",       :limit => 11
    t.integer "permission_id", :limit => 11
  end

  add_index "goldberg_roles_permissions", ["role_id"], :name => "fk_roles_permission_role_id"
  add_index "goldberg_roles_permissions", ["permission_id"], :name => "fk_roles_permission_permission_id"

  create_table "goldberg_site_controllers", :force => true do |t|
    t.string  "name"
    t.integer "permission_id", :limit => 11
    t.integer "builtin",       :limit => 11, :default => 0
  end

  add_index "goldberg_site_controllers", ["permission_id"], :name => "fk_site_controller_permission_id"

  create_table "goldberg_system_settings", :force => true do |t|
    t.string  "site_name"
    t.string  "site_subtitle"
    t.string  "footer_message",                                    :default => ""
    t.integer "public_role_id",                      :limit => 11
    t.integer "session_timeout",                     :limit => 11, :default => 0,  :null => false
    t.integer "site_default_page_id",                :limit => 11
    t.integer "not_found_page_id",                   :limit => 11
    t.integer "permission_denied_page_id",           :limit => 11
    t.integer "session_expired_page_id",             :limit => 11
    t.integer "menu_depth",                          :limit => 11, :default => 0,  :null => false
    t.string  "start_path"
    t.string  "site_url_prefix"
    t.boolean "self_reg_enabled"
    t.integer "self_reg_role_id",                    :limit => 11
    t.boolean "self_reg_confirmation_required"
    t.integer "self_reg_confirmation_error_page_id", :limit => 11
    t.boolean "self_reg_send_confirmation_email"
  end

  add_index "goldberg_system_settings", ["public_role_id"], :name => "fk_system_settings_public_role_id"
  add_index "goldberg_system_settings", ["site_default_page_id"], :name => "fk_system_settings_site_default_page_id"
  add_index "goldberg_system_settings", ["not_found_page_id"], :name => "fk_system_settings_not_found_page_id"
  add_index "goldberg_system_settings", ["permission_denied_page_id"], :name => "fk_system_settings_permission_denied_page_id"
  add_index "goldberg_system_settings", ["session_expired_page_id"], :name => "fk_system_settings_session_expired_page_id"

  create_table "goldberg_users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.integer  "role_id",                        :limit => 11
    t.string   "password_salt"
    t.string   "fullname"
    t.string   "email"
    t.string   "start_path"
    t.boolean  "self_reg_confirmation_required"
    t.string   "confirmation_key"
    t.datetime "password_changed_at"
    t.boolean  "password_expired"
    t.string   "website"
  end

  add_index "goldberg_users", ["role_id"], :name => "fk_user_role_id"

  create_table "newsletter_users", :force => true do |t|
    t.integer  "user_id",       :limit => 11, :null => false
    t.integer  "newsletter_id", :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "newsletter_users", ["user_id", "newsletter_id"], :name => "index_newsletter_users_on_user_id_and_newsletter_id", :unique => true

  create_table "newsletters", :force => true do |t|
    t.string   "title",       :default => "", :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plugin_schema_info", :id => false, :force => true do |t|
    t.string  "plugin_name"
    t.integer "version",     :limit => 11
  end

  create_table "posts", :force => true do |t|
    t.string   "title",                         :default => "",    :null => false
    t.string   "excerpt",                       :default => "",    :null => false
    t.text     "body",                                             :null => false
    t.datetime "published_at",                                     :null => false
    t.boolean  "published",                     :default => false
    t.string   "permalink",                     :default => "",    :null => false
    t.integer  "user_id",         :limit => 11,                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",  :limit => 11, :default => 0
    t.string   "cached_tag_list",               :default => ""
  end

  create_table "site_assets", :force => true do |t|
    t.integer  "size",         :limit => 11
    t.string   "content_type"
    t.string   "filename",                   :default => "", :null => false
    t.integer  "height",       :limit => 11
    t.integer  "width",        :limit => 11
    t.integer  "parent_id",    :limit => 11
    t.string   "thumbnail"
    t.integer  "user_id",      :limit => 11,                 :null => false
    t.integer  "site_id",      :limit => 11
    t.integer  "position",     :limit => 11, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_assets", ["site_id"], :name => "site_id"

  create_table "sites", :force => true do |t|
    t.string   "title",                            :default => "",    :null => false
    t.string   "url",                              :default => "",    :null => false
    t.string   "owner",                            :default => "",    :null => false
    t.text     "description",                                         :null => false
    t.integer  "user_id",            :limit => 11,                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",     :limit => 11, :default => 0
    t.string   "permalink"
    t.boolean  "published",                        :default => false
    t.string   "thumbnail_filename"
    t.boolean  "featured",                         :default => false
    t.string   "cached_tag_list",                  :default => ""
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",        :limit => 11
    t.integer  "taggable_id",   :limit => 11
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

end
