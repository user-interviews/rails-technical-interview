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

ActiveRecord::Schema.define(version: 20180527211709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "project_accesses", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.boolean  "owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "project_accesses", ["project_id", "user_id"], name: "index_project_accesses_on_project_id_and_user_id", unique: true, using: :btree
  add_index "project_accesses", ["project_id"], name: "index_project_accesses_on_project_id", using: :btree
  add_index "project_accesses", ["user_id"], name: "index_project_accesses_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "compensation_amount"
    t.string   "internal_name"
    t.integer  "interview_type"
    t.string   "public_title"
    t.integer  "requested_participants"
    t.datetime "charged_at"
    t.datetime "launched_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_remember_tokens", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.string   "token_digest", null: false
    t.datetime "last_used_at", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "user_remember_tokens", ["user_id", "token_digest"], name: "index_user_remember_tokens_on_user_id_and_token_digest", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "project_accesses", "projects"
  add_foreign_key "project_accesses", "users"
  add_foreign_key "user_remember_tokens", "users"
end
