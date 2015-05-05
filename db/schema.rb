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

ActiveRecord::Schema.define(version: 20150505111126) do

  create_table "events", force: :cascade do |t|
    t.text     "title",      limit: 65535
    t.date     "eventdate"
    t.time     "eventstart"
    t.time     "eventend"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "user_id",    limit: 4
    t.boolean  "is_private", limit: 1,     default: false
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "firstname",  limit: 255
    t.string   "lastname",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "people_roles", id: false, force: :cascade do |t|
    t.integer  "person_id",  limit: 4
    t.integer  "role_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "people_roles", ["person_id"], name: "index_people_roles_on_person_id", using: :btree
  add_index "people_roles", ["role_id"], name: "index_people_roles_on_role_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "templates", force: :cascade do |t|
    t.string   "title",      limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token",             limit: 255, default: ""
    t.string   "username",               limit: 255
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "volunteersheets", force: :cascade do |t|
    t.string   "about",       limit: 255, default: ""
    t.integer  "rowindex",    limit: 4,   default: 1,  null: false
    t.integer  "role_id",     limit: 4
    t.integer  "person_id",   limit: 4
    t.integer  "event_id",    limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "template_id", limit: 4
  end

  add_index "volunteersheets", ["event_id"], name: "index_volunteersheets_on_event_id", using: :btree
  add_index "volunteersheets", ["person_id"], name: "index_volunteersheets_on_person_id", using: :btree
  add_index "volunteersheets", ["role_id"], name: "index_volunteersheets_on_role_id", using: :btree
  add_index "volunteersheets", ["template_id"], name: "index_volunteersheets_on_template_id", using: :btree

  add_foreign_key "events", "users"
  add_foreign_key "people_roles", "people"
  add_foreign_key "people_roles", "roles"
  add_foreign_key "volunteersheets", "events"
  add_foreign_key "volunteersheets", "people"
  add_foreign_key "volunteersheets", "roles"
  add_foreign_key "volunteersheets", "templates"
end
