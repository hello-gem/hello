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

ActiveRecord::Schema.define(version: 20140920192959) do

  create_table "accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "user_agent_string"
    t.string   "token"
    t.string   "ip"
    t.datetime "expires_at",        default: '2000-01-01 00:00:00'
    t.datetime "sudo_expires_at",   default: '2000-01-01 00:00:00'
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["token"], name: "index_accesses_on_token"
    t.index ["user_id"], name: "index_accesses_on_user_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "credentials", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "type"
    t.string   "uid"
    t.string   "email"
    t.string   "digest"
    t.datetime "confirmed_at"
    t.string   "verifying_token_digest"
    t.datetime "verifying_token_digested_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_credentials_on_user_id"
  end

  create_table "some_credential_data", force: :cascade do |t|
    t.integer  "credential_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["credential_id"], name: "index_some_credential_data_on_credential_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "role",              default: "onboarding"
    t.string   "locale"
    t.string   "time_zone"
    t.string   "username"
    t.integer  "credentials_count", default: 0
    t.integer  "accesses_count",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
