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

ActiveRecord::Schema.define(:version => 20130413064521) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "views_count",  :default => 0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "ip_address"
    t.integer  "legacy_id"
    t.boolean  "published",    :default => true
    t.datetime "published_at"
    t.datetime "deleted_at"
    t.integer  "deleter_id"
    t.boolean  "sticky",       :default => false
  end

  add_index "articles", ["deleted_at"], :name => "index_articles_on_deleted_at"
  add_index "articles", ["deleter_id"], :name => "index_articles_on_deleter_id"
  add_index "articles", ["ip_address"], :name => "index_articles_on_ip_address"
  add_index "articles", ["legacy_id"], :name => "index_articles_on_legacy_id"
  add_index "articles", ["published"], :name => "index_articles_on_published"
  add_index "articles", ["sticky"], :name => "index_articles_on_sticky"
  add_index "articles", ["user_id"], :name => "index_articles_on_user_id"

  create_table "chat_messages", :force => true do |t|
    t.string   "body"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "chat_messages", ["user_id"], :name => "index_chat_messages_on_user_id"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.string   "title",            :default => ""
    t.text     "comment",                          :null => false
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "ip_address"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["ip_address"], :name => "index_comments_on_ip_address"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "countries", ["name"], :name => "index_countries_on_name", :unique => true

  create_table "pages", :force => true do |t|
    t.string   "permalink",                      :null => false
    t.string   "title",                          :null => false
    t.text     "content",                        :null => false
    t.string   "description"
    t.string   "keywords"
    t.boolean  "enabled",     :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "pages", ["enabled"], :name => "index_pages_on_enabled"
  add_index "pages", ["permalink"], :name => "index_pages_on_permalink", :unique => true
  add_index "pages", ["title"], :name => "index_pages_on_title", :unique => true

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "country_id"
    t.string   "race"
    t.string   "bnet_name"
    t.string   "bnet_server"
    t.string   "league"
    t.integer  "experience"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "details"
    t.string   "avatar_style"
    t.integer  "achievements"
    t.integer  "rank"
    t.integer  "points"
    t.integer  "wins"
    t.integer  "loses"
    t.string   "win_rate"
    t.string   "profile_url"
    t.datetime "synchronized_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "profiles", ["country_id"], :name => "index_profiles_on_country_id"
  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "username"
    t.string   "legacy_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "roles"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["roles"], :name => "index_users_on_roles"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
