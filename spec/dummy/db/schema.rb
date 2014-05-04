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

ActiveRecord::Schema.define(version: 20140502043304) do

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "strategy"
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.integer  "sessions_count",             default: 0
    t.string   "password_token_digest"
    t.datetime "password_token_digested_at"
    t.string   "email_token_digest"
    t.datetime "email_confirmed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "sessions", force: true do |t|
    t.integer  "user_id"
    t.integer  "identity_id"
    t.string   "ua"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["identity_id"], name: "index_sessions_on_identity_id"
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id"

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "role",             default: "user"
    t.integer  "identities_count", default: 0
    t.integer  "sessions_count",   default: 0
    t.string   "city"
  end

end
