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

ActiveRecord::Schema.define(version: 20150726220026) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "entry_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["entry_id"], name: "index_comments_on_entry_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "edit_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "entry_id"
    t.text     "title"
    t.text     "body"
    t.text     "old_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "edit_requests", ["entry_id"], name: "index_edit_requests_on_entry_id"
  add_index "edit_requests", ["user_id"], name: "index_edit_requests_on_user_id"

  create_table "entries", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "tag_string"
  end

  add_index "entries", ["user_id"], name: "index_entries_on_user_id"

  create_table "entry_tags", force: :cascade do |t|
    t.integer  "entry_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "entry_tags", ["entry_id"], name: "index_entry_tags_on_entry_id"
  add_index "entry_tags", ["tag_id"], name: "index_entry_tags_on_tag_id"

  create_table "feeds", force: :cascade do |t|
    t.integer  "feed_type"
    t.integer  "user_id"
    t.integer  "tag_id"
    t.integer  "entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "feeds", ["entry_id"], name: "index_feeds_on_entry_id"
  add_index "feeds", ["tag_id"], name: "index_feeds_on_tag_id"
  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id"

  create_table "follow_users", force: :cascade do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "infos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "info_type"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "infos", ["user_id"], name: "index_infos_on_user_id"

  create_table "tags", force: :cascade do |t|
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_entries", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_entries", ["entry_id"], name: "index_user_entries_on_entry_id"
  add_index "user_entries", ["user_id"], name: "index_user_entries_on_user_id"

  create_table "user_tags", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_tags", ["tag_id"], name: "index_user_tags_on_tag_id"
  add_index "user_tags", ["user_id"], name: "index_user_tags_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
