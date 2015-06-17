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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130525145743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "views_count",  default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "ip_address"
    t.integer  "legacy_id"
    t.boolean  "published",    default: true
    t.datetime "published_at"
    t.datetime "deleted_at"
    t.integer  "deleter_id"
    t.boolean  "sticky",       default: false
    t.boolean  "tweeted",      default: false
  end

  add_index "articles", ["deleted_at"], name: "index_articles_on_deleted_at", using: :btree
  add_index "articles", ["deleter_id"], name: "index_articles_on_deleter_id", using: :btree
  add_index "articles", ["ip_address"], name: "index_articles_on_ip_address", using: :btree
  add_index "articles", ["legacy_id"], name: "index_articles_on_legacy_id", using: :btree
  add_index "articles", ["published"], name: "index_articles_on_published", using: :btree
  add_index "articles", ["sticky"], name: "index_articles_on_sticky", using: :btree
  add_index "articles", ["tweeted"], name: "index_articles_on_tweeted", using: :btree
  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "chat_messages", force: true do |t|
    t.string   "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chat_messages", ["user_id"], name: "index_chat_messages_on_user_id", using: :btree

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: true do |t|
    t.string   "title",            default: ""
    t.text     "comment",                       null: false
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "ip_address"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["ip_address"], name: "index_comments_on_ip_address", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "countries", ["name"], name: "index_countries_on_name", unique: true, using: :btree

  create_table "invites", force: true do |t|
    t.integer  "team_id",                        null: false
    t.integer  "user_id",                        null: false
    t.integer  "leader_id",                      null: false
    t.string   "status",     default: "pending", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "invites", ["leader_id"], name: "index_invites_on_leader_id", using: :btree
  add_index "invites", ["team_id"], name: "index_invites_on_team_id", using: :btree
  add_index "invites", ["user_id"], name: "index_invites_on_user_id", using: :btree

  create_table "our_friends", force: true do |t|
    t.string   "title",                     null: false
    t.string   "url",                       null: false
    t.string   "image"
    t.boolean  "visible",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "our_friends", ["visible"], name: "index_our_friends_on_visible", using: :btree

  create_table "pages", force: true do |t|
    t.string   "permalink",                   null: false
    t.string   "title",                       null: false
    t.text     "content",                     null: false
    t.string   "description"
    t.string   "keywords"
    t.boolean  "enabled",     default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "pages", ["enabled"], name: "index_pages_on_enabled", using: :btree
  add_index "pages", ["permalink"], name: "index_pages_on_permalink", unique: true, using: :btree
  add_index "pages", ["title"], name: "index_pages_on_title", unique: true, using: :btree

  create_table "profiles", force: true do |t|
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
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "profiles", ["country_id"], name: "index_profiles_on_country_id", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "teams", force: true do |t|
    t.integer  "leader_id"
    t.string   "name",        null: false
    t.string   "slug",        null: false
    t.string   "logo"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "teams", ["leader_id"], name: "index_teams_on_leader_id", unique: true, using: :btree
  add_index "teams", ["slug"], name: "index_teams_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "username"
    t.string   "legacy_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "roles"
    t.integer  "team_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["roles"], name: "index_users_on_roles", using: :btree
  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
